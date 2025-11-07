#!/bin/bash
# GUI Dialog para Quick Actions do macOS

# Diretório do script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Pega a URL da clipboard
URL=$(pbpaste)

# Verifica se há URL na clipboard
if [ -z "$URL" ]; then
    osascript -e "display dialog \"Nenhuma URL encontrada na clipboard!\" buttons {\"OK\"} default button \"OK\" with icon stop"
    exit 1
fi

# Mostra diálogo com opções
CHOICE=$(osascript <<EOF
set choices to {"Vídeo MP4", "Áudio MP3", "Vídeo com Legendas", "Playlist Áudio", "Playlist Vídeo", "Cancelar"}
set dialogResult to choose from list choices with prompt "Download de: $URL

Escolha o tipo de download:" default items {"Vídeo MP4"} with title "YT-DLP Quick Download"

if dialogResult is false then
    return "cancel"
else
    return item 1 of dialogResult
end if
EOF
)

# Se cancelou
if [ "$CHOICE" = "cancel" ]; then
    exit 0
fi

# Ativa o ambiente virtual
source "$SCRIPT_DIR/venv/bin/activate"

# Diretório de download
DOWNLOAD_DIR="$HOME/Downloads"
cd "$DOWNLOAD_DIR"

# Mostra notificação de início
osascript -e "display notification \"Iniciando download...\" with title \"YT-DLP\" subtitle \"$CHOICE\""

# Detecta se é Vimeo para adicionar flags especiais
VIMEO_FLAGS=""
if [[ "$URL" == *"vimeo.com"* ]]; then
    VIMEO_FLAGS="--cookies-from-browser chrome"
fi

# Executa download baseado na escolha
case "$CHOICE" in
    "Vídeo MP4")
        yt-dlp -f 'bv*+ba/b' --merge-output-format mp4 --recode-video mp4 $VIMEO_FLAGS "$URL" 2>&1
        ;;
    "Áudio MP3")
        yt-dlp -x --audio-format mp3 --ffmpeg-location /usr/local/bin/ffmpeg $VIMEO_FLAGS "$URL" 2>&1
        ;;
    "Vídeo com Legendas")
        yt-dlp -f 'bv*+ba/b' --merge-output-format mp4 --recode-video mp4 --write-srt --sub-lang en $VIMEO_FLAGS "$URL" 2>&1
        ;;
    "Playlist Áudio")
        yt-dlp --yes-playlist -i -x --audio-format mp3 --ffmpeg-location /usr/local/bin/ffmpeg $VIMEO_FLAGS "$URL" 2>&1
        ;;
    "Playlist Vídeo")
        yt-dlp --yes-playlist -i -f 'bv*+ba/b' --merge-output-format mp4 --recode-video mp4 $VIMEO_FLAGS "$URL" 2>&1
        ;;
esac

EXIT_CODE=$?

# Notificação de conclusão
if [ $EXIT_CODE -eq 0 ]; then
    osascript -e "display notification \"Download concluído com sucesso!\" with title \"YT-DLP\" sound name \"Glass\""
    # Abre o Finder na pasta Downloads
    open "$DOWNLOAD_DIR"
else
    osascript -e "display notification \"Erro no download. Verifique a URL.\" with title \"YT-DLP\" sound name \"Basso\""
fi
