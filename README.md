# YT-DLP Downloader

Sistema completo para download de vídeos do YouTube com interface gráfica para macOS, incluindo app para o Dock e CLI interativo.

## Características

- **App para Dock/Desktop**: Clique e baixe vídeos direto da área de trabalho
- **CLI Interativo**: Interface de linha de comando com menus intuitivos
- **Quick Actions**: Atalhos no menu de contexto do macOS
- **Múltiplos Formatos**: Vídeo em várias qualidades, áudio MP3, playlists
- **Compatibilidade Total**: Vídeos em MP4 (H.264 + AAC) compatíveis com QuickTime e WhatsApp
- **Download Inteligente**: Merge automático de vídeo e áudio
- **Legendas**: Suporte para legendas automáticas e enviadas

## Formatos Disponíveis

### Vídeo
- **Vídeo MP4 (Melhor)**: Máxima qualidade disponível em MP4 (H.264)
- **Vídeo 720p (Menor)**: Resolução HD, arquivos ~30-40% menores
- **Vídeo 480p (Muito Menor)**: Resolução SD, arquivos ~60-70% menores
- **Vídeo com Legendas**: Melhor qualidade + legendas em inglês

### Áudio
- **Áudio MP3**: Extração de áudio em formato MP3

### Playlist
- **Playlist Completa (Vídeo)**: Baixa todos os vídeos de uma playlist
- **Playlist Completa (Áudio)**: Baixa todo o áudio de uma playlist em MP3

## Requisitos

- macOS 10.15 ou superior
- Homebrew (gerenciador de pacotes)
- Python 3.8+
- yt-dlp
- ffmpeg

## Instalação

### 1. Instalar Dependências

```bash
# Instalar Homebrew (se ainda não tiver)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Instalar yt-dlp e ffmpeg
brew install yt-dlp ffmpeg

# Instalar Python (se necessário)
brew install python@3.11
```

### 2. Clonar o Repositório

```bash
cd ~/Documents/projetos
git clone https://github.com/seu-usuario/yt-dlp-downloader-app.git
cd yt-dlp-downloader-app
```

### 3. Configurar Ambiente Python (para CLI interativo)

```bash
# Criar ambiente virtual
python3 -m venv venv

# Ativar ambiente virtual
source venv/bin/activate

# Instalar dependências
pip install inquirer rich
```

## Uso

### App para Dock/Desktop

#### Criar o App

```bash
cd ~/Documents/projetos/yt-dlp-downloader-app
./create-dock-app.sh
```

O script criará o app em `~/Applications/YT-DLP Downloader.app`.

#### Usar o App

1. **Copie** a URL do vídeo do YouTube (Cmd+C)
2. **Clique** no ícone "YT-DLP Downloader" no Desktop ou Dock
3. **Escolha** o formato desejado no diálogo
4. **Aguarde** a notificação de conclusão
5. **Acesse** a pasta Downloads (abre automaticamente)

#### Adicionar ao Dock

1. Abra o Finder em `~/Applications/`
2. Arraste "YT-DLP Downloader.app" para o Dock
3. Pronto!

### CLI Interativo (ytdl.py)

```bash
cd ~/Documents/projetos/yt-dlp-downloader-app
source venv/bin/activate
python3 ytdl.py
```

O CLI oferece:
- Download rápido com presets
- Download avançado com opções personalizadas
- Configuração do diretório de download
- Visualização de todos os presets disponíveis

### Uso Manual (Scripts Shell)

#### Download rápido via script

```bash
# Copie a URL primeiro, depois execute:
./ytdl-quick.sh
```

#### Comandos diretos com yt-dlp

```bash
# Vídeo 720p (menor)
yt-dlp -f 'bv*[height<=720][ext=mp4]+ba[ext=m4a]/bv*[height<=720]+ba' \
  --merge-output-format mp4 --recode-video mp4 URL

# Vídeo 480p (muito menor)
yt-dlp -f 'bv*[height<=480][ext=mp4]+ba[ext=m4a]/bv*[height<=480]+ba' \
  --merge-output-format mp4 --recode-video mp4 URL

# Áudio MP3
yt-dlp -x --audio-format mp3 URL

# Playlist completa (vídeo)
yt-dlp --yes-playlist -f 'bv*[vcodec^=avc]+ba[acodec^=mp4a]/bv*+ba/b' \
  --merge-output-format mp4 URL

# Com legendas
yt-dlp --write-srt --sub-lang en URL
```

## Estrutura do Projeto

```
yt-dlp-downloader-app/
├── README.md                          # Documentação
├── exemplox.txt                       # Exemplos de uso do yt-dlp
├── ytdl.py                           # CLI interativo em Python
├── ytdl-quick.sh                     # Script principal (usado pelo app)
├── ytdl-quick-v2.sh                  # Versão alternativa
├── create-dock-app.sh                # Cria app para Dock/Desktop
├── create-workflows.sh               # Cria Quick Actions do macOS
├── quick-download.sh                 # Script de download rápido
├── quick-download-gui.sh             # Versão GUI
├── setup.sh                          # Setup inicial
├── test-installation.sh              # Testa instalação
├── install-quick-actions-manual.sh   # Instalação manual de Quick Actions
└── venv/                             # Ambiente virtual Python
```

