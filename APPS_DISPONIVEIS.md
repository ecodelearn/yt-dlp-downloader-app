# Apps Disponíveis - YT-DLP

Você tem **4 formas diferentes** de usar o YT-DLP no seu Mac. Cada uma serve para um propósito diferente!

## 📱 Apps Instalados

### 1. 🎯 YT-DLP Downloader (Download Rápido)

**Localização:** `~/Applications/YT-DLP Downloader.app`

**Como funciona:**
1. Copie a URL do vídeo (Cmd+C)
2. Clique no app
3. Escolha o formato em um diálogo simples
4. Pronto! Download começa automaticamente

**Melhor para:**
- ✅ Downloads rápidos
- ✅ Uso diário sem complicação
- ✅ Quando já tem URL na clipboard

**Formatos disponíveis:**
- Vídeo MP4 (Melhor)
- Vídeo 720p (Menor)
- Vídeo 480p (Muito Menor)
- Áudio MP3
- Vídeo com Legendas
- Playlist Áudio
- Playlist Vídeo

**Status:** ✅ **FUNCIONANDO PERFEITAMENTE**

---

### 2. 🖥️ YT-DLP Desktop (Interface Moderna)

**Localização:** `~/Applications/YT-DLP Desktop.app`

**Como funciona:**
1. Abra o app
2. Cole ou digite a URL
3. Escolha formato e opções avançadas
4. Clique em "Baixar"
5. Acompanhe progresso no log em tempo real

**Melhor para:**
- ✅ Quando quer ver o progresso
- ✅ Downloads com opções avançadas
- ✅ Vários downloads seguidos
- ✅ Ver logs detalhados

**Recursos extras:**
- Log em tempo real
- Botão cancelar
- Opções avançadas visíveis
- Seletor de pasta
- Detecção automática de Vimeo

**Status:** ⚠️ **REQUER PYTHON COM TKINTER**

**Solução alternativa:** Use `ytdl-gui-simple.sh` (ver abaixo)

---

### 3. 💻 CLI Interativo (Terminal)

**Arquivo:** `ytdl.py`

**Como usar:**
```bash
cd ~/Documents/projetos/yt-dlp-script
python3 ytdl.py
```

**Melhor para:**
- ✅ Usuários avançados
- ✅ Máximo controle
- ✅ Opções personalizadas
- ✅ Scripts automatizados

**Recursos:**
- Menu interativo no terminal
- Todos os presets disponíveis
- Download rápido e avançado
- Configuração de diretório

**Status:** ✅ **FUNCIONANDO**

---

### 4. 📜 GUI Simples (AppleScript)

**Arquivo:** `ytdl-gui-simple.sh`

**Como usar:**
```bash
cd ~/Documents/projetos/yt-dlp-script
./ytdl-gui-simple.sh
```

**Melhor para:**
- ✅ Alternativa ao Desktop app
- ✅ Quando Tkinter não funciona
- ✅ Interface nativa do macOS
- ✅ Compatibilidade total

**Recursos:**
- Menu principal
- Todos os formatos
- Configurações
- Sobre/informações

**Status:** ✅ **FUNCIONANDO PERFEITAMENTE**

---

## 🎯 Qual App Usar?

### Para Download Rápido
**Use:** YT-DLP Downloader.app (o que já estava funcionando)

```
1. Cmd+C na URL
2. Clique no app
3. Escolhe formato
4. Pronto!
```

### Para Controle e Visualização
**Use:** ytdl-gui-simple.sh

```bash
./ytdl-gui-simple.sh
```

### Para Terminal
**Use:** ytdl.py

```bash
python3 ytdl.py
```

---

## 🔧 Status de Cada App

| App | Status | Observação |
|-----|--------|------------|
| YT-DLP Downloader.app | ✅ OK | **RECOMENDADO para uso diário** |
| YT-DLP Desktop.app | ⚠️ Tkinter | Funciona com `/usr/bin/python3` |
| ytdl-gui-simple.sh | ✅ OK | Alternativa ao Desktop app |
| ytdl.py | ✅ OK | CLI interativo |

---

## 🚀 Recomendação Final

### 👍 Para Você (Uso Diário)

**1ª Opção:** `YT-DLP Downloader.app`
- Já está no Dock
- Funciona perfeitamente
- Mais rápido
- Interface simples

**2ª Opção:** `ytdl-gui-simple.sh`
- Quando quer mais controle
- Interface nativa
- Menu interativo

---

## 📝 Como Adicionar ao Dock

### YT-DLP Downloader (Rápido)
1. Abra Finder
2. Vá em `~/Applications/`
3. Arraste **YT-DLP Downloader.app** para o Dock
4. Pronto!

### ytdl-gui-simple.sh (Menu Interativo)

Criar atalho:
```bash
# Copie para Applications
cp ytdl-gui-simple.sh ~/Applications/

# Ou crie alias
echo "alias ytdl='~/Documents/projetos/yt-dlp-script/ytdl-gui-simple.sh'" >> ~/.zshrc
```

---

## 🐛 Problemas e Soluções

### YT-DLP Desktop não abre

**Solução:** Use uma das alternativas:
- ✅ YT-DLP Downloader.app
- ✅ ytdl-gui-simple.sh

### Quer interface gráfica moderna

**Solução:**
```bash
# Tente com Python do sistema
/usr/bin/python3 ~/Documents/projetos/yt-dlp-script/ytdl_gui.py

# Ou use a GUI simples
./ytdl-gui-simple.sh
```

### Nenhum app abre

**Verificar:**
```bash
# yt-dlp instalado?
which yt-dlp

# ffmpeg instalado?
which ffmpeg

# Se não:
brew install yt-dlp ffmpeg
```

---

## 📊 Comparação Completa

| Característica | Downloader | Desktop | GUI Simple | CLI |
|----------------|------------|---------|------------|-----|
| Velocidade | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| Interface | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐ |
| Compatibilidade | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| Recursos | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Log/Progress | ❌ | ✅ | ⚠️ | ✅ |
| Clipboard Auto | ✅ | ❌ | ❌ | ❌ |
| Opções Visual | ⚠️ | ✅ | ✅ | ✅ |

---

## 🎉 Conclusão

Você tem **múltiplas opções** funcionando!

**Recomendação:**
1. Use **YT-DLP Downloader.app** no dia a dia (já no Dock)
2. Use **ytdl-gui-simple.sh** quando precisar de mais controle
3. Use **ytdl.py** para automação/scripts

Todos estão **funcionando** e com os **bugs corrigidos**! 🚀
