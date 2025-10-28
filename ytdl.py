#!/usr/bin/env python3
"""
YT-DLP CLI - Interface interativa para download de vídeos
"""

import subprocess
import sys
import os
from pathlib import Path
from typing import Optional, List
import inquirer
from rich.console import Console
from rich.panel import Panel
from rich.progress import Progress, SpinnerColumn, TextColumn
from rich.table import Table
from rich import print as rprint

console = Console()


class YTDLPDownloader:
    """Classe principal para gerenciar downloads com yt-dlp"""

    def __init__(self):
        self.download_path = str(Path.home() / "Downloads")
        self.presets = {
            "video_best": {
                "name": "Vídeo (Melhor Qualidade MP4)",
                "args": ["-f", "bv*[vcodec^=avc]+ba[acodec^=mp4a]/bv*+ba/b", "--merge-output-format", "mp4", "--remux-video", "mp4"]
            },
            "video_compact": {
                "name": "Vídeo Compacto (Arquivo Menor - 720p)",
                "args": ["-f", "bv*[height<=720][ext=mp4]+ba[ext=m4a]/bv*[height<=720]+ba", "--merge-output-format", "mp4", "--recode-video", "mp4"]
            },
            "video_small": {
                "name": "Vídeo Pequeno (Arquivo Muito Menor - 480p)",
                "args": ["-f", "bv*[height<=480][ext=mp4]+ba[ext=m4a]/bv*[height<=480]+ba", "--merge-output-format", "mp4", "--recode-video", "mp4"]
            },
            "audio_mp3": {
                "name": "Áudio MP3",
                "args": ["-x", "--audio-format", "mp3"]
            },
            "with_subtitles": {
                "name": "Vídeo com Legendas (EN)",
                "args": ["-f", "bv*[vcodec^=avc]+ba[acodec^=mp4a]/bv*+ba/b", "--write-srt", "--sub-lang", "en", "--merge-output-format", "mp4", "--remux-video", "mp4"]
            },
            "auto_subtitles": {
                "name": "Vídeo com Legendas Auto",
                "args": ["-f", "bv*[vcodec^=avc]+ba[acodec^=mp4a]/bv*+ba/b", "--write-auto-sub", "--merge-output-format", "mp4", "--remux-video", "mp4"]
            },
            "playlist_audio": {
                "name": "Playlist Completa (Áudio MP3)",
                "args": ["--yes-playlist", "-x", "--audio-format", "mp3"]
            },
            "playlist_video": {
                "name": "Playlist Completa (Vídeo MP4)",
                "args": ["--yes-playlist", "-f", "bv*[vcodec^=avc]+ba[acodec^=mp4a]/bv*+ba/b", "--merge-output-format", "mp4", "--remux-video", "mp4"]
            }
        }

    def check_ytdlp(self) -> bool:
        """Verifica se yt-dlp está instalado"""
        try:
            subprocess.run(["yt-dlp", "--version"],
                         capture_output=True,
                         check=True)
            return True
        except (subprocess.CalledProcessError, FileNotFoundError):
            return False

    def set_download_path(self):
        """Define o diretório de download"""
        questions = [
            inquirer.Text('path',
                         message="Diretório de download",
                         default=self.download_path)
        ]
        answers = inquirer.prompt(questions)
        if answers:
            path = Path(answers['path']).expanduser()
            if not path.exists():
                if inquirer.confirm(f"Diretório não existe. Criar {path}?", default=True):
                    path.mkdir(parents=True, exist_ok=True)
                    self.download_path = str(path)
                    console.print(f"[green]✓[/green] Diretório criado: {path}")
            else:
                self.download_path = str(path)
                console.print(f"[green]✓[/green] Diretório configurado: {path}")

    def list_playlist(self, url: str):
        """Lista itens de uma playlist sem baixar"""
        console.print("\n[yellow]Listando playlist...[/yellow]")
        try:
            result = subprocess.run(
                ["yt-dlp", "--flat-playlist", url],
                capture_output=True,
                text=True,
                cwd=self.download_path
            )
            console.print(result.stdout)
            if result.returncode == 0:
                console.print("[green]✓[/green] Listagem concluída")
            else:
                console.print(f"[red]✗[/red] Erro: {result.stderr}")
        except Exception as e:
            console.print(f"[red]✗[/red] Erro ao listar: {e}")

    def download(self, url: str, preset: Optional[str] = None,
                 extra_args: Optional[List[str]] = None):
        """Executa o download com yt-dlp"""

        # Monta comando base
        cmd = ["yt-dlp"]

        # Adiciona preset se selecionado
        if preset and preset in self.presets:
            cmd.extend(self.presets[preset]["args"])

        # Adiciona argumentos extras
        if extra_args:
            cmd.extend(extra_args)

        # Adiciona URL
        cmd.append(url)

        # Mostra comando que será executado
        console.print(f"\n[cyan]Executando:[/cyan] {' '.join(cmd)}")
        console.print(f"[cyan]Diretório:[/cyan] {self.download_path}\n")

        # Executa download
        try:
            result = subprocess.run(
                cmd,
                cwd=self.download_path,
                text=True
            )

            if result.returncode == 0:
                console.print("\n[green]✓[/green] Download concluído com sucesso!")
            else:
                console.print(f"\n[red]✗[/red] Download finalizado com código: {result.returncode}")

        except KeyboardInterrupt:
            console.print("\n[yellow]![/yellow] Download cancelado pelo usuário")
        except Exception as e:
            console.print(f"\n[red]✗[/red] Erro: {e}")

    def quick_download(self):
        """Download rápido com URL"""
        questions = [
            inquirer.Text('url', message="URL do vídeo/playlist"),
            inquirer.List('preset',
                         message="Selecione o tipo de download",
                         choices=[(v["name"], k) for k, v in self.presets.items()])
        ]

        answers = inquirer.prompt(questions)
        if not answers:
            return

        url = answers['url'].strip()
        preset = answers['preset']

        if not url:
            console.print("[red]✗[/red] URL inválida")
            return

        self.download(url, preset=preset)

    def advanced_download(self):
        """Download com opções avançadas"""
        questions = [
            inquirer.Text('url', message="URL do vídeo/playlist"),
        ]
        answers = inquirer.prompt(questions)
        if not answers:
            return

        url = answers['url'].strip()
        if not url:
            console.print("[red]✗[/red] URL inválida")
            return

        # Opções avançadas
        advanced_q = [
            inquirer.Checkbox('options',
                             message="Opções adicionais (use ESPAÇO para selecionar)",
                             choices=[
                                 ('Apenas listar (não baixar)', 'list_only'),
                                 ('Trim filename (20 caracteres)', 'trim'),
                                 ('Usar apenas ID do vídeo como nome', 'use_id'),
                                 ('Legendas enviadas (EN)', 'subtitles'),
                                 ('Legendas automáticas', 'auto_subs'),
                                 ('Ignorar erros em playlist', 'ignore_errors')
                             ])
        ]

        adv_answers = inquirer.prompt(advanced_q)
        if not adv_answers:
            return

        options = adv_answers['options']

        # Se apenas listar
        if 'list_only' in options:
            self.list_playlist(url)
            return

        # Monta argumentos extras
        extra_args = []

        if 'trim' in options:
            extra_args.extend(['--trim-filenames', '20'])

        if 'use_id' in options:
            extra_args.append('--id')

        if 'subtitles' in options:
            extra_args.extend(['--write-srt', '--sub-lang', 'en'])

        if 'auto_subs' in options:
            extra_args.append('--write-auto-sub')

        if 'ignore_errors' in options:
            extra_args.append('-i')

        # Verifica se é playlist e se quer selecionar itens
        is_playlist = inquirer.confirm("É uma playlist?", default=False)

        if is_playlist:
            playlist_q = [
                inquirer.List('playlist_mode',
                             message="Modo de playlist",
                             choices=[
                                 ('Baixar toda a playlist', 'all'),
                                 ('Selecionar itens específicos', 'select')
                             ])
            ]
            pl_answer = inquirer.prompt(playlist_q)

            if pl_answer['playlist_mode'] == 'all':
                extra_args.append('--yes-playlist')
            else:
                items = inquirer.text(
                    message="Itens da playlist (ex: 1,3-15)"
                )
                if items:
                    extra_args.extend(['--playlist-items', items])

        # Formato de download
        format_q = [
            inquirer.List('format',
                         message="Formato de download",
                         choices=[
                             ('Vídeo (melhor qualidade MP4)', 'video'),
                             ('Áudio (MP3)', 'audio')
                         ])
        ]
        fmt_answer = inquirer.prompt(format_q)

        if fmt_answer['format'] == 'audio':
            extra_args.extend(['-x', '--audio-format', 'mp3'])
        else:
            extra_args.extend(['-f', 'bv*[vcodec^=avc]+ba[acodec^=mp4a]/bv*+ba/b', '--merge-output-format', 'mp4', '--remux-video', 'mp4'])

        self.download(url, extra_args=extra_args)

    def show_presets(self):
        """Mostra presets disponíveis"""
        table = Table(title="Presets Disponíveis")
        table.add_column("ID", style="cyan")
        table.add_column("Nome", style="green")
        table.add_column("Argumentos", style="yellow")

        for preset_id, preset_data in self.presets.items():
            table.add_row(
                preset_id,
                preset_data["name"],
                " ".join(preset_data["args"])
            )

        console.print(table)
        input("\nPressione ENTER para continuar...")


