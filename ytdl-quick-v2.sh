#!/bin/bash
# Quick Download Script v2 - Com merge garantido

# Pega URL da clipboard
URL=$(pbpaste)

# Verifica se há URL
if [ -z "$URL" ]; then
    osascript -e 'display dialog "Nenhuma URL encontrada na clipboard!\n\nPor favor:\n1. Copie a URL do vídeo (Cmd+C)\n2. Execute este app novamente" buttons {"OK"} default button "OK" with icon stop with title "YT-DLP Downloader"'
    exit 1
fi

# Mostra diálogo com opções
CHOICE=$(osascript <<EOF
set choices to {"Vídeo MP4", "Áudio MP3", "Vídeo com Legendas", "Playlist Áudio", "Playlist Vídeo", "Cancelar"}
set dialogResult to choose from list choices with prompt "Download de:\n$URL\n\nEscolha o tipo de download:" default items {"Vídeo MP4"} with title "YT-DLP Downloader"

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

# Diretório de download
DOWNLOAD_DIR="$HOME/Downloads"
cd "$DOWNLOAD_DIR"

# Mostra notificação de início
osascript -e "display notification \"Iniciando download...\" with title \"YT-DLP\" subtitle \"$CHOICE\""

# Executa download baseado na escolha (usa yt-dlp do sistema)
case "$CHOICE" in
    "Vídeo MP4")
        # Baixa com opções de merge explícitas
        /usr/local/bin/yt-dlp -f 'bv*[vcodec^=avc]+ba[acodec^=mp4a]/bv*+ba/b' \
            --merge-output-format mp4 \
            --remux-video mp4 \
            --ffmpeg-location /usr/local/bin/ffmpeg \
            -o "%(title)s [%(id)s].%(ext)s" \
            "$URL"

        # Verifica se há arquivos temporários não mesclados
        VIDEO_ID=$(echo "$URL" | grep -oE '[a-zA-Z0-9_-]{11}' | head -1)
        if [ -n "$VIDEO_ID" ]; then
            # Procura por arquivos .f*.mp4 ou .m4a
            VIDEO_FILE=$(ls -t *"$VIDEO_ID"*.f*.mp4 2>/dev/null | head -1)
            AUDIO_FILE=$(ls -t *"$VIDEO_ID"*.m4a 2>/dev/null | head -1)
            FINAL_FILE=$(ls -t *"$VIDEO_ID".mp4 2>/dev/null | head -1)

            # Se encontrou arquivos separados, mescla manualmente
            if [ -n "$VIDEO_FILE" ] && [ -n "$AUDIO_FILE" ]; then
                osascript -e 'display notification "Mesclando vídeo e áudio..." with title "YT-DLP"'

                # Extrai nome base
                BASE_NAME="${VIDEO_FILE%.f*.mp4}"

                # Mescla com ffmpeg
                /usr/local/bin/ffmpeg -i "$VIDEO_FILE" -i "$AUDIO_FILE" \
                    -c copy -movflags +faststart \
                    "${BASE_NAME}.mp4" -y 2>&1

                # Remove arquivos temporários
                rm "$VIDEO_FILE" "$AUDIO_FILE" 2>/dev/null
            fi
        fi
        ;;
    "Áudio MP3")
        /usr/local/bin/yt-dlp -x --audio-format mp3 "$URL"
        ;;
    "Vídeo com Legendas")
        /usr/local/bin/yt-dlp -f 'bv*[vcodec^=avc]+ba[acodec^=mp4a]/bv*+ba/b' \
            --merge-output-format mp4 \
            --remux-video mp4 \
            --ffmpeg-location /usr/local/bin/ffmpeg \
            --write-srt --sub-lang en \
            -o "%(title)s [%(id)s].%(ext)s" \
            "$URL"
        ;;
    "Playlist Áudio")
        /usr/local/bin/yt-dlp --yes-playlist -x --audio-format mp3 "$URL"
        ;;
    "Playlist Vídeo")
        /usr/local/bin/yt-dlp --yes-playlist \
            -f 'bv*[vcodec^=avc]+ba[acodec^=mp4a]/bv*+ba/b' \
            --merge-output-format mp4 \
            --remux-video mp4 \
            --ffmpeg-location /usr/local/bin/ffmpeg \
            "$URL"
        ;;
esac

EXIT_CODE=$?

# Notificação de conclusão
if [ $EXIT_CODE -eq 0 ]; then
    osascript -e "display notification \"Download concluído com sucesso!\" with title \"YT-DLP\" sound name \"Glass\""
    open "$DOWNLOAD_DIR"
else
    osascript -e "display notification \"Erro no download. Verifique a URL.\" with title \"YT-DLP\" sound name \"Basso\""
fi
