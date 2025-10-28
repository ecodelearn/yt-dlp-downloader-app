#!/bin/bash
# Instalação manual de Quick Actions usando Automator via linha de comando

echo "======================================"
echo "Instalação Manual de Quick Actions"
echo "======================================"
echo ""
echo "ATENÇÃO: As Quick Actions não estão aparecendo automaticamente."
echo "Vamos criar usando o método oficial do Automator."
echo ""
echo "Por favor, siga estes passos:"
echo ""
echo "1. Abra o AUTOMATOR"
echo "   (Spotlight: Cmd + Space, digite 'Automator')"
echo ""
echo "2. Clique em 'Novo Documento'"
echo ""
echo "3. Selecione 'Ação Rápida' (Quick Action)"
echo ""
echo "4. No topo, configure:"
echo "   - O fluxo de trabalho recebe: [sem entrada]"
echo "   - em: [qualquer aplicativo]"
echo ""
echo "5. Na barra de busca à esquerda, procure: 'Executar Script Shell'"
echo ""
echo "6. Arraste 'Executar Script Shell' para a área de trabalho"
echo ""
echo "7. Cole este script no campo:"
echo ""
echo "────────────────────────────────────"
cat << 'SCRIPT_END'
/Users/ecode/Documents/projetos/yt-dlp-script/quick-download-gui.sh
SCRIPT_END
echo "────────────────────────────────────"
echo ""
echo "8. Salve (Cmd + S) com o nome: 'YT-DLP Download'"
echo ""
echo "9. Feche o Automator"
echo ""
echo "10. Teste:"
echo "    - Copie uma URL (Cmd + C)"
echo "    - Clique com botão direito em qualquer lugar"
echo "    - Vá em: Serviços → YT-DLP Download"
echo ""
echo "======================================"
echo ""

read -p "Pressione ENTER para abrir o Automator agora... " -r
open -a Automator

echo ""
echo "Automator aberto!"
echo "Siga os passos acima para criar a Quick Action."
echo ""