def show_header():
    """Mostra cabeçalho do programa"""
    console.clear()
    header = Panel.fit(
        "[bold cyan]YT-DLP CLI Downloader[/bold cyan]\n"
        "[dim]Interface interativa para download de vídeos[/dim]",
        border_style="cyan"
    )
    console.print(header)
    console.print()


def main():
    """Função principal"""

    downloader = YTDLPDownloader()

    # Verifica se yt-dlp está instalado
    if not downloader.check_ytdlp():
        console.print("[red]✗[/red] yt-dlp não encontrado!")
        console.print("\nPara instalar:")
        console.print("  [cyan]brew install yt-dlp[/cyan]")
        console.print("  ou")
        console.print("  [cyan]pip install yt-dlp[/cyan]")
        sys.exit(1)

    while True:
        show_header()

        # Menu principal
        questions = [
            inquirer.List('action',
                         message="O que deseja fazer?",
                         choices=[
                             ('Download Rápido (com presets)', 'quick'),
                             ('Download Avançado (personalizado)', 'advanced'),
                             ('Configurar diretório de download', 'config_dir'),
                             ('Ver presets disponíveis', 'show_presets'),
                             ('Sair', 'exit')
                         ])
        ]

        answers = inquirer.prompt(questions)

        if not answers or answers['action'] == 'exit':
            console.print("\n[cyan]Até logo![/cyan]")
            break

        action = answers['action']

        if action == 'quick':
            downloader.quick_download()
        elif action == 'advanced':
            downloader.advanced_download()
        elif action == 'config_dir':
            downloader.set_download_path()
        elif action == 'show_presets':
            downloader.show_presets()

        console.print()
        input("Pressione ENTER para continuar...")


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        console.print("\n[yellow]Programa interrompido[/yellow]")
        sys.exit(0)