## Detalhes Técnicos

### Formatos de Vídeo

Os vídeos são baixados com as seguintes especificações:

| Formato | Resolução | Codec Vídeo | Codec Áudio | Tamanho Aproximado* |
|---------|-----------|-------------|-------------|---------------------|
| Melhor  | Variável  | H.264 (AVC) | AAC         | 100% (referência)   |
| 720p    | 1280x720  | H.264 (AVC) | AAC         | 60-70% do melhor    |
| 480p    | 854x480   | H.264 (AVC) | AAC         | 30-40% do melhor    |

*Tamanhos variam conforme a complexidade do vídeo

### Compatibilidade de Codecs

Todos os vídeos são baixados ou convertidos para:
- **Vídeo**: H.264 (AVC) - Compatível com QuickTime, iOS, WhatsApp
- **Áudio**: AAC - Padrão universal
- **Container**: MP4 - Máxima compatibilidade

### Como Funciona

1. **yt-dlp** baixa os melhores streams de vídeo e áudio separadamente
2. **ffmpeg** mescla (merge) os streams em um único arquivo MP4
3. O formato H.264 + AAC garante compatibilidade universal
4. `--recode-video mp4` força conversão se necessário

## Quick Actions do macOS

Para instalar as Quick Actions do macOS e poder baixar vídeos com clique direito:

```bash
./create-workflows.sh
```

Isso criará 4 Quick Actions:

1. **YT-DLP Download** - Abre diálogo com opções (Recomendado)
2. **YT-DLP Baixar Vídeo** - Download direto de vídeo
3. **YT-DLP Baixar Áudio MP3** - Download direto de áudio
4. **YT-DLP Baixar Playlist** - Download direto de playlist

### Como usar Quick Actions:

1. **Copie a URL** do vídeo (Cmd + C)
2. **Acesse o menu de 3 formas:**
   - Menu do App → Serviços → YT-DLP...
   - Botão direito (em qualquer lugar) → Serviços → YT-DLP...
   - Configure atalho de teclado em: Preferências → Teclado → Atalhos → Serviços
3. O download inicia automaticamente na pasta ~/Downloads
4. Uma notificação aparece quando concluir

## Solução de Problemas

### "yt-dlp não encontrado"

```bash
brew install yt-dlp
# ou
pip install yt-dlp
```

### "ffmpeg não encontrado"

```bash
brew install ffmpeg
```

### Vídeos não mesclam (arquivos .f*.mp4 separados)

O script `ytdl-quick.sh` inclui fallback automático para mesclar manualmente com ffmpeg.

### Erro de permissão ao executar scripts

```bash
chmod +x *.sh
```

### App não aparece no Dock

1. Verifique em `~/Applications/YT-DLP Downloader.app`
2. Execute novamente `./create-dock-app.sh`
3. Arraste manualmente para o Dock

### Vídeo não abre no QuickTime

Certifique-se de usar os formatos atualizados que incluem:
- `[ext=mp4]` e `[ext=m4a]` nos filtros
- `--recode-video mp4` para conversão

## Atualizando yt-dlp

```bash
# Via Homebrew
brew upgrade yt-dlp

# Via pip
pip install -U yt-dlp

# Comando direto
yt-dlp -U
```

## Configuração Avançada

### Personalizar Diretório de Download

Edite a variável `DOWNLOAD_DIR` nos scripts:

```bash
# Em ytdl-quick.sh
DOWNLOAD_DIR="$HOME/Downloads"  # Altere para seu diretório preferido
```

### Adicionar Novos Formatos

Edite os arrays `choices` e os blocos `case` nos scripts:

```bash
# ytdl-quick.sh (linha 15)
set choices to {"Seu Novo Formato", ...}

# Adicione o case correspondente (linha 39+)
"Seu Novo Formato")
    yt-dlp [suas opções] "$URL"
    ;;
```

### Modificar Nomenclatura de Arquivos

Use a opção `-o` do yt-dlp:

```bash
# Formato atual
-o "%(title)s [%(id)s].%(ext)s"

# Apenas ID
-o "%(id)s.%(ext)s"

# Data + título
-o "%(upload_date)s - %(title)s.%(ext)s"
```

## Recursos Úteis

- [Documentação oficial do yt-dlp](https://github.com/yt-dlp/yt-dlp)
- [Format Selection no yt-dlp](https://github.com/yt-dlp/yt-dlp#format-selection)
- [Documentação do ffmpeg](https://ffmpeg.org/documentation.html)

## Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para:

1. Fazer fork do projeto
2. Criar uma branch para sua feature (`git checkout -b feature/NovaFeature`)
3. Commit suas mudanças (`git commit -m 'Adiciona NovaFeature'`)
4. Push para a branch (`git push origin feature/NovaFeature`)
5. Abrir um Pull Request

## Licença

Este projeto é de código aberto e está disponível sob a [Licença MIT](LICENSE).

## Changelog

### v1.0.0 (2025-10-28)
- Release inicial
- App para Dock/Desktop
- CLI interativo com inquirer e rich
- Suporte para múltiplos formatos (720p, 480p)
- Compatibilidade total com QuickTime e WhatsApp
- Merge automático de vídeo e áudio
- Suporte para playlists e legendas
