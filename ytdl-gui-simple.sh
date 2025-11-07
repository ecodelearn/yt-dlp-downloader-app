#!/bin/bash
# YT-DLP GUI Simples usando AppleScript (sem dependências Python)
# Compatível com todas as versões do macOS

# Configurações
DOWNLOAD_DIR="$HOME/Downloads"

# Função para mostrar diálogo
show_dialog() {
    osascript <<EOF
    display dialog "$1" buttons {"OK"} default button "OK" with title "YT-DLP Downloader" $2
EOF
}

# Função para pegar input
get_input() {
    osascript <<EOF
    text returned of (display dialog "$1" default answer "$2" buttons {"Cancelar", "OK"} default button "OK" with title "YT-DLP Downloader")
EOF
}

# Loop principal
while true; do
    # Menu principal
    CHOICE=$(osascript <<'EOF'
set choices to {"📥 Baixar Vídeo/Áudio", "⚙️ Configurações", "ℹ️ Sobre", "❌ Sair"}
set dialogResult to choose from list choices with prompt "YT-DLP Downloader - Menu Principal" default items {"📥 Baixar Vídeo/Áudio"} with title "YT-DLP Downloader"

if dialogResult is false then
    return "Sair"
else
    return item 1 of dialogResult
end if
EOF
)

    case "$CHOICE" in
        "📥 Baixar Vídeo/Áudio")
            # Pega URL
            URL=$(osascript <<'EOF'
set defaultURL to the clipboard as text
text returned of (display dialog "Cole a URL do vídeo/playlist:" default answer defaultURL buttons {"Cancelar", "OK"} default button "OK" with title "YT-DLP Downloader")
EOF
)

            if [ -z "$URL" ]; then
                continue
            fi

            # Escolhe formato
            FORMAT=$(osascript <<'EOF'
set choices to {"Vídeo (Melhor Qualidade MP4)", "Vídeo 720p (Menor)", "Vídeo 480p (Muito Menor)", "Áudio MP3", "Vídeo com Legendas", "Playlist Completa (Vídeo)", "Playlist Completa (Áudio)"}
set dialogResult to choose from list choices with prompt "Escolha o formato de download:" default items {"Vídeo (Melhor Qualidade MP4)"} with title "YT-DLP Downloader"

if dialogResult is false then
    return "cancelar"
else
    return item 1 of dialogResult
end if
EOF
)

            if [ "$FORMAT" = "cancelar" ]; then
                continue
            fi

            # Mostra notificação de início
            osascript -e "display notification \"Iniciando download...\" with title \"YT-DLP\" subtitle \"$FORMAT\""

            # Executa download
            cd "$DOWNLOAD_DIR"

            case "$FORMAT" in
                "Vídeo (Melhor Qualidade MP4)")
                    /usr/local/bin/yt-dlp -f 'bv*+ba/b' --merge-output-format mp4 --recode-video mp4 --cookies-from-browser safari --ffmpeg-location /usr/local/bin/ffmpeg "$URL"
                    ;;
                "Vídeo 720p (Menor)")
                    /usr/local/bin/yt-dlp -f 'bv*[height<=720]+ba/b[height<=720]' --merge-output-format mp4 --recode-video mp4 --cookies-from-browser safari --ffmpeg-location /usr/local/bin/ffmpeg "$URL"
                    ;;
                "Vídeo 480p (Muito Menor)")
                    /usr/local/bin/yt-dlp -f 'bv*[height<=480]+ba/b[height<=480]' --merge-output-format mp4 --recode-video mp4 --cookies-from-browser safari --ffmpeg-location /usr/local/bin/ffmpeg "$URL"
                    ;;
                "Áudio MP3")
                    /usr/local/bin/yt-dlp -x --audio-format mp3 --ffmpeg-location /usr/local/bin/ffmpeg "$URL"
                    ;;
                "Vídeo com Legendas")
                    /usr/local/bin/yt-dlp -f 'bv*+ba/b' --merge-output-format mp4 --recode-video mp4 --write-srt --sub-lang en --cookies-from-browser safari --ffmpeg-location /usr/local/bin/ffmpeg "$URL"
                    ;;
                "Playlist Completa (Vídeo)")
                    /usr/local/bin/yt-dlp --yes-playlist -i -f 'bv*+ba/b' --merge-output-format mp4 --recode-video mp4 --cookies-from-browser safari --ffmpeg-location /usr/local/bin/ffmpeg "$URL"
                    ;;
                "Playlist Completa (Áudio)")
                    /usr/local/bin/yt-dlp --yes-playlist -i -x --audio-format mp3 --ffmpeg-location /usr/local/bin/ffmpeg "$URL"
                    ;;
            esac

            EXIT_CODE=$?

            # Notificação de conclusão
            if [ $EXIT_CODE -eq 0 ]; then
                osascript -e "display notification \"Download concluído com sucesso!\" with title \"YT-DLP\" sound name \"Glass\""

                # Pergunta se quer abrir a pasta
                OPEN_FOLDER=$(osascript <<'EOF'
button returned of (display dialog "Download concluído!\n\nAbrir pasta Downloads?" buttons {"Não", "Abrir"} default button "Abrir" with title "YT-DLP Downloader")
EOF
)

                if [ "$OPEN_FOLDER" = "Abrir" ]; then
                    open "$DOWNLOAD_DIR"
                fi
            else
                osascript -e "display dialog \"Erro no download.\n\nVerifique:\n• URL está correta\n• Conexão com internet\n• yt-dlp está instalado\" buttons {\"OK\"} default button \"OK\" with icon stop with title \"YT-DLP Downloader\""
            fi
            ;;

        "⚙️ Configurações")
            # Mostra diretório atual
            NEW_DIR=$(osascript <<EOF
button returned of (display dialog "Diretório de download atual:\n\n$DOWNLOAD_DIR\n\nDeseja alterar?" buttons {"Cancelar", "Alterar"} default button "Cancelar" with title "YT-DLP Downloader")
EOF
)

            if [ "$NEW_DIR" = "Alterar" ]; then
                SELECTED_DIR=$(osascript <<'EOF'
POSIX path of (choose folder with prompt "Escolha o diretório de download:")
EOF
)

                if [ -n "$SELECTED_DIR" ]; then
                    DOWNLOAD_DIR="$SELECTED_DIR"
                    osascript -e "display dialog \"Diretório alterado para:\n\n$DOWNLOAD_DIR\" buttons {\"OK\"} default button \"OK\" with title \"YT-DLP Downloader\""
                fi
            fi
            ;;

        "ℹ️ Sobre")
            # Versão do yt-dlp
            YTDLP_VERSION=$(/usr/local/bin/yt-dlp --version 2>/dev/null || echo "não instalado")

            osascript <<EOF
display dialog "YT-DLP Downloader v2.0

Interface gráfica para download de vídeos

Ferramentas:
• yt-dlp: $YTDLP_VERSION
• ffmpeg: instalado
• Python: Sistema

Desenvolvido em: Novembro 2025" buttons {"OK"} default button "OK" with title "Sobre"
EOF
            ;;

        "❌ Sair"|"Sair")
            exit 0
            ;;
    esac
done
