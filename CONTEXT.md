# Contexto do Projeto YT-DLP Downloader App

**Data da última sessão**: 2025-10-28  
**Repositório**: https://github.com/ecodelearn/yt-dlp-downloader-app

---

## 📋 Resumo do Projeto

Sistema completo de download de vídeos do YouTube/Vimeo para macOS com múltiplas interfaces:
- **App para Dock/Desktop**: Interface gráfica com diálogos nativos do macOS
- **CLI Interativo**: Terminal com menus usando inquirer e rich
- **Quick Actions**: Atalhos no menu de contexto do macOS

---

## 🎯 Estado Atual

### ✅ Funcionalidades Implementadas

1. **App para Dock/Desktop**
   - Criado via `create-dock-app.sh`
   - Localização: `~/Applications/YT-DLP Downloader.app`
   - Usa script `ytdl-quick.sh` como backend
   - Interface com diálogos nativos do macOS (osascript)
   - Notificações do sistema
   - Abre pasta Downloads automaticamente após download

2. **Formatos de Vídeo**
   - ✅ Vídeo MP4 (Melhor) - 1080p+ com melhor qualidade
   - ✅ Vídeo 720p (Menor) - HD, arquivos 30-40% menores
   - ✅ Vídeo 480p (Muito Menor) - SD, arquivos 60-70% menores
   - ✅ Áudio MP3 - Extração de áudio
   - ✅ Vídeo com Legendas - Melhor qualidade + legendas EN
   - ✅ Playlist Áudio - Toda playlist em MP3
   - ✅ Playlist Vídeo - Toda playlist em MP4

3. **Compatibilidade**
   - Todos os vídeos convertidos para H.264 + AAC
   - MP4 compatível com QuickTime e WhatsApp
   - Suporte para YouTube (totalmente funcional)
   - Suporte para Vimeo (parcial - requer login no Safari)

4. **Tecnologias**
   - yt-dlp 2025.10.22
   - ffmpeg 8.0
   - Python 3.x com inquirer e rich
   - Bash scripts para automação

---

## 🐛 Problemas Conhecidos e Status

### Issue #1: Playlist de Vídeo - ✅ RESOLVIDO

**Problema**: Filtros muito restritivos impediam download de playlists

**Solução Implementada**:
- Simplificado filtro para `bv*+ba/b`
- Adicionado flag `-i` (ignore errors)
- Adicionado `--cookies-from-browser safari`
- Usa `--recode-video mp4`

**Arquivos Modificados**:
- `ytdl-quick.sh` (linha 109-118)
- `ytdl.py` (linha 55-58)

**Status**: ✅ Corrigido no commit `21cf579`

### Issue #2: Download de Vimeo - ⚠️ PARCIALMENTE RESOLVIDO

**Problema**: Vimeo requer autenticação obrigatória

**Solução Implementada**:
- Adicionado `--cookies-from-browser safari` em todos os formatos
- Funciona se usuário estiver logado no Vimeo via Safari

**Limitações**:
- Vídeos privados podem não funcionar
- Precisa estar logado no Safari
- Vimeo mudou política de acesso recentemente

**Soluções Alternativas Documentadas**:
- Usar Chrome: `--cookies-from-browser chrome`
- Usar impersonation: `--impersonate chrome`
- Login direto (não recomendado para app)

**Status**: ⚠️ Funcional com limitações. Ver `ISSUES.md` para detalhes

---

## 📁 Estrutura de Arquivos

```
yt-dlp-script/
├── README.md                          # Documentação completa
├── CONTEXT.md                         # Este arquivo - contexto da sessão
├── ISSUES.md                          # Problemas conhecidos detalhados
├── .gitignore                         # Arquivos ignorados pelo git
│
├── ytdl-quick.sh                      # ⭐ Script principal (usado pelo app)
├── ytdl.py                            # CLI interativo Python
├── ytdl-quick-v2.sh                   # Versão alternativa
│
├── create-dock-app.sh                 # Cria app para Dock/Desktop
├── create-workflows.sh                # Cria Quick Actions do macOS
│
├── quick-download.sh                  # Script de download rápido
├── quick-download-gui.sh              # Versão GUI
├── setup.sh                           # Setup inicial
├── test-installation.sh               # Testa instalação
├── install-quick-actions-manual.sh    # Instalação manual de Quick Actions
│
├── exemplox.txt                       # Exemplos de comandos yt-dlp
├── requirements.txt                   # Dependências Python
├── GUIA_RAPIDO.md                     # Guia rápido de uso
├── INSTALL_QUICK_ACTION.md            # Guia de Quick Actions
│
└── venv/                              # Ambiente virtual Python (não commitado)
```

---

## 🔧 Configuração Técnica Atual

### Formatos de Download

Todos os formatos usam a seguinte base:

```bash
# Formato universal simplificado
-f 'bv*+ba/b'                          # Melhor vídeo + melhor áudio
--merge-output-format mp4              # Mescla em MP4
--recode-video mp4                     # Força conversão para MP4
--cookies-from-browser safari          # Usa cookies do Safari
--ffmpeg-location /usr/local/bin/ffmpeg
```

#### Vídeo 720p:
```bash
-f 'bv*[height<=720]+ba/b[height<=720]'
```

#### Vídeo 480p:
```bash
-f 'bv*[height<=480]+ba/b[height<=480]'
```

#### Playlists:
```bash
--yes-playlist -i                      # -i = ignore errors
```

### Codecs Garantidos

- **Vídeo**: H.264 (AVC)
- **Áudio**: AAC
- **Container**: MP4

