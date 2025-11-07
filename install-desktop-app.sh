#!/bin/bash
# Script de instalação completo do YT-DLP Desktop App

set -e

echo "=================================================="
echo "  Instalação do YT-DLP Desktop App"
echo "=================================================="
echo ""

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Funções auxiliares
print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}!${NC} $1"
}

print_info() {
    echo -e "${YELLOW}ℹ${NC} $1"
}

# Verifica se está no macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "Este script é apenas para macOS"
    exit 1
fi

print_success "Sistema macOS detectado"

# Passo 1: Verificar/Instalar Homebrew
echo ""
echo "Passo 1: Verificando Homebrew..."
if ! command -v brew &> /dev/null; then
    print_warning "Homebrew não encontrado"
    echo "Deseja instalar o Homebrew? (s/n)"
    read -r response
    if [[ "$response" =~ ^[Ss]$ ]]; then
        print_info "Instalando Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        print_success "Homebrew instalado"
    else
        print_error "Homebrew é necessário. Instalação cancelada."
        exit 1
    fi
else
    print_success "Homebrew encontrado"
fi

# Passo 2: Verificar/Instalar yt-dlp
echo ""
echo "Passo 2: Verificando yt-dlp..."
if ! command -v yt-dlp &> /dev/null; then
    print_info "Instalando yt-dlp..."
    brew install yt-dlp
    print_success "yt-dlp instalado"
else
    print_success "yt-dlp encontrado"
    # Verifica se há atualização
    print_info "Verificando atualizações..."
    brew upgrade yt-dlp 2>/dev/null || print_info "yt-dlp já está atualizado"
fi

# Passo 3: Verificar/Instalar ffmpeg
echo ""
echo "Passo 3: Verificando ffmpeg..."
if ! command -v ffmpeg &> /dev/null; then
    print_info "Instalando ffmpeg..."
    brew install ffmpeg
    print_success "ffmpeg instalado"
else
    print_success "ffmpeg encontrado"
fi

# Passo 4: Verificar Python 3
echo ""
echo "Passo 4: Verificando Python 3..."
if ! command -v python3 &> /dev/null; then
    print_error "Python 3 não encontrado"
    print_info "Instalando Python 3..."
    brew install python@3.11
else
    PYTHON_VERSION=$(python3 --version)
    print_success "Python 3 encontrado: $PYTHON_VERSION"
fi

# Passo 5: Criar o aplicativo desktop
echo ""
echo "Passo 5: Criando aplicativo desktop..."
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -f "$SCRIPT_DIR/create-desktop-app.sh" ]; then
    bash "$SCRIPT_DIR/create-desktop-app.sh"
else
    print_error "Script create-desktop-app.sh não encontrado"
    exit 1
fi

# Passo 6: Testar instalação
echo ""
echo "Passo 6: Testando instalação..."
echo ""

# Testa yt-dlp
if yt-dlp --version &> /dev/null; then
    print_success "yt-dlp: $(yt-dlp --version)"
else
    print_error "yt-dlp: Falhou"
fi

# Testa ffmpeg
if ffmpeg -version &> /dev/null; then
    FFMPEG_VERSION=$(ffmpeg -version | head -n 1 | cut -d' ' -f3)
    print_success "ffmpeg: $FFMPEG_VERSION"
else
    print_error "ffmpeg: Falhou"
fi

# Testa Python
if python3 --version &> /dev/null; then
    print_success "Python: $(python3 --version)"
else
    print_error "Python: Falhou"
fi

# Testa GUI
if [ -f "$SCRIPT_DIR/ytdl_gui.py" ]; then
    print_success "Interface gráfica: OK"
else
    print_error "Interface gráfica: Arquivo não encontrado"
fi

# Passo 7: Resumo
echo ""
echo "=================================================="
echo "  ✅ Instalação Concluída!"
echo "=================================================="
echo ""
echo "O que foi instalado:"
echo "  • Homebrew (se necessário)"
echo "  • yt-dlp"
echo "  • ffmpeg"
echo "  • YT-DLP Desktop App"
echo ""
echo "Localizações:"
echo "  • App: ~/Applications/YT-DLP Desktop.app"
echo "  • Scripts: $SCRIPT_DIR"
echo ""
echo "Como usar:"
echo "  1. Abra: ~/Applications/YT-DLP Desktop.app"
echo "  2. Cole a URL do vídeo"
echo "  3. Escolha o formato"
echo "  4. Clique em 'Baixar'"
echo ""
echo "Outras opções disponíveis:"
echo "  • GUI Moderna: python3 ytdl_gui.py"
echo "  • CLI Interativo: python3 ytdl.py"
echo "  • Dock App: ~/Applications/YT-DLP Downloader.app"
echo ""
echo "Documentação:"
echo "  • README.md - Visão geral"
echo "  • DESKTOP_APP_GUIDE.md - Guia do app desktop"
echo "  • GUIA_RAPIDO.md - Guia rápido de uso"
echo ""
echo "Para abrir o app agora, execute:"
echo "  open ~/Applications/YT-DLP\\ Desktop.app"
echo ""
echo "Ou arraste o app para o Dock para acesso rápido!"
echo ""
