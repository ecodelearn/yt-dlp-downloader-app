#!/bin/bash
# Quick Download Script - Chamado pelo Quick Action do macOS

# Diretório do script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Ativa o ambiente virtual
source "$SCRIPT_DIR/venv/bin/activate"

# Pega a URL da clipboard (argumento ou clipboard)
URL="$1"

if [ -z "$URL" ]; then
    URL=$(pbpaste)
fi

# Diretório de download padrão
DOWNLOAD_DIR="$HOME/Downloads"

# Tipo de download (passado como segundo argumento)
DOWNLOAD_TYPE="${2:-video}"

cd "$DOWNLOAD_DIR"

case "$DOWNLOAD_TYPE" in
    "video")
        yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' "$URL"
        ;;
    "audio")
        yt-dlp -x --audio-format mp3 "$URL"
        ;;
    "video-subs")
        yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' --write-srt --sub-lang en "$URL"
        ;;
    "audio-playlist")
        yt-dlp --yes-playlist -x --audio-format mp3 "$URL"
        ;;
    "video-playlist")
        yt-dlp --yes-playlist -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' "$URL"
        ;;
    *)
        yt-dlp "$URL"
        ;;
esac

# Notificação de conclusão
osascript -e "display notification \"Download concluído!\" with title \"YT-DLP\" sound name \"Glass\""
