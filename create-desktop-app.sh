#!/bin/bash
# Cria aplicativo desktop para macOS com interface gráfica moderna

APP_NAME="YT-DLP Desktop"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
APP_DIR="$HOME/Applications/${APP_NAME}.app"
CONTENTS_DIR="$APP_DIR/Contents"
MACOS_DIR="$CONTENTS_DIR/MacOS"
RESOURCES_DIR="$CONTENTS_DIR/Resources"

echo "🚀 Criando aplicativo desktop: $APP_NAME"

# Remove aplicativo existente
if [ -d "$APP_DIR" ]; then
    echo "🗑️  Removendo versão anterior..."
    rm -rf "$APP_DIR"
fi

# Cria estrutura de diretórios
echo "📁 Criando estrutura de diretórios..."
mkdir -p "$MACOS_DIR"
mkdir -p "$RESOURCES_DIR"

# Cria o script launcher
echo "📝 Criando launcher..."
cat > "$MACOS_DIR/launcher.sh" << 'EOF'
#!/bin/bash

# Diretório do script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
APP_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"

# Caminho para o Python do sistema ou venv
if [ -f "$SCRIPT_DIR/../../ytdl_gui.py" ]; then
    PYTHON_SCRIPT="$SCRIPT_DIR/../../ytdl_gui.py"
else
    # Procura no diretório original
    PYTHON_SCRIPT="$HOME/Documents/projetos/yt-dlp-script/ytdl_gui.py"
fi

# Verifica se o script existe
if [ ! -f "$PYTHON_SCRIPT" ]; then
    osascript -e 'display dialog "Script não encontrado!\n\nVerifique a instalação." buttons {"OK"} default button "OK" with icon stop with title "YT-DLP Desktop"'
    exit 1
fi

# Executa o aplicativo Python usando o Python do sistema (tem Tkinter nativo)
cd "$(dirname "$PYTHON_SCRIPT")"
/usr/bin/python3 "$PYTHON_SCRIPT" 2>&1 | logger -t "YTDLP-Desktop"
EOF

chmod +x "$MACOS_DIR/launcher.sh"

# Cria Info.plist
echo "⚙️  Criando Info.plist..."
cat > "$CONTENTS_DIR/Info.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>launcher.sh</string>
    <key>CFBundleIconFile</key>
    <string>AppIcon.icns</string>
    <key>CFBundleIdentifier</key>
    <string>com.ytdlp.desktop</string>
    <key>CFBundleName</key>
    <string>YT-DLP Desktop</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>2.0</string>
    <key>CFBundleVersion</key>
    <string>2.0</string>
    <key>LSMinimumSystemVersion</key>
    <string>10.15</string>
    <key>NSHighResolutionCapable</key>
    <true/>
    <key>LSUIElement</key>
    <false/>
</dict>
</plist>
EOF

# Cria ícone a partir do icon.png do projeto
echo "🎨 Criando ícone personalizado..."
CUSTOM_ICON_SOURCE="$SCRIPT_DIR/icon.png"
if [ -f "$CUSTOM_ICON_SOURCE" ]; then
    # Converte o ícone e verifica se houve erro
    if ! sips -s format icns "$CUSTOM_ICON_SOURCE" --out "$RESOURCES_DIR/AppIcon.icns" >/dev/null 2>&1; then
        echo "⚠️  Falha ao criar o ícone personalizado. Verifique se o arquivo icon.png é uma imagem válida."
    fi
else
    echo "⚠️  Arquivo icon.png não encontrado no diretório do projeto. O ícone padrão será usado."
fi

# Torna o aplicativo executável
chmod +x "$APP_DIR"

echo ""
echo "✅ Aplicativo criado com sucesso!"
echo "📍 Localização: $APP_DIR"
echo ""
echo "Para usar:"
echo "  1. Abra o Finder em ~/Applications/"
echo "  2. Dê dois cliques em '$APP_NAME.app'"
echo "  3. (Opcional) Arraste para o Dock"
echo ""
echo "💡 Dica: Se o macOS bloquear o app, vá em:"
echo "   Preferências do Sistema → Segurança e Privacidade"
echo "   e clique em 'Abrir Assim Mesmo'"
echo ""

# Pergunta se quer abrir o aplicativo
read -p "Deseja abrir o aplicativo agora? (s/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Ss]$ ]]; then
    open "$APP_DIR"
fi
