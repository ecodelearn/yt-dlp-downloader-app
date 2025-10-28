# Issues para Criar no GitHub

## Issue #1: 🐛 Playlist de vídeo não funciona

**Labels**: `bug`, `enhancement`

### Descrição do Problema

A opção **"Playlist Vídeo"** no app não está funcionando corretamente.

### Comportamento Esperado

Ao selecionar "Playlist Vídeo" e fornecer uma URL de playlist do YouTube, o sistema deveria:
- Detectar todos os vídeos da playlist
- Baixar todos os vídeos em formato MP4
- Mesclar vídeo e áudio de cada item

### Comportamento Atual

O download de playlist não está funcionando. Possíveis sintomas:
- Baixa apenas o primeiro vídeo
- Falha com erro
- Não detecta a playlist corretamente

### Ambiente

- **macOS**: 10.15+
- **yt-dlp**: 2025.10.22
- **App**: YT-DLP Downloader (Dock/Desktop)

### Arquivos Relacionados

- `ytdl-quick.sh` (linha 96-103)
- `ytdl.py` (linha 55-58)

### Código Atual

```bash
"Playlist Vídeo")
    /usr/local/bin/yt-dlp --yes-playlist \
        -f 'bv*[vcodec^=avc]+ba[acodec^=mp4a]/bv*+ba/b' \
        --merge-output-format mp4 \
        --remux-video mp4 \
        --ffmpeg-location /usr/local/bin/ffmpeg \
        "$URL"
    ;;
```

### Possíveis Causas

1. Filtro de formato muito restritivo para playlists
2. Timeout em playlists grandes
3. Falta de tratamento de erros em itens individuais
4. Problema com detecção de URL de playlist

### Solução Proposta

- Simplificar filtro de formato para playlists
- Adicionar opção `-i` (ignore errors) para continuar em caso de falha
- Usar formato mais universal: `bv*+ba/b`
- Adicionar `--cookies-from-browser safari` para compatibilidade
- Testar com playlist real

### Código Sugerido

```bash
"Playlist Vídeo")
    /usr/local/bin/yt-dlp --yes-playlist -i \
        -f 'bv*+ba/b' \
        --merge-output-format mp4 \
        --recode-video mp4 \
        --cookies-from-browser safari \
        --ffmpeg-location /usr/local/bin/ffmpeg \
        "$URL"
    ;;
```

### Para Reproduzir

1. Copiar URL de playlist do YouTube (ex: `https://www.youtube.com/playlist?list=...`)
2. Clicar no app "YT-DLP Downloader"
3. Selecionar "Playlist Vídeo"
4. Observar o erro

---

## Issue #2: 🐛 Download de Vimeo não funciona

**Labels**: `bug`, `vimeo`, `authentication`

### Descrição do Problema

O download de vídeos do Vimeo não está funcionando, mesmo após adicionar `--cookies-from-browser safari`.

### Comportamento Esperado

Ao tentar baixar vídeo do Vimeo:
- Sistema deveria usar cookies do Safari
- Baixar vídeo mesmo se usuário estiver logado
- Funcionar com vídeos públicos do Vimeo

### Comportamento Atual

Erro retornado pelo yt-dlp:
```
ERROR: [vimeo] 76979871: The web client only works when logged-in. 
Use --cookies, --cookies-from-browser, --username and --password, --netrc-cmd, 
or --netrc (vimeo) to provide account credentials.
```

### Ambiente

- **macOS**: 10.15+
- **yt-dlp**: 2025.10.22
- **Safari**: Versão atual
- **App**: YT-DLP Downloader (Dock/Desktop)

### Arquivos Relacionados

- `ytdl-quick.sh` (linha 41-48, 75-82, 84-91)
- `ytdl.py` (linha 27-38)

### Possíveis Causas

1. Vimeo mudou política de acesso e requer login obrigatório
2. `--cookies-from-browser safari` não está funcionando corretamente
3. yt-dlp precisa de atualização para Vimeo
4. Necessário impersonation browser
5. Vídeo específico é privado/restrito

### Investigação Necessária

- [ ] Testar com vídeo público do Vimeo
- [ ] Verificar se Safari tem cookies do Vimeo ativos
- [ ] Testar com `--cookies-from-browser chrome` ou `firefox`
- [ ] Verificar logs completos do yt-dlp
- [ ] Testar com última versão do yt-dlp
- [ ] Verificar se precisa de impersonation: `--impersonate chrome`

### Soluções Alternativas

#### 1. Usar Chrome ao invés do Safari

```bash
--cookies-from-browser chrome
```

#### 2. Exportar cookies manualmente

```bash
# Usar extensão para exportar cookies do Vimeo
--cookies /path/to/cookies.txt
```

#### 3. Adicionar impersonation

```bash
--impersonate chrome --cookies-from-browser chrome
```

#### 4. Login direto (não recomendado para app)

```bash
--username "seu_email" --password "sua_senha"
```

### Para Reproduzir

1. Copiar URL de vídeo do Vimeo (ex: `https://vimeo.com/76979871`)
2. Clicar no app "YT-DLP Downloader"
3. Selecionar qualquer formato de vídeo
4. Observar erro: "The web client only works when logged-in"

### Testes Adicionais Necessários

```bash
# Teste 1: Verificar versão do yt-dlp
yt-dlp --version

# Teste 2: Atualizar yt-dlp
yt-dlp -U

# Teste 3: Testar com vídeo público
yt-dlp --cookies-from-browser safari "https://vimeo.com/148751763"

# Teste 4: Listar formatos disponíveis
yt-dlp -F --cookies-from-browser safari "URL_VIMEO"

# Teste 5: Testar com impersonation
yt-dlp --impersonate chrome --cookies-from-browser chrome "URL_VIMEO"
```

### Documentação Relevante

- [yt-dlp Vimeo Extractor](https://github.com/yt-dlp/yt-dlp/blob/master/yt_dlp/extractor/vimeo.py)
- [yt-dlp Cookies Documentation](https://github.com/yt-dlp/yt-dlp/wiki/FAQ#how-do-i-pass-cookies-to-yt-dlp)
- [yt-dlp Impersonation](https://github.com/yt-dlp/yt-dlp#impersonation)

### Prioridade

**Média** - Vimeo é um caso de uso importante, mas YouTube funciona corretamente.

---

## Como Criar as Issues no GitHub

1. Acesse: https://github.com/ecodelearn/yt-dlp-downloader-app/issues
2. Clique em "New Issue"
3. Copie o título e corpo de cada issue acima
4. Adicione as labels sugeridas
5. Clique em "Submit new issue"

Ou use o GitHub CLI:

```bash
# Instalar gh CLI
brew install gh

# Autenticar
gh auth login

# Criar issues
gh issue create --title "🐛 Playlist de vídeo não funciona" --label bug,enhancement --body "..."
gh issue create --title "🐛 Download de Vimeo não funciona" --label bug,vimeo,authentication --body "..."
```