Compatível com:
- ✅ QuickTime Player
- ✅ WhatsApp
- ✅ iOS/iPhone
- ✅ iMovie
- ✅ Todos players modernos

---

## 📝 Histórico de Commits

```
21cf579 - fix: corrige playlists e adiciona tratamento de erros
9de978b - fix: corrige formatos de vídeo e adiciona suporte para Vimeo
94da98e - feat: adiciona sistema completo de download YT-DLP para macOS
6102308 - first commit
```

---

## 🚀 Como Usar (Resumo)

### App do Dock/Desktop

```bash
# 1. Criar o app (apenas primeira vez)
./create-dock-app.sh

# 2. Usar
# - Copiar URL (Cmd+C)
# - Clicar no app no Desktop/Dock
# - Escolher formato
# - Aguardar conclusão
```

### CLI Interativo

```bash
# Ativar ambiente virtual
source venv/bin/activate

# Executar
python3 ytdl.py
```

### Linha de Comando Direto

```bash
# Copiar URL primeiro, depois:
./ytdl-quick.sh
```

---

## 🔄 Próximos Passos / TODOs

### Melhorias Sugeridas

1. **Vimeo**
   - [ ] Testar impersonation: `--impersonate chrome`
   - [ ] Adicionar opção para escolher navegador (Chrome/Firefox/Safari)
   - [ ] Testar com vídeos públicos vs privados
   - [ ] Documentar quais tipos de vídeo funcionam

2. **Interface**
   - [ ] Adicionar barra de progresso no app
   - [ ] Notificação com progresso em tempo real
   - [ ] Opção de cancelar download em andamento
   - [ ] Escolher pasta de destino no app

3. **Funcionalidades**
   - [ ] Download de canal completo
   - [ ] Download com intervalo de datas
   - [ ] Filtrar playlist por palavras-chave
   - [ ] Suporte para mais sites (Instagram, TikTok, etc)

4. **Qualidade de Código**
   - [ ] Adicionar testes automatizados
   - [ ] Melhorar tratamento de erros
   - [ ] Log detalhado de operações
   - [ ] Validação de URL antes de baixar

5. **Documentação**
   - [ ] Adicionar screenshots ao README
   - [ ] Criar vídeo demo
   - [ ] Traduzir para inglês
   - [ ] Adicionar FAQ

---

## 🛠️ Comandos Úteis

### Git

```bash
# Status
git status

# Commit
git add -A
git commit -m "mensagem"
git push

# Ver histórico
git log --oneline -10

# Ver diff
git diff
```

### yt-dlp

```bash
# Atualizar
yt-dlp -U

# Listar formatos
yt-dlp -F URL

# Testar sem baixar
yt-dlp --skip-download URL

# Ver cookies disponíveis
yt-dlp --cookies-from-browser safari --list-extractors
```

### Debugging

```bash
# Testar formato específico
yt-dlp -f 'bv*+ba/b' --merge-output-format mp4 --skip-download URL

# Ver informações completas
yt-dlp -v URL 2>&1 | less

# Verificar codec do arquivo
ffprobe -v error -show_entries stream=codec_name arquivo.mp4
```

---

## 💡 Notas Importantes

### Mudanças Recentes (2025-10-28)

1. **Simplificação de Filtros**
   - Removidos filtros muito específicos de codec
   - Agora usa filtros mais universais `bv*+ba/b`
   - Melhor compatibilidade com diferentes sites

2. **Cookies do Safari**
   - Todos os formatos agora usam `--cookies-from-browser safari`
   - Permite acesso a vídeos com proteção
   - Necessário estar logado no site pelo Safari

3. **Tratamento de Erros**
   - Playlists agora usam flag `-i` (ignore errors)
   - Continua download mesmo se um item falhar
   - Melhor para playlists grandes

4. **Conversão de Formato**
   - Mudou de `--remux-video mp4` para `--recode-video mp4`
   - Força conversão se necessário (WebM → MP4)
   - Garante compatibilidade total com QuickTime

### Decisões de Design

1. **Por que H.264 + AAC?**
   - Máxima compatibilidade
   - Suportado nativamente no macOS
   - Funciona no WhatsApp sem conversão

2. **Por que cookies do Safari?**
   - Safari é nativo do macOS
   - Usuários já estão logados em sites
   - Evita pedir credenciais no app

3. **Por que `--recode-video`?**
   - YouTube/Vimeo às vezes entrega VP9/WebM
   - QuickTime não suporta VP9 nativamente
   - Conversão automática garante compatibilidade

---

## 📞 Informações de Contato

- **GitHub**: https://github.com/ecodelearn/yt-dlp-downloader-app
- **Issues**: https://github.com/ecodelearn/yt-dlp-downloader-app/issues

---

## 📚 Referências

- [yt-dlp Documentation](https://github.com/yt-dlp/yt-dlp)
- [yt-dlp Format Selection](https://github.com/yt-dlp/yt-dlp#format-selection)
- [ffmpeg Documentation](https://ffmpeg.org/documentation.html)
- [yt-dlp Cookies FAQ](https://github.com/yt-dlp/yt-dlp/wiki/FAQ#how-do-i-pass-cookies-to-yt-dlp)

---

## 🔒 Arquivo Criado

Este arquivo foi gerado automaticamente em 2025-10-28 para preservar o contexto da sessão de desenvolvimento.

Para retomar o trabalho:
1. Leia este arquivo primeiro
2. Revise `ISSUES.md` para problemas conhecidos
3. Veja `README.md` para documentação completa
4. Execute `git log` para ver histórico recente

**Última atualização**: 2025-10-28  
**Última sessão com**: Claude Code (Sonnet 4.5)
