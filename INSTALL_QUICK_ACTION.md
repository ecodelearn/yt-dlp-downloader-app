# Como Instalar Quick Actions no macOS

Este guia vai te ajudar a criar ações rápidas para baixar vídeos clicando com botão direito (ou copiar a URL).

## Método 1: Quick Action com Menu de Contexto (Recomendado)

### Passo 1: Abrir o Automator

1. Abra o **Spotlight** (Cmd + Space)
2. Digite **Automator** e pressione Enter
3. Clique em **Novo Documento**
4. Selecione **Ação Rápida** (Quick Action)

### Passo 2: Configurar a Ação

1. No topo da janela, configure:
   - **O fluxo de trabalho recebe:** `sem entrada`
   - **em:** `qualquer aplicativo`

2. Na barra de busca à esquerda, procure por **"Executar Script Shell"**

3. Arraste **"Executar Script Shell"** para a área de trabalho à direita

4. No campo de script, cole o seguinte código:

```bash
# Caminho completo do script
/Users/ecode/Documents/projetos/yt-dlp-script/quick-download-gui.sh
```

### Passo 3: Salvar a Ação

1. Vá em **Arquivo → Salvar** (Cmd + S)
2. Dê um nome: **"Download Vídeo (YT-DLP)"**
3. A ação será salva automaticamente em `~/Library/Services/`

### Passo 4: Usar a Ação

**Agora você pode usar de 3 formas:**

#### Opção A: Pelo Menu de Serviços
1. Copie a URL do vídeo (Cmd + C)
2. Vá em qualquer aplicativo
3. Menu superior → **Nome do App → Serviços → Download Vídeo (YT-DLP)**
4. Escolha o tipo de download no diálogo

#### Opção B: Botão Direito (em texto selecionado)
1. Selecione a URL do vídeo
2. Clique com botão direito
3. **Serviços → Download Vídeo (YT-DLP)**

#### Opção C: Atalho de Teclado (Configure você mesmo)
1. Vá em **Preferências do Sistema → Teclado → Atalhos**
2. Clique em **Serviços** na barra lateral
3. Encontre **Download Vídeo (YT-DLP)**
4. Clique duas vezes e defina um atalho (ex: Cmd + Shift + D)

---

## Método 2: Criar Múltiplas Quick Actions (Um clique para cada tipo)

Você pode criar uma ação rápida para cada tipo de download:

### Quick Action 1: Download Vídeo MP4

Repita os passos acima, mas use este script:

```bash
#!/bin/bash
URL=$(pbpaste)
source /Users/ecode/Documents/projetos/yt-dlp-script/venv/bin/activate
cd ~/Downloads
yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' "$URL"
osascript -e 'display notification "Download concluído!" with title "YT-DLP"'
open ~/Downloads
```

Salve como: **"YT-DLP: Baixar Vídeo"**

### Quick Action 2: Download Áudio MP3

```bash
#!/bin/bash
URL=$(pbpaste)
source /Users/ecode/Documents/projetos/yt-dlp-script/venv/bin/activate
cd ~/Downloads
yt-dlp -x --audio-format mp3 "$URL"
osascript -e 'display notification "Download de áudio concluído!" with title "YT-DLP"'
open ~/Downloads
```

Salve como: **"YT-DLP: Baixar Áudio MP3"**

### Quick Action 3: Download Playlist (Áudio)

```bash
#!/bin/bash
URL=$(pbpaste)
source /Users/ecode/Documents/projetos/yt-dlp-script/venv/bin/activate
cd ~/Downloads
yt-dlp --yes-playlist -x --audio-format mp3 "$URL"
osascript -e 'display notification "Playlist baixada!" with title "YT-DLP"'
open ~/Downloads
```

Salve como: **"YT-DLP: Baixar Playlist (Áudio)"**

---

## Método 3: Adicionar ao Dock

### Criar App Droplet (Arrastar e Soltar)

1. Abra o **Automator**
2. Novo Documento → **Aplicativo**
3. Adicione **"Executar Script Shell"**
4. Cole este código:

```bash
for URL in "$@"
do
    source /Users/ecode/Documents/projetos/yt-dlp-script/venv/bin/activate
    cd ~/Downloads

    # Mostra diálogo
    CHOICE=$(osascript -e 'choose from list {"Vídeo MP4", "Áudio MP3", "Playlist"} with prompt "Tipo de download:"')

    case "$CHOICE" in
        "Vídeo MP4")
            yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' "$URL"
            ;;
        "Áudio MP3")
            yt-dlp -x --audio-format mp3 "$URL"
            ;;
        "Playlist")
            yt-dlp --yes-playlist -x --audio-format mp3 "$URL"
            ;;
    esac
done

osascript -e 'display notification "Downloads concluídos!" with title "YT-DLP"'
open ~/Downloads
```

5. Salve como **Aplicativo** com nome **YT-DLP Downloader**
6. Arraste o app para o Dock
7. **Para usar:** Arraste uma URL ou arquivo de texto com URLs para o ícone no Dock

---

## Método 4: Integração com o Navegador (Chrome/Safari)

### Usando uma Bookmarklet

1. Adicione um novo favorito
2. No campo URL, cole:

```javascript
javascript:(function(){navigator.clipboard.writeText(window.location.href);window.open('shortcuts://run-shortcut?name=Download%20Vídeo%20(YT-DLP)')})();
```

3. Dê o nome: **"📥 Download"**
4. Quando estiver em um vídeo, clique no favorito

---

## Testando

### Teste rápido:

1. Copie esta URL de teste:
   ```
   https://www.youtube.com/watch?v=dQw4w9WgXcQ
   ```

2. Use qualquer um dos métodos acima

3. Verifique a pasta **~/Downloads**

---

## Troubleshooting

### Erro: "Permissão Negada"

Execute no Terminal:

```bash
chmod +x /Users/ecode/Documents/projetos/yt-dlp-script/*.sh
```

### Erro: "yt-dlp não encontrado"

Certifique-se de que o ambiente virtual foi criado:

```bash
cd /Users/ecode/Documents/projetos/yt-dlp-script
./setup.sh
```

### Quick Action não aparece no menu

1. Vá em **Preferências do Sistema → Extensões**
2. Clique em **Finder**
3. Certifique-se de que sua Quick Action está marcada

### Quer mudar o diretório de download?

Edite os scripts e mude `~/Downloads` para o caminho desejado.

---

## Dicas Extras

- **Notificações:** As ações mostram notificações quando concluídas
- **Auto-open:** A pasta Downloads abre automaticamente após o download
- **Clipboard:** As ações pegam automaticamente a URL da clipboard
- **Múltiplas URLs:** Separe com espaço ou nova linha

---

## Desinstalar

Para remover as Quick Actions:

```bash
rm ~/Library/Services/"Download Vídeo (YT-DLP).workflow"
```

Ou vá em `~/Library/Services/` e delete os arquivos `.workflow` manualmente.
