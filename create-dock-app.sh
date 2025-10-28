#!/bin/bash
# Cria um aplicativo que pode ser colocado no Dock

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
APP_NAME="YT-DLP Downloader"
APP_PATH="$HOME/Applications/$APP_NAME.app"

echo "======================================"
echo "Criando App para o Dock"
echo "======================================"
echo ""

# Remove app existente
if [ -d "$APP_PATH" ]; then
    rm -rf "$APP_PATH"
fi

# Cria estrutura do app
mkdir -p "$APP_PATH/Contents/MacOS"
mkdir -p "$APP_PATH/Contents/Resources"

# Cria Info.plist
cat > "$APP_PATH/Contents/Info.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>YT-DLP-Downloader</string>
    <key>CFBundleIdentifier</key>
    <string>com.user.ytdlp-downloader</string>
    <key>CFBundleName</key>
    <string>YT-DLP Downloader</string>
    <key>CFBundleVersion</key>
    <string>1.0</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>LSMinimumSystemVersion</key>
    <string>10.15</string>
    <key>LSUIElement</key>
    <false/>
</dict>
</plist>
EOF

# Cria executável principal
cat > "$APP_PATH/Contents/MacOS/YT-DLP-Downloader" <<'EXEC_EOF'
#!/bin/bash

# Diretório do script
SCRIPT_DIR="/Users/ecode/Documents/projetos/yt-dlp-script"

# Pega URL da clipboard
URL=$(pbpaste)

# Verifica se há URL
if [ -z "$URL" ]; then
    osascript -e 'display dialog "Nenhuma URL encontrada na clipboard!\n\nPor favor:\n1. Copie a URL do vídeo (Cmd+C)\n2. Execute este app novamente" buttons {"OK"} default button "OK" with icon stop with title "YT-DLP Downloader"'
    exit 1
fi

# Mostra diálogo com opções
CHOICE=$(osascript <<EOF
set choices to {"Vídeo MP4 (Melhor)", "Vídeo 720p (Menor)", "Vídeo 480p (Muito Menor)", "Áudio MP3", "Vídeo com Legendas", "Playlist Áudio", "Playlist Vídeo", "Cancelar"}
set dialogResult to choose from list choices with prompt "Download de:\n$URL\n\nEscolha o tipo de download:" default items {"Vídeo MP4 (Melhor)"} with title "YT-DLP Downloader"

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

# Ativa ambiente virtual
source "$SCRIPT_DIR/venv/bin/activate"

# Diretório de download
DOWNLOAD_DIR="$HOME/Downloads"
cd "$DOWNLOAD_DIR"

# Mostra notificação de início
osascript -e "display notification \"Iniciando download...\" with title \"YT-DLP\" subtitle \"$CHOICE\""

# Executa download baseado na escolha
case "$CHOICE" in
    "Vídeo MP4 (Melhor)")
        yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' "$URL" 2>&1
        ;;
    "Vídeo 720p (Menor)")
        yt-dlp -f 'bv*[height<=720]+ba/b[height<=720]' --merge-output-format mp4 "$URL" 2>&1
        ;;
    "Vídeo 480p (Muito Menor)")
        yt-dlp -f 'bv*[height<=480]+ba/b[height<=480]' --merge-output-format mp4 "$URL" 2>&1
        ;;
    "Áudio MP3")
        yt-dlp -x --audio-format mp3 "$URL" 2>&1
        ;;
    "Vídeo com Legendas")
        yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' --write-srt --sub-lang en "$URL" 2>&1
        ;;
    "Playlist Áudio")
        yt-dlp --yes-playlist -x --audio-format mp3 "$URL" 2>&1
        ;;
    "Playlist Vídeo")
        yt-dlp --yes-playlist -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' "$URL" 2>&1
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
EXEC_EOF

# Torna executável
chmod +x "$APP_PATH/Contents/MacOS/YT-DLP-Downloader"

echo "✓ App criado com sucesso!"
echo ""
echo "Localização: $APP_PATH"
echo ""
echo "Como usar:"
echo ""
echo "1. Abra o Finder e vá para: ~/Applications/"
echo "   ou execute: open ~/Applications/"
echo ""
echo "2. Arraste 'YT-DLP Downloader' para o Dock"
echo ""
echo "3. Para usar:"
echo "   - Copie a URL do vídeo (Cmd+C)"
echo "   - Clique no ícone no Dock"
echo "   - Escolha o tipo de download"
echo ""
echo "======================================"
echo ""

# Abre o Applications
open ~/Applications/
