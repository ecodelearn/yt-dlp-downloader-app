#!/usr/bin/python3
"""
YT-DLP Desktop App - Interface gráfica moderna para download de vídeos
"""

import tkinter as tk
from tkinter import ttk, messagebox, filedialog, scrolledtext
import subprocess
import threading
import os
from pathlib import Path
import queue
import re


class YTDLPApp:
    def __init__(self, root):
        self.root = root
        self.root.title("YT-DLP Downloader")
        self.root.geometry("800x700")
        self.root.resizable(True, True)

        # Configurações
        self.download_path = str(Path.home() / "Downloads")
        self.output_queue = queue.Queue()
        self.is_downloading = False

        # Estilos
        style = ttk.Style()
        style.theme_use('aqua')  # Tema nativo do macOS

        self.setup_ui()
        self.check_dependencies()

    def setup_ui(self):
        """Configura a interface do usuário"""

        # Frame principal
        main_frame = ttk.Frame(self.root, padding="20")
        main_frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        self.root.columnconfigure(0, weight=1)
        self.root.rowconfigure(0, weight=1)
        main_frame.columnconfigure(0, weight=1)

        # Título
        title_label = ttk.Label(
            main_frame,
            text="YT-DLP Video Downloader",
            font=('Helvetica', 24, 'bold')
        )
        title_label.grid(row=0, column=0, pady=(0, 10))

        # URL Input
        url_frame = ttk.LabelFrame(main_frame, text="URL do Vídeo/Playlist", padding="10")
        url_frame.grid(row=1, column=0, sticky=(tk.W, tk.E), pady=10)
        url_frame.columnconfigure(0, weight=1)

        self.url_entry = ttk.Entry(url_frame, font=('Helvetica', 12))
        self.url_entry.grid(row=0, column=0, sticky=(tk.W, tk.E), padx=(0, 10))

        paste_btn = ttk.Button(url_frame, text="Colar", command=self.paste_url)
        paste_btn.grid(row=0, column=1)

        clear_btn = ttk.Button(url_frame, text="Limpar", command=self.clear_url)
        clear_btn.grid(row=0, column=2, padx=(5, 0))

        # Formato de Download
        format_frame = ttk.LabelFrame(main_frame, text="Formato de Download", padding="10")
        format_frame.grid(row=2, column=0, sticky=(tk.W, tk.E), pady=10)

        self.format_var = tk.StringVar(value="video_best")

        formats = [
            ("Vídeo (Melhor Qualidade MP4)", "video_best"),
            ("Vídeo Compacto (720p)", "video_720p"),
            ("Vídeo Pequeno (480p)", "video_480p"),
            ("Áudio MP3", "audio_mp3"),
            ("Vídeo com Legendas (EN)", "video_subs"),
            ("Playlist Completa (Vídeo)", "playlist_video"),
            ("Playlist Completa (Áudio)", "playlist_audio")
        ]

        for i, (text, value) in enumerate(formats):
            rb = ttk.Radiobutton(
                format_frame,
                text=text,
                variable=self.format_var,
                value=value
            )
            rb.grid(row=i, column=0, sticky=tk.W, pady=2)

        # Opções Avançadas
        options_frame = ttk.LabelFrame(main_frame, text="Opções Avançadas", padding="10")
        options_frame.grid(row=3, column=0, sticky=(tk.W, tk.E), pady=10)

        self.ignore_errors_var = tk.BooleanVar(value=True)
        ignore_cb = ttk.Checkbutton(
            options_frame,
            text="Ignorar erros em playlist",
            variable=self.ignore_errors_var
        )
        ignore_cb.grid(row=0, column=0, sticky=tk.W, pady=2)

        self.use_vimeo_cookies_var = tk.BooleanVar(value=False)
        vimeo_cb = ttk.Checkbutton(
            options_frame,
            text="Usar cookies do Chrome (para Vimeo e sites restritos)",
            variable=self.use_vimeo_cookies_var
        )
        vimeo_cb.grid(row=1, column=0, sticky=tk.W, pady=2)

        # Diretório de Download
        dir_frame = ttk.LabelFrame(main_frame, text="Diretório de Download", padding="10")
        dir_frame.grid(row=4, column=0, sticky=(tk.W, tk.E), pady=10)
        dir_frame.columnconfigure(0, weight=1)

        self.dir_label = ttk.Label(dir_frame, text=self.download_path, foreground="blue")
        self.dir_label.grid(row=0, column=0, sticky=tk.W)

        change_dir_btn = ttk.Button(dir_frame, text="Alterar", command=self.change_directory)
        change_dir_btn.grid(row=0, column=1, padx=(10, 0))

        open_dir_btn = ttk.Button(dir_frame, text="Abrir Pasta", command=self.open_directory)
        open_dir_btn.grid(row=0, column=2, padx=(5, 0))

        # Botões de Ação
        button_frame = ttk.Frame(main_frame)
        button_frame.grid(row=5, column=0, pady=20)

        self.download_btn = ttk.Button(
            button_frame,
            text="Baixar",
            command=self.start_download,
            width=20
        )
        self.download_btn.grid(row=0, column=0, padx=5)

        self.cancel_btn = ttk.Button(
            button_frame,
            text="Cancelar",
            command=self.cancel_download,
            state=tk.DISABLED,
            width=20
        )
        self.cancel_btn.grid(row=0, column=1, padx=5)

        # Barra de Progresso
        self.progress = ttk.Progressbar(main_frame, mode='indeterminate')
        self.progress.grid(row=6, column=0, sticky=(tk.W, tk.E), pady=10)

        # Log de Saída
        log_frame = ttk.LabelFrame(main_frame, text="Log de Download", padding="10")
        log_frame.grid(row=7, column=0, sticky=(tk.W, tk.E, tk.N, tk.S), pady=10)
        log_frame.columnconfigure(0, weight=1)
        log_frame.rowconfigure(0, weight=1)
        main_frame.rowconfigure(7, weight=1)

        self.log_text = scrolledtext.ScrolledText(
            log_frame,
            height=10,
            font=('Monaco', 10),
            wrap=tk.WORD
        )
        self.log_text.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))

        clear_log_btn = ttk.Button(log_frame, text="Limpar Log", command=self.clear_log)
        clear_log_btn.grid(row=1, column=0, pady=(5, 0))

    def check_dependencies(self):
        """Verifica se yt-dlp e ffmpeg estão instalados"""
        try:
            subprocess.run(["yt-dlp", "--version"], capture_output=True, check=True)
            self.log("✓ yt-dlp encontrado")
        except (subprocess.CalledProcessError, FileNotFoundError):
            self.log("✗ yt-dlp não encontrado!")
            messagebox.showerror(
                "Dependência Faltando",
                "yt-dlp não está instalado.\n\nInstale com: brew install yt-dlp"
            )

        try:
            subprocess.run(["ffmpeg", "-version"], capture_output=True, check=True)
            self.log("✓ ffmpeg encontrado")
        except (subprocess.CalledProcessError, FileNotFoundError):
            self.log("✗ ffmpeg não encontrado!")
            messagebox.showwarning(
                "Dependência Faltando",
                "ffmpeg não está instalado.\n\nInstale com: brew install ffmpeg"
            )

    def log(self, message):
        """Adiciona mensagem ao log"""
        self.log_text.insert(tk.END, f"{message}\n")
        self.log_text.see(tk.END)
        self.root.update_idletasks()

    def clear_log(self):
        """Limpa o log"""
        self.log_text.delete(1.0, tk.END)

    def paste_url(self):
        """Cola URL da clipboard"""
        try:
            url = self.root.clipboard_get()
            self.url_entry.delete(0, tk.END)
            self.url_entry.insert(0, url)
            self.log(f"URL colada: {url}")
        except tk.TclError:
            messagebox.showwarning("Clipboard Vazia", "Nenhum texto na clipboard")

    def clear_url(self):
        """Limpa o campo de URL"""
        self.url_entry.delete(0, tk.END)

    def change_directory(self):
        """Altera o diretório de download"""
        directory = filedialog.askdirectory(initialdir=self.download_path)
        if directory:
            self.download_path = directory
            self.dir_label.config(text=directory)
            self.log(f"Diretório alterado para: {directory}")

    def open_directory(self):
        """Abre o diretório de downloads no Finder"""
        subprocess.run(["open", self.download_path])

    def build_command(self, url):
        """Constrói o comando yt-dlp"""
        cmd = ["yt-dlp"]

        format_type = self.format_var.get()

        # Configurações por formato
        if format_type == "video_best":
            cmd.extend(["-f", "bv*+ba/b", "--merge-output-format", "mp4", "--recode-video", "mp4"])
        elif format_type == "video_720p":
            cmd.extend(["-f", "bv*[height<=720]+ba/b[height<=720]", "--merge-output-format", "mp4", "--recode-video", "mp4"])
        elif format_type == "video_480p":
            cmd.extend(["-f", "bv*[height<=480]+ba/b[height<=480]", "--merge-output-format", "mp4", "--recode-video", "mp4"])
        elif format_type == "audio_mp3":
            cmd.extend(["-x", "--audio-format", "mp3", "--ffmpeg-location", "/usr/local/bin/ffmpeg"])
        elif format_type == "video_subs":
            cmd.extend(["-f", "bv*+ba/b", "--merge-output-format", "mp4", "--recode-video", "mp4", "--write-srt", "--sub-lang", "en"])
        elif format_type == "playlist_video":
            cmd.extend(["--yes-playlist", "-f", "bv*+ba/b", "--merge-output-format", "mp4", "--recode-video", "mp4"])
        elif format_type == "playlist_audio":
            cmd.extend(["--yes-playlist", "-x", "--audio-format", "mp3", "--ffmpeg-location", "/usr/local/bin/ffmpeg"])

        # Opções adicionais
        if self.ignore_errors_var.get() and "playlist" in format_type:
            cmd.append("-i")

        # Cookies para Vimeo e sites restritos
        if self.use_vimeo_cookies_var.get() or "vimeo.com" in url.lower():
            cmd.extend(["--cookies-from-browser", "chrome"])
        else:
            cmd.extend(["--cookies-from-browser", "safari"])

        # FFmpeg location
        cmd.extend(["--ffmpeg-location", "/usr/local/bin/ffmpeg"])

        # URL
        cmd.append(url)

        return cmd

    def start_download(self):
        """Inicia o download em thread separada"""
        url = self.url_entry.get().strip()

        if not url:
            messagebox.showwarning("URL Vazia", "Por favor, insira uma URL")
            return

        self.is_downloading = True
        self.download_btn.config(state=tk.DISABLED)
        self.cancel_btn.config(state=tk.NORMAL)
        self.progress.start()

        self.log(f"\n{'='*50}")
        self.log(f"Iniciando download...")
        self.log(f"URL: {url}")
        self.log(f"Formato: {self.format_var.get()}")
        self.log(f"{'='*50}\n")

        # Inicia thread de download
        thread = threading.Thread(target=self.download_worker, args=(url,), daemon=True)
        thread.start()

    def download_worker(self, url):
        """Worker thread para executar o download"""
        try:
            cmd = self.build_command(url)
            self.log(f"Comando: {' '.join(cmd)}\n")

            # Executa o comando
            process = subprocess.Popen(
                cmd,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                text=True,
                cwd=self.download_path
            )

            # Lê saída em tempo real
            for line in process.stdout:
                if not self.is_downloading:
                    process.terminate()
                    break
                self.log(line.strip())

            process.wait()

            if process.returncode == 0:
                self.log("\n✓ Download concluído com sucesso!")
                self.root.after(0, lambda: messagebox.showinfo("Sucesso", "Download concluído!"))
            else:
                self.log(f"\n✗ Download finalizado com código: {process.returncode}")
                self.root.after(0, lambda: messagebox.showwarning("Aviso", "Download finalizado com erros. Verifique o log."))

        except Exception as e:
            self.log(f"\n✗ Erro: {e}")
            self.root.after(0, lambda: messagebox.showerror("Erro", f"Erro no download:\n{e}"))

        finally:
            self.is_downloading = False
            self.root.after(0, self.finish_download)

    def finish_download(self):
        """Finaliza o download (chamado na thread principal)"""
        self.progress.stop()
        self.download_btn.config(state=tk.NORMAL)
        self.cancel_btn.config(state=tk.DISABLED)

    def cancel_download(self):
        """Cancela o download"""
        if messagebox.askyesno("Cancelar", "Deseja cancelar o download?"):
            self.is_downloading = False
            self.log("\n! Download cancelado pelo usuário")


def main():
    root = tk.Tk()
    app = YTDLPApp(root)
    root.mainloop()


if __name__ == "__main__":
    main()
