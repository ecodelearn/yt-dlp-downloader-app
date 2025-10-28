#!/bin/bash
# Script para criar automaticamente as Quick Actions do macOS

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SERVICES_DIR="$HOME/Library/Services"

echo "===================================="
echo "Criando Quick Actions para YT-DLP"
echo "===================================="
echo ""

# Cria diretório de serviços se não existir
mkdir -p "$SERVICES_DIR"

# Função para criar workflow
create_workflow() {
    local name="$1"
    local script_content="$2"
    local workflow_path="$SERVICES_DIR/$name.workflow"

    echo "📝 Criando: $name"

    # Remove workflow existente
    if [ -d "$workflow_path" ]; then
        rm -rf "$workflow_path"
    fi

    # Cria estrutura do workflow
    mkdir -p "$workflow_path/Contents"

    # Cria Info.plist
    cat > "$workflow_path/Contents/Info.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>NSServices</key>
    <array>
        <dict>
            <key>NSMenuItem</key>
            <dict>
                <key>default</key>
                <string>$name</string>
            </dict>
            <key>NSMessage</key>
            <string>runWorkflowAsService</string>
        </dict>
    </array>
</dict>
</plist>
EOF

    # Cria document.wflow
    cat > "$workflow_path/Contents/document.wflow" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>AMApplicationBuild</key>
    <string>523</string>
    <key>AMApplicationVersion</key>
    <string>2.10</string>
    <key>AMDocumentVersion</key>
    <string>2</string>
    <key>actions</key>
    <array>
        <dict>
            <key>action</key>
            <dict>
                <key>AMAccepts</key>
                <dict>
                    <key>Container</key>
                    <string>List</string>
                    <key>Optional</key>
                    <true/>
                    <key>Types</key>
                    <array>
                        <string>com.apple.cocoa.string</string>
                    </array>
                </dict>
                <key>AMActionVersion</key>
                <string>2.0.3</string>
                <key>AMApplication</key>
                <array>
                    <string>Automator</string>
                </array>
                <key>AMParameterProperties</key>
                <dict>
                    <key>COMMAND_STRING</key>
                    <dict/>
                    <key>CheckedForUserDefaultShell</key>
                    <dict/>
                    <key>inputMethod</key>
                    <dict/>
                    <key>shell</key>
                    <dict/>
                    <key>source</key>
                    <dict/>
                </dict>
                <key>AMProvides</key>
                <dict>
                    <key>Container</key>
                    <string>List</string>
                    <key>Types</key>
                    <array>
                        <string>com.apple.cocoa.string</string>
                    </array>
                </dict>
                <key>ActionBundlePath</key>
                <string>/System/Library/Automator/Run Shell Script.action</string>
                <key>ActionName</key>
                <string>Run Shell Script</string>
                <key>ActionParameters</key>
                <dict>
                    <key>COMMAND_STRING</key>
                    <string>$script_content</string>
                    <key>CheckedForUserDefaultShell</key>
                    <true/>
                    <key>inputMethod</key>
                    <integer>0</integer>
                    <key>shell</key>
                    <string>/bin/bash</string>
                    <key>source</key>
                    <string></string>
                </dict>
                <key>BundleIdentifier</key>
                <string>com.apple.RunShellScript</string>
                <key>CFBundleVersion</key>
                <string>2.0.3</string>
                <key>CanShowSelectedItemsWhenRun</key>
                <false/>
                <key>CanShowWhenRun</key>
                <true/>
                <key>Category</key>
                <array>
                    <string>AMCategoryUtilities</string>
                </array>
                <key>Class Name</key>
                <string>RunShellScriptAction</string>
                <key>InputUUID</key>
                <string>UUID-INPUT</string>
                <key>Keywords</key>
                <array>
                    <string>Shell</string>
                    <string>Script</string>
                    <string>Command</string>
                    <string>Run</string>
                    <string>Unix</string>
                </array>
                <key>OutputUUID</key>
                <string>UUID-OUTPUT</string>
                <key>UUID</key>
                <string>UUID-ACTION</string>
                <key>UnlocalizedApplications</key>
                <array>
                    <string>Automator</string>
                </array>
                <key>arguments</key>
                <dict>
                    <key>0</key>
                    <dict>
                        <key>default value</key>
                        <integer>0</integer>
                        <key>name</key>
                        <string>inputMethod</string>
                        <key>required</key>
                        <string>0</string>
                        <key>type</key>
                        <string>0</string>
                        <key>uuid</key>
                        <string>0</string>
                    </dict>
                    <key>1</key>
                    <dict>
                        <key>default value</key>
                        <false/>
                        <key>name</key>
                        <string>CheckedForUserDefaultShell</string>
                        <key>required</key>
                        <string>0</string>
                        <key>type</key>
                        <string>0</string>
                        <key>uuid</key>
                        <string>1</string>
                    </dict>
                    <key>2</key>
                    <dict>
                        <key>default value</key>
                        <string></string>
                        <key>name</key>
                        <string>source</string>
                        <key>required</key>
                        <string>0</string>
                        <key>type</key>
                        <string>0</string>
                        <key>uuid</key>
                        <string>2</string>
                    </dict>
                    <key>3</key>
                    <dict>
                        <key>default value</key>
                        <string></string>
                        <key>name</key>
                        <string>COMMAND_STRING</string>
                        <key>required</key>
                        <string>0</string>
                        <key>type</key>
                        <string>0</string>
                        <key>uuid</key>
                        <string>3</string>
                    </dict>
                    <key>4</key>
                    <dict>
                        <key>default value</key>
                        <string>/bin/sh</string>
                        <key>name</key>
                        <string>shell</string>
                        <key>required</key>
                        <string>0</string>
                        <key>type</key>
                        <string>0</string>
                        <key>uuid</key>
                        <string>4</string>
                    </dict>
                </dict>
            </dict>
        </dict>
    </array>
    <key>connectors</key>
    <dict/>
    <key>workflowMetaData</key>
    <dict>
        <key>workflowTypeIdentifier</key>
        <string>com.apple.Automator.servicesMenu</string>
    </dict>
</dict>
</plist>
EOF

    echo "   ✓ Criado com sucesso"
    echo ""
}

