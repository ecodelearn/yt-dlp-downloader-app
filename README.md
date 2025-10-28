# YT-DLP Downloader

Sistema completo para download de vídeos do YouTube com interface gráfica para macOS, incluindo app para o Dock e CLI interativo.

## Características

- **App para Dock/Desktop**: Clique e baixe vídeos direto da área de trabalho
- **CLI Interativo**: Interface de linha de comando com menus intuitivos
- **Quick Actions**: Atalhos no menu de contexto do macOS
- **Múltiplos Formatos**: Vídeo em várias qualidades, áudio MP3, playlists
- **Compatibilidade Total**: Vídeos em MP4 (H.264 + AAC) compatíveis com QuickTime e WhatsApp
- **Download Inteligente**: Merge automático de vídeo e áudio
- **Legendas**: Suporte para legendas automáticas e enviadas

## Formatos Disponíveis

### Vídeo
- **Vídeo MP4 (Melhor)**: Máxima qualidade disponível em MP4 (H.264)
- **Vídeo 720p (Menor)**: Resolução HD, arquivos ~30-40% menores
- **Vídeo 480p (Muito Menor)**: Resolução SD, arquivos ~60-70% menores
- **Vídeo com Legendas**: Melhor qualidade + legendas em inglês

### Áudio
- **Áudio MP3**: Extração de áudio em formato MP3

### Playlist
- **Playlist Completa (Vídeo)**: Baixa todos os vídeos de uma playlist
- **Playlist Completa (Áudio)**: Baixa todo o áudio de uma playlist em MP3

## Instalação

### 1. Certifique-se de ter o yt-dlp instalado

```bash
brew install yt-dlp
```

ou

```bash
pip install yt-dlp
```

### 2. Configure o ambiente virtual e instale as dependências

```bash
# Crie o ambiente virtual
python3 -m venv venv

# Ative o ambiente virtual
source venv/bin/activate

# Instale as dependências
pip install -r requirements.txt
```

### 3. Torne o script executável (opcional)

```bash
chmod +x ytdl.py
```

## Uso

### Com o ambiente virtual ativado:

```bash
python ytdl.py
```

ou (se tornou executável):

```bash
./ytdl.py
```

## Presets Disponíveis

- **Vídeo (Melhor Qualidade MP4)**: Download de vídeo na melhor qualidade em MP4
- **Áudio MP3**: Extrai apenas o áudio em formato MP3
- **Vídeo com Legendas (EN)**: Download com legendas em inglês
- **Vídeo com Legendas Auto**: Download com legendas geradas automaticamente
- **Playlist Completa (Áudio MP3)**: Baixa toda a playlist em áudio
- **Playlist Completa (Vídeo MP4)**: Baixa toda a playlist em vídeo

## Opções Avançadas

No modo avançado, você pode:

- Listar playlist sem baixar
- Trim de nomes de arquivos (20 caracteres)
- Usar ID do vídeo como nome
- Adicionar legendas (manuais ou automáticas)
- Ignorar erros em playlists
- Selecionar itens específicos de playlists (ex: 1,3-15)

## Exemplos de Uso

### Download Rápido
1. Execute o programa
2. Escolha "Download Rápido"
3. Cole a URL
4. Selecione o preset desejado

### Download de Playlist Parcial
1. Execute o programa
2. Escolha "Download Avançado"
3. Cole a URL da playlist
4. Marque as opções desejadas
5. Informe "sim" para playlist
6. Escolha "Selecionar itens específicos"
7. Digite os itens (ex: 1,3-15)

## Configuração

O diretório padrão de download é `~/Downloads`. Você pode alterá-lo no menu principal.

## Requisitos

- Python 3.8+
- yt-dlp
- macOS (testado no Sonoma)

---

## Instalação Quick Actions (Clique com Botão Direito)

Para instalar as Quick Actions do macOS e poder baixar vídeos com clique direito:

```bash
cd /Users/ecode/Documents/projetos/yt-dlp-script
./create-workflows.sh
```

Isso criará 4 Quick Actions:

1. **YT-DLP Download** - Abre diálogo com opções (Recomendado)
2. **YT-DLP Baixar Vídeo** - Download direto de vídeo
3. **YT-DLP Baixar Áudio MP3** - Download direto de áudio
4. **YT-DLP Baixar Playlist** - Download direto de playlist

### Como usar Quick Actions:

1. **Copie a URL** do vídeo (Cmd + C)
2. **Acesse o menu de 3 formas:**
   - Menu do App → Serviços → YT-DLP...
   - Botão direito (em qualquer lugar) → Serviços → YT-DLP...
   - Configure atalho de teclado em: Preferências → Teclado → Atalhos → Serviços

3. O download inicia automaticamente na pasta ~/Downloads
4. Uma notificação aparece quando concluir

### Configurar Atalho de Teclado:

1. Vá em **Preferências do Sistema → Teclado → Atalhos**
2. Clique em **Serviços** na barra lateral
3. Encontre **YT-DLP Download**
4. Clique duas vezes e pressione seu atalho (ex: Cmd + Shift + D)

Veja o guia completo em [INSTALL_QUICK_ACTION.md](INSTALL_QUICK_ACTION.md)

---

## Baseado em

Este programa automatiza os comandos do arquivo [exemplox.txt](exemplox.txt), transformando-os em uma interface interativa e Quick Actions do macOS.
# yt-dlp-downloader-app
