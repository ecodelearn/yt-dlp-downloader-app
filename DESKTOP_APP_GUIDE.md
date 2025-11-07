# Guia do Aplicativo Desktop YT-DLP

## Sobre

O **YT-DLP Desktop** é uma interface gráfica moderna e intuitiva para o yt-dlp, permitindo download de vídeos e áudios de forma visual e amigável.

## Recursos

✨ **Interface Gráfica Moderna**
- Design nativo do macOS
- Interface limpa e intuitiva
- Log em tempo real do download

🎬 **Múltiplos Formatos**
- Vídeo em 3 qualidades (Melhor, 720p, 480p)
- Conversão para MP3
- Suporte para legendas
- Download de playlists completas

🔧 **Opções Avançadas**
- Ignorar erros em playlists
- Suporte para Vimeo e sites restritos
- Escolha do diretório de download
- Cookies do navegador automáticos

## Instalação

### 1. Pré-requisitos

```bash
# Instalar yt-dlp
brew install yt-dlp

# Instalar ffmpeg
brew install ffmpeg

# Python 3 (geralmente já vem no macOS)
python3 --version
```

### 2. Criar o Aplicativo

```bash
cd ~/Documents/projetos/yt-dlp-script
./create-desktop-app.sh
```

Isso criará o aplicativo em `~/Applications/YT-DLP Desktop.app`

### 3. Primeira Execução

1. Vá para `~/Applications/` no Finder
2. Dê dois cliques em **YT-DLP Desktop.app**
3. Se o macOS bloquear, vá em:
   - **Preferências do Sistema** → **Segurança e Privacidade**
   - Clique em **"Abrir Assim Mesmo"**

## Como Usar

### Download Básico

1. **Cole a URL** do vídeo no campo superior
   - Use o botão "Colar" para colar da clipboard
   - Ou digite/cole manualmente (Cmd+V)

2. **Escolha o formato**:
   - **Vídeo (Melhor Qualidade MP4)**: Máxima qualidade disponível
   - **Vídeo Compacto (720p)**: HD com arquivo menor
   - **Vídeo Pequeno (480p)**: SD, arquivo muito menor
   - **Áudio MP3**: Apenas o áudio
   - **Vídeo com Legendas (EN)**: Vídeo + legendas em inglês
   - **Playlist Completa (Vídeo)**: Baixa toda a playlist em vídeo
   - **Playlist Completa (Áudio)**: Baixa toda a playlist em MP3

3. **Clique em "Baixar"**
   - O download iniciará imediatamente
   - Você verá o progresso no log em tempo real

4. **Aguarde a conclusão**
   - Uma mensagem aparecerá quando terminar
   - Use "Abrir Pasta" para acessar os arquivos

### Opções Avançadas

#### Ignorar erros em playlist
- Ativado por padrão para playlists
- Continua o download mesmo se um vídeo falhar

#### Usar cookies do Chrome (Vimeo)
- Ative para downloads do Vimeo
- Útil para sites que requerem login
- Certifique-se de estar logado no Chrome

#### Alterar diretório
- Clique em "Alterar" para escolher outra pasta
- Padrão: `~/Downloads`

## Atalhos e Dicas

### Atalhos do Teclado
- **Cmd+V**: Colar URL no campo
- **Cmd+Q**: Sair do aplicativo

### Dicas de Uso

1. **Download Rápido**:
   - Copie a URL (Cmd+C no navegador)
   - Abra o app
   - Clique em "Colar"
   - Clique em "Baixar"

2. **Para Playlists**:
   - Use as opções "Playlist Completa"
   - Marque "Ignorar erros" para pular vídeos privados/removidos

3. **Para Vimeo**:
   - Marque "Usar cookies do Chrome"
   - Certifique-se de estar logado no Vimeo pelo Chrome
   - Ou use Safari e desmarque a opção

4. **Verificar Andamento**:
   - Acompanhe o log em tempo real
   - A barra de progresso indica que o download está ativo

## Formatos de Vídeo

| Formato | Resolução | Tamanho Aproximado | Uso Recomendado |
|---------|-----------|-------------------|-----------------|
| Melhor | Variável (até 4K) | 100% | Máxima qualidade, arquivar |
| 720p | 1280x720 | 60-70% | Equilíbrio qualidade/tamanho |
| 480p | 854x480 | 30-40% | Economia de espaço, mobile |

Todos os vídeos são convertidos para MP4 (H.264 + AAC) para compatibilidade universal.

## Solução de Problemas

### "yt-dlp não encontrado"
```bash
brew install yt-dlp
```

### "ffmpeg não encontrado"
```bash
brew install ffmpeg
```

### App não abre
1. Vá em **Preferências do Sistema** → **Segurança e Privacidade**
2. Clique em **"Abrir Assim Mesmo"**

### Erro com Vimeo
1. Marque "Usar cookies do Chrome"
2. Certifique-se de estar logado no Vimeo pelo Chrome
3. Ou tente desmarcar e usar cookies do Safari

### Download travou
1. Clique em "Cancelar"
2. Verifique sua conexão de internet
3. Tente novamente

### Playlist não baixa tudo
- Certifique-se de marcar "Ignorar erros em playlist"
- Alguns vídeos podem ser privados ou removidos

## Recursos Avançados

### Ver Logs Completos

O app salva logs detalhados. Para ver:
```bash
log show --predicate 'subsystem == "YTDLP-Desktop"' --last 1h
```

### Atualizar yt-dlp

```bash
brew upgrade yt-dlp
```

### Comandos Manuais

Se preferir usar o terminal:
```bash
cd ~/Downloads
yt-dlp -f 'bv*+ba/b' --merge-output-format mp4 "URL"
```

## Diferenças entre Apps

Este projeto contém três formas de usar o YT-DLP:

1. **YT-DLP Desktop** (novo - GUI moderna):
   - Interface gráfica completa
   - Melhor para uso regular
   - Mais opções visíveis
   - Log em tempo real

2. **YT-DLP Downloader** (Dock app):
   - Diálogo simples
   - Mais rápido para downloads rápidos
   - Apenas formatos principais

3. **ytdl.py** (CLI interativo):
   - Terminal interativo
   - Máximo controle
   - Opções avançadas

Escolha o que melhor se adapta ao seu uso!

## Adicionar ao Dock

1. Abra `~/Applications/` no Finder
2. Arraste **YT-DLP Desktop.app** para o Dock
3. Pronto! Acesso rápido sempre disponível

## Atalho de Teclado Global (Opcional)

Para criar um atalho global:

1. Vá em **Preferências do Sistema** → **Teclado** → **Atalhos**
2. Selecione **Serviços** na barra lateral
3. Procure por serviços do YT-DLP
4. Adicione o atalho desejado (ex: Cmd+Shift+D)

## Suporte

- **Issues**: [GitHub Issues](https://github.com/seu-usuario/yt-dlp-script/issues)
- **Documentação yt-dlp**: [github.com/yt-dlp/yt-dlp](https://github.com/yt-dlp/yt-dlp)

## Changelog

### v2.0 (2025-11-06)
- ✨ Interface gráfica moderna com Tkinter
- 🎨 Design nativo do macOS
- 📊 Log em tempo real
- ⚙️ Opções avançadas integradas
- 🔧 Correções para playlists e Vimeo
- 📱 Suporte melhorado para múltiplos sites

### v1.0 (2025-10-28)
- 🚀 Release inicial
- 📦 App para Dock
- 💻 CLI interativo