# Workflow 1: Download com Diálogo (Principal)
create_workflow "YT-DLP Download" "$SCRIPT_DIR/quick-download-gui.sh"

# Workflow 2: Download Vídeo Rápido
VIDEO_SCRIPT='#!/bin/bash
URL=$(pbpaste)
source '"$SCRIPT_DIR"'/venv/bin/activate
cd ~/Downloads
osascript -e "display notification \"Baixando vídeo...\" with title \"YT-DLP\""
yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" "$URL" && \
osascript -e "display notification \"Vídeo baixado!\" with title \"YT-DLP\" sound name \"Glass\"" && \
open ~/Downloads'

create_workflow "YT-DLP Baixar Vídeo" "$VIDEO_SCRIPT"

# Workflow 3: Download Áudio Rápido
AUDIO_SCRIPT='#!/bin/bash
URL=$(pbpaste)
source '"$SCRIPT_DIR"'/venv/bin/activate
cd ~/Downloads
osascript -e "display notification \"Extraindo áudio...\" with title \"YT-DLP\""
yt-dlp -x --audio-format mp3 "$URL" && \
osascript -e "display notification \"Áudio extraído!\" with title \"YT-DLP\" sound name \"Glass\"" && \
open ~/Downloads'

create_workflow "YT-DLP Baixar Áudio MP3" "$AUDIO_SCRIPT"

# Workflow 4: Download Playlist
PLAYLIST_SCRIPT='#!/bin/bash
URL=$(pbpaste)
source '"$SCRIPT_DIR"'/venv/bin/activate
cd ~/Downloads
osascript -e "display notification \"Baixando playlist...\" with title \"YT-DLP\""
yt-dlp --yes-playlist -x --audio-format mp3 "$URL" && \
osascript -e "display notification \"Playlist baixada!\" with title \"YT-DLP\" sound name \"Glass\"" && \
open ~/Downloads'

create_workflow "YT-DLP Baixar Playlist" "$PLAYLIST_SCRIPT"

echo "===================================="
echo "✅ Quick Actions criadas!"
echo "===================================="
echo ""
echo "Como usar:"
echo ""
echo "1. Copie uma URL de vídeo (Cmd+C)"
echo ""
echo "2. Acesse as ações de 3 formas:"
echo ""
echo "   A) Menu do App → Serviços → YT-DLP..."
echo ""
echo "   B) Botão direito (em qualquer lugar) → Serviços → YT-DLP..."
echo ""
echo "   C) Configure atalho de teclado em:"
echo "      Preferências do Sistema → Teclado → Atalhos → Serviços"
echo ""
echo "Quick Actions disponíveis:"
echo "  • YT-DLP Download (com opções)"
echo "  • YT-DLP Baixar Vídeo (direto)"
echo "  • YT-DLP Baixar Áudio MP3 (direto)"
echo "  • YT-DLP Baixar Playlist (direto)"
echo ""
echo "===================================="
