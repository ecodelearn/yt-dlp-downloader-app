# YT-DLP Downloader para macOS

Sistema completo de download de vídeos do YouTube e outros sites com múltiplas interfaces para macOS.

[![macOS](https://img.shields.io/badge/macOS-10.15+-blue.svg)](https://www.apple.com/macos/)
[![Python](https://img.shields.io/badge/Python-3.8+-green.svg)](https://www.python.org/)
[![yt-dlp](https://img.shields.io/badge/yt--dlp-latest-red.svg)](https://github.com/yt-dlp/yt-dlp)

## ✨ Características

- **🖥️ App Desktop Moderno**: Interface gráfica completa com Tkinter
- **🎯 App para Dock**: Diálogo rápido para downloads instantâneos
- **💻 CLI Interativo**: Interface de linha de comando com menus intuitivos
- **⚡ Quick Actions**: Atalhos no menu de contexto do macOS
- **🎬 Múltiplos Formatos**: Vídeo em várias qualidades, áudio MP3, playlists
- **✅ Compatibilidade Total**: Vídeos em MP4 (H.264 + AAC) compatíveis com QuickTime e WhatsApp
- **🔧 Download Inteligente**: Merge automático de vídeo e áudio para melhor qualidade
- **📝 Legendas**: Suporte para legendas automáticas e enviadas
- **🌐 Multi-Site**: YouTube, Vimeo e centenas de outros sites suportados

## 📦 Formatos Disponíveis

### Vídeo
- **Vídeo MP4 (Melhor)**: Máxima qualidade disponível em MP4 (H.264 + AAC)
- **Vídeo 720p (Menor)**: Resolução HD, arquivos ~30-40% menores
- **Vídeo 480p (Muito Menor)**: Resolução SD, arquivos ~60-70% menores
- **Vídeo com Legendas**: Melhor qualidade + legendas em inglês

### Áudio
- **Áudio MP3**: Extração e conversão de áudio para MP3

### Playlist
- **Playlist Completa (Vídeo)**: Baixa todos os vídeos de uma playlist
- **Playlist Completa (Áudio)**: Baixa todo o áudio de uma playlist em MP3

## 🔧 Requisitos

- macOS 10.15 ou superior
- Homebrew (gerenciador de pacotes)
- Python 3.8+
- yt-dlp
- ffmpeg

## 🚀 Instalação Rápida

### Instalação Automática (Recomendado)

```bash
cd ~/Documents/projetos/yt-dlp-script
./install-desktop-app.sh
```

Este script irá:
- ✅ Verificar e instalar Homebrew (se necessário)
- ✅ Instalar yt-dlp e ffmpeg
- ✅ Criar o aplicativo desktop
- ✅ Testar toda a instalação

### Instalação Manual

#### 1. Instalar Dependências

```bash
# Instalar Homebrew (se ainda não tiver)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Instalar yt-dlp e ffmpeg
brew install yt-dlp ffmpeg

# Python 3 já vem no macOS
python3 --version
```

#### 2. Clonar o Repositório

```bash
cd ~/Documents/projetos
git clone https://github.com/seu-usuario/yt-dlp-script.git
cd yt-dlp-script
```

#### 3. Criar o App Desktop

```bash
./create-desktop-app.sh
```

#### 4. (Opcional) Configurar CLI Interativo

```bash
# Criar ambiente virtual
python3 -m venv venv

# Ativar ambiente virtual
source venv/bin/activate

# Instalar dependências
pip install inquirer rich
```

## 📱 Como Usar

### 🖥️ App Desktop Moderno (Recomendado)

#### Abrir o App

```bash
# Pelo Finder
open ~/Applications/YT-DLP\ Desktop.app

# Ou adicione ao Dock para acesso rápido
```

#### Como Usar

1. **Cole a URL** do vídeo (botão "Colar" ou Cmd+V)
2. **Escolha o formato**:
   - Vídeo (Melhor, 720p, 480p)
   - Áudio MP3
   - Vídeo com Legendas
   - Playlist Completa (Vídeo/Áudio)
3. **Configure opções avançadas** (se necessário):
   - Ignorar erros em playlist
   - Usar cookies do Chrome (para Vimeo)
4. **Clique em "Baixar"**
5. **Acompanhe o progresso** no log em tempo real

**📖 Documentação completa**: [DESKTOP_APP_GUIDE.md](DESKTOP_APP_GUIDE.md)

---

### 🎯 App para Dock/Desktop (Download Rápido)

**YT-DLP Downloader** é um app simples e rápido para downloads direto do Dock.

#### Criar o App

```bash
cd ~/Documents/projetos/yt-dlp-script
./create-dock-app.sh
```

O script criará o app em `~/Applications/YT-DLP Downloader.app`.

#### Usar o App

1. **Copie** a URL do vídeo (Cmd+C)
2. **Clique** no ícone "YT-DLP Downloader"
3. **Escolha** o formato no diálogo
4. **Aguarde** a notificação de conclusão
5. **Acesse** a pasta Downloads (abre automaticamente)

#### Adicionar ao Dock

1. Abra o Finder em `~/Applications/`
2. Arraste o app para o Dock
3. Pronto!

---

### 💻 CLI Interativo (ytdl.py)

Interface de linha de comando com menus interativos e opções avançadas.

#### Configurar

```bash
cd ~/Documents/projetos/yt-dlp-script

# Criar ambiente virtual
python3 -m venv venv

# Ativar ambiente virtual
source venv/bin/activate

# Instalar dependências
pip install inquirer rich
```

#### Usar

```bash
source venv/bin/activate
python3 ytdl.py
```

**Recursos:**
- Download rápido com presets
- Download avançado com opções personalizadas
- Configuração de diretório de download
- Listagem de playlists
- Seleção de itens específicos em playlists

---

### ⚡ Scripts de Terminal Rápido

Para uso direto no terminal sem interface:

```bash
# Download rápido
./ytdl-quick.sh

# GUI simples com AppleScript
./ytdl-gui-simple.sh

# GUI alternativa
./quick-download-gui.sh
```

## 🎨 Comparação de Interfaces

| Interface | Tipo | Melhor Para | Complexidade |
|-----------|------|-------------|--------------|
| **YT-DLP Desktop** | GUI Tkinter | Uso regular, visualizar progresso | Média |
| **YT-DLP Downloader** | App Dock | Downloads rápidos, produtividade | Baixa |
| **ytdl.py** | CLI Interativo | Controle total, opções avançadas | Média |
| **ytdl-quick.sh** | Terminal | Automação, scripts | Baixa |
| **ytdl-gui-simple.sh** | AppleScript | Alternativa GUI nativa | Baixa |

Escolha a interface que melhor se adapta ao seu fluxo de trabalho!

## 📂 Estrutura do Projeto

```
yt-dlp-script/
├── ytdl.py                      # CLI interativo principal
├── ytdl_gui.py                  # GUI Tkinter
├── ytdl-quick.sh               # Script de download rápido
├── ytdl-gui-simple.sh          # GUI AppleScript
├── quick-download-gui.sh       # GUI alternativa
├── create-desktop-app.sh       # Cria app desktop
├── create-dock-app.sh          # Cria app para Dock
├── install-desktop-app.sh      # Instalação completa
├── setup.sh                    # Setup de dependências
├── test-installation.sh        # Testa instalação
├── README.md                   # Este arquivo
├── DESKTOP_APP_GUIDE.md        # Guia completo do app desktop
├── RESUMO_FINAL.md            # Status e correções
└── venv/                       # Ambiente virtual Python
```

## 🛠️ Funcionalidades Avançadas

### Suporte para Vimeo

Para downloads do Vimeo, use cookies do navegador:

```bash
# No app desktop: marque "Usar cookies do Chrome"
# No terminal:
yt-dlp --cookies-from-browser chrome "URL_DO_VIMEO"
```

### Download de Playlists

Todas as interfaces suportam playlists:
- Download completo (todos os vídeos)
- Ignorar erros (pular vídeos privados/removidos)
- Seleção de itens específicos (apenas CLI)

### Formatos de Saída

Todos os vídeos são convertidos para MP4 (H.264 + AAC) usando:
- `--merge-output-format mp4`: Combina melhor vídeo + melhor áudio
- `--recode-video mp4`: Recodifica para garantir compatibilidade
- `--ffmpeg-location`: Usa FFmpeg para conversão

### Legendas

Suporte para:
- Legendas enviadas pelos criadores
- Legendas automáticas (auto-generated)
- Múltiplos idiomas
- Formato SRT

## 🔍 Solução de Problemas

### "yt-dlp não encontrado"

```bash
brew install yt-dlp
# ou
pip install yt-dlp
```

### "ffmpeg não encontrado"

```bash
brew install ffmpeg
```

### App não abre no macOS

1. Vá em **Preferências do Sistema** → **Segurança e Privacidade**
2. Clique em **"Abrir Assim Mesmo"**

### Erro com Vimeo

1. Certifique-se de estar logado no Vimeo pelo Chrome
2. Marque "Usar cookies do Chrome" nas opções
3. Ou tente usar cookies do Safari (padrão)

### Download de MP3 falha

Certifique-se de que FFmpeg está instalado:

```bash
brew install ffmpeg
```

### Playlist não baixa tudo

- Marque "Ignorar erros em playlist"
- Alguns vídeos podem ser privados ou removidos
- Verifique os logs para detalhes

### Permissões no macOS

Se o terminal solicitar permissões:

1. **Preferências do Sistema** → **Segurança e Privacidade** → **Privacidade**
2. Adicione o Terminal em **Acesso Total ao Disco** (se necessário)

## 📊 Tamanhos de Arquivo

| Formato | Resolução | Tamanho (10 min vídeo) | Uso Recomendado |
|---------|-----------|----------------------|-----------------|
| Melhor | 1080p-4K | ~200-500 MB | Arquivamento, máxima qualidade |
| 720p | 1280x720 | ~100-200 MB | Equilíbrio qualidade/tamanho |
| 480p | 854x480 | ~50-100 MB | Economia de espaço, mobile |
| MP3 | N/A | ~10-20 MB | Apenas áudio, música |

## 🔄 Atualização

Para atualizar o yt-dlp:

```bash
brew upgrade yt-dlp
```

Para atualizar o projeto:

```bash
cd ~/Documents/projetos/yt-dlp-script
git pull
```

## 🤝 Contribuindo

Contribuições são bem-vindas! Por favor:

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📝 Changelog

### v2.0 (2025-11-06)

- ✨ Interface gráfica moderna com Tkinter
- 🎨 Design nativo do macOS
- 📊 Log em tempo real
- ⚙️ Opções avançadas integradas
- 🔧 Correções para playlists e Vimeo
- 📱 Suporte melhorado para múltiplos sites
- ✅ Correção completa do download de MP3
- 🎯 Melhoria nos formatos de vídeo

### v1.0 (2025-10-28)

- 🚀 Release inicial
- 📦 App para Dock
- 💻 CLI interativo
- ⚡ Scripts de terminal

## 📄 Licença

Este projeto é de código aberto e está disponível sob a [Licença MIT](LICENSE).

## 🔗 Links Úteis

- **yt-dlp**: [github.com/yt-dlp/yt-dlp](https://github.com/yt-dlp/yt-dlp)
- **FFmpeg**: [ffmpeg.org](https://ffmpeg.org/)
- **Homebrew**: [brew.sh](https://brew.sh/)
- **Documentação do App**: [DESKTOP_APP_GUIDE.md](DESKTOP_APP_GUIDE.md)

## 💡 Dicas de Uso

1. **Para downloads rápidos**: Use o app do Dock
2. **Para opções avançadas**: Use o CLI interativo
3. **Para acompanhar progresso**: Use o app desktop com GUI
4. **Para Vimeo**: Sempre use cookies do navegador
5. **Para playlists grandes**: Marque "ignorar erros"
6. **Para economizar espaço**: Use formato 480p ou MP3

## ⚠️ Aviso Legal

Este software é fornecido apenas para uso pessoal. Respeite os direitos autorais e os termos de serviço dos sites de onde você baixa conteúdo. O autor não se responsabiliza pelo uso indevido desta ferramenta.

---

**Desenvolvido com ❤️ para a comunidade macOS**

**Versão:** 2.0
**Status:** ✅ Pronto para produção
**Última atualização:** 06/11/2025
