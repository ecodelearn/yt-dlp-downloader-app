#!/bin/bash
# Script de teste da instalação

echo "======================================"
echo "Teste de Instalação YT-DLP CLI"
echo "======================================"
echo ""

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Teste 1: Python
echo "1. Testando Python..."
if command -v python3 &> /dev/null; then
    echo "   ✓ Python encontrado: $(python3 --version)"
else
    echo "   ✗ Python não encontrado"
    exit 1
fi

# Teste 2: yt-dlp
echo ""
echo "2. Testando yt-dlp..."
if command -v yt-dlp &> /dev/null; then
    echo "   ✓ yt-dlp encontrado: $(yt-dlp --version)"
else
    echo "   ✗ yt-dlp não encontrado"
    exit 1
fi

# Teste 3: Ambiente virtual
echo ""
echo "3. Testando ambiente virtual..."
if [ -d "venv" ]; then
    echo "   ✓ Ambiente virtual existe"
    source venv/bin/activate

    # Teste imports
    echo "   ✓ Testando dependências..."
    python -c "import yt_dlp, rich, typer, inquirer" 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "   ✓ Todas as dependências instaladas"
    else
        echo "   ✗ Erro nas dependências"
        exit 1
    fi
else
    echo "   ✗ Ambiente virtual não encontrado"
    exit 1
fi

# Teste 4: Scripts
echo ""
echo "4. Testando scripts..."
if [ -x "ytdl.py" ]; then
    echo "   ✓ ytdl.py é executável"
else
    echo "   ⚠️  ytdl.py não é executável (não é problema)"
fi

if [ -x "quick-download-gui.sh" ]; then
    echo "   ✓ quick-download-gui.sh é executável"
else
    echo "   ✗ quick-download-gui.sh não é executável"
fi

# Teste 5: Quick Actions
echo ""
echo "5. Testando Quick Actions..."
QA_COUNT=$(ls -1 ~/Library/Services/ | grep -c "YT-DLP")
if [ "$QA_COUNT" -eq 4 ]; then
    echo "   ✓ 4 Quick Actions instaladas:"
    ls ~/Library/Services/ | grep "YT-DLP" | sed 's/^/     - /'
else
    echo "   ⚠️  Encontradas $QA_COUNT Quick Actions (esperado: 4)"
fi

# Teste 6: Download de teste (listagem apenas)
echo ""
echo "6. Testando comando yt-dlp (listagem)..."
TEST_URL="https://www.youtube.com/watch?v=dQw4w9WgXcQ"
yt-dlp --simulate --print title "$TEST_URL" 2>/dev/null
if [ $? -eq 0 ]; then
    echo "   ✓ yt-dlp funcionando corretamente"
else
    echo "   ⚠️  Erro ao testar yt-dlp (pode ser problema de rede)"
fi

echo ""
echo "======================================"
echo "✅ Testes concluídos!"
echo "======================================"
echo ""
echo "Como usar:"
echo ""
echo "1. CLI Interativa:"
echo "   source venv/bin/activate"
echo "   python ytdl.py"
echo ""
echo "2. Quick Actions:"
echo "   - Copie uma URL (Cmd+C)"
echo "   - Clique com botão direito em qualquer lugar"
echo "   - Serviços → YT-DLP Download"
echo ""
echo "3. Configurar atalho de teclado:"
echo "   Preferências do Sistema → Teclado → Atalhos → Serviços"
echo "   Encontre 'YT-DLP Download' e adicione um atalho"
echo ""
echo "======================================"
