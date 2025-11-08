# Changelog - Versão 2.0.0

## Data: 06/11/2025

## 🎉 Principais Novidades

### 1. ✨ App Desktop Moderno (`ytdl_gui.py`)

Criado um aplicativo desktop completo com interface gráfica moderna usando Python e Tkinter:

**Recursos:**
- Interface gráfica nativa do macOS (tema Aqua)
- Campo de URL com botões "Colar" e "Limpar"
- 7 formatos de download pré-configurados
- Opções avançadas integradas:
  - Ignorar erros em playlist
  - Usar cookies do Chrome (Vimeo/sites restritos)
- Seletor de diretório de download
- Log em tempo real do progresso
- Barra de progresso animada
- Botão de cancelamento
- Verificação automática de dependências

**Como Usar:**
```bash
python3 ytdl_gui.py
# ou
open ~/Applications/YT-DLP\ Desktop.app
```

### 2. 🚀 Script de Instalação Automática (`install-desktop-app.sh`)

Script completo que automatiza toda a instalação:

**O que faz:**
- ✅ Verifica e instala Homebrew (se necessário)
- ✅ Instala yt-dlp e ffmpeg
- ✅ Verifica Python 3
- ✅ Cria o aplicativo desktop
- ✅ Testa toda a instalação
- ✅ Mostra resumo detalhado

**Como Usar:**
```bash
./install-desktop-app.sh
```

### 3. 🛠️ Script de Criação do App Desktop (`create-desktop-app.sh`)

Script que cria o arquivo .app nativo do macOS:

**Cria:**
- Estrutura de diretórios .app completa
- Info.plist configurado
- Launcher script
- Ícone do sistema
- Executável no ~/Applications/

**Como Usar:**
```bash
./create-desktop-app.sh
```

### 4. 📚 Documentação Completa (`DESKTOP_APP_GUIDE.md`)

Guia detalhado do novo app desktop incluindo:
- Instruções de instalação
- Como usar (passo a passo)
- Opções avançadas
- Atalhos e dicas
- Solução de problemas
- Comparação entre os apps
- Changelog

## 🔧 Correções de Bugs

### 1. ✅ Fix: Download de Playlists de Vídeo

**Problema:** Playlists de vídeo não baixavam corretamente

**Correções em `ytdl-quick.sh`:**
```bash
# Antes:
-f 'bv*[vcodec^=avc]+ba[acodec^=mp4a]/bv*+ba/b'

# Depois:
-f 'bv*+ba/b' --merge-output-format mp4 --recode-video mp4
```

**Adicionado:**
- Flag `-i` para ignorar erros em playlists
- `--ffmpeg-location` explícito
- `--cookies-from-browser safari`

**Arquivos corrigidos:**
- `ytdl-quick.sh` (linha 110-118)
- `ytdl.py` (linha 55-58)
- `ytdl_gui.py` (novo)

### 2. ✅ Fix: Suporte para Vimeo

**Problema:** Vimeo retornava erro "The web client only works when logged-in"

**Solução em `quick-download-gui.sh`:**
```bash
# Detecta Vimeo e usa cookies do Chrome
VIMEO_FLAGS=""
if [[ "$URL" == *"vimeo.com"* ]]; then
    VIMEO_FLAGS="--cookies-from-browser chrome"
fi
```

**Implementado em:**
- `quick-download-gui.sh` (linhas 46-50)
- `ytdl_gui.py` (detecção automática)
- Opção manual no app desktop

### 3. ✅ Fix: Formatos de Vídeo Simplificados

**Problema:** Filtros de formato muito complexos causavam falhas

**Solução:**
- Simplificado de `bv*[vcodec^=avc]+ba[acodec^=mp4a]/bv*+ba/b` para `bv*+ba/b`
- Adicionado `--recode-video mp4` para garantir conversão
- Mantida compatibilidade H.264 + AAC

## 📝 Melhorias de Documentação

### README.md
- ✨ Atualizado com seção do novo app desktop
- 🎯 Reorganizado com emojis para melhor navegação
- 📦 Instalação rápida destacada
- 🗂️ Estrutura do projeto atualizada
- 📋 Changelog expandido

### Novos Arquivos
- `DESKTOP_APP_GUIDE.md` - Guia completo do app desktop
- `CHANGELOG_V2.md` - Este arquivo

## 🆕 Novos Arquivos Criados

1. **ytdl_gui.py** - App desktop com Tkinter (404 linhas)
2. **create-desktop-app.sh** - Cria .app para macOS
3. **install-desktop-app.sh** - Instalação automática
4. **DESKTOP_APP_GUIDE.md** - Documentação do app desktop
5. **CHANGELOG_V2.md** - Resumo de mudanças

## 🔄 Arquivos Modificados

1. **ytdl.py**:
   - Linha 57: Corrigido preset `playlist_video`
   - Linha 264: Corrigido formato de vídeo avançado

2. **ytdl-quick.sh**:
   - Linhas 110-118: Corrigido formato de playlist

3. **quick-download-gui.sh**:
   - Linhas 46-68: Adicionado suporte para Vimeo

4. **README.md**:
   - Seção "Características" atualizada
   - Seção "Instalação" expandida
   - Seção "Uso" reorganizada
   - Estrutura do projeto atualizada
   - Changelog expandido

## 📊 Comparação: V1.0 vs V2.0

| Recurso | V1.0 | V2.0 |
|---------|------|------|
| App Desktop GUI | ❌ | ✅ |
| App Dock | ✅ | ✅ |
| CLI Interativo | ✅ | ✅ |
| Instalação Automática | ❌ | ✅ |
| Log em Tempo Real | ❌ | ✅ |
| Suporte Vimeo | ⚠️ Parcial | ✅ |
| Playlists | ⚠️ Com bugs | ✅ |
| Documentação Completa | ⚠️ Básica | ✅ |

## 🚀 Como Atualizar de V1.0 para V2.0

```bash
# 1. Navegue até o diretório do projeto
cd ~/Documents/projetos/yt-dlp-script

# 2. Faça pull das mudanças (se usando git)
git pull

# 3. Execute a instalação automática
./install-desktop-app.sh

# 4. Pronto! Os apps antigos continuam funcionando
```

## 🎯 Próximos Passos Recomendados

1. **Testar o App Desktop**:
   ```bash
   open ~/Applications/YT-DLP\ Desktop.app
   ```

2. **Testar com URLs reais**:
   - YouTube (vídeo único)
   - YouTube (playlist)
   - Vimeo (se tiver conta)

3. **Adicionar ao Dock** para acesso rápido

4. **Reportar bugs** no GitHub Issues

## 📞 Suporte

- **Documentação**: `README.md`, `DESKTOP_APP_GUIDE.md`
- **Issues Conhecidas**: `ISSUES.md`
- **GitHub**: [Criar Issue](https://github.com/seu-usuario/yt-dlp-script/issues)

## 🙏 Agradecimentos

- **yt-dlp**: Ferramenta incrível para download de vídeos
- **Python Tkinter**: Interface gráfica nativa
- **ffmpeg**: Processamento de vídeo/áudio
- **Homebrew**: Gerenciador de pacotes para macOS

---

**Versão:** 2.0.0
**Data:** 06/11/2025
**Status:** ✅ Pronto para uso
