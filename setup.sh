#!/bin/bash
# Script de instalação para YT-DLP CLI

echo "==================================="
echo "YT-DLP CLI - Instalação"
echo "==================================="
echo ""

# Verifica se Python está instalado
if ! command -v python3 &> /dev/null; then
    echo "❌ Python3 não encontrado!"
    echo "Por favor, instale o Python3 primeiro."
    exit 1
fi

echo "✓ Python3 encontrado: $(python3 --version)"

# Verifica se yt-dlp está instalado
if ! command -v yt-dlp &> /dev/null; then
    echo "⚠️  yt-dlp não encontrado!"
    echo ""
    read -p "Deseja instalar yt-dlp via brew? (s/n) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Ss]$ ]]; then
        if command -v brew &> /dev/null; then
            brew install yt-dlp
        else
            echo "❌ Homebrew não encontrado!"
            echo "Instale manualmente: pip install yt-dlp"
            exit 1
        fi
    else
        echo "Por favor, instale o yt-dlp manualmente:"
        echo "  brew install yt-dlp"
        echo "  ou"
        echo "  pip install yt-dlp"
        exit 1
    fi
fi

echo "✓ yt-dlp encontrado: $(yt-dlp --version)"
echo ""

# Cria ambiente virtual
echo "📦 Criando ambiente virtual..."
python3 -m venv venv

if [ $? -ne 0 ]; then
    echo "❌ Erro ao criar ambiente virtual"
    exit 1
fi

echo "✓ Ambiente virtual criado"
echo ""

# Ativa ambiente virtual
echo "🔧 Ativando ambiente virtual..."
source venv/bin/activate

# Instala dependências
echo "📥 Instalando dependências..."
pip install --upgrade pip
pip install -r requirements.txt

if [ $? -ne 0 ]; then
    echo "❌ Erro ao instalar dependências"
    exit 1
fi

echo ""
echo "✓ Dependências instaladas com sucesso!"
echo ""

# Torna o script executável
chmod +x ytdl.py

echo "==================================="
echo "✅ Instalação concluída!"
echo "==================================="
echo ""
echo "Para usar o programa:"
echo "  1. Ative o ambiente virtual:"
echo "     source venv/bin/activate"
echo ""
echo "  2. Execute o programa:"
echo "     python ytdl.py"
echo "     ou"
echo "     ./ytdl.py"
echo ""
echo "==================================="
