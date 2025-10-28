# Guia Rápido - YT-DLP Downloader

## Status da Instalação: ✅ COMPLETO

Tudo foi instalado e testado com sucesso!

---

## Método Mais Fácil: App no Desktop (RECOMENDADO)

### O que foi criado:

Um aplicativo chamado **"YT-DLP Downloader.app"** está agora no seu **Desktop**.

### Como usar:

1. **Copie a URL** do vídeo que deseja baixar (Cmd + C)
2. **Clique duas vezes** no app "YT-DLP Downloader" no Desktop
3. **Escolha o tipo** de download no diálogo:
   - Vídeo MP4
   - Áudio MP3
   - Vídeo com Legendas
   - Playlist Áudio
   - Playlist Vídeo
4. **Aguarde** a notificação de conclusão
5. **A pasta Downloads abre automaticamente** com o arquivo baixado

### Colocar no Dock (Opcional):

1. **Arraste** o app "YT-DLP Downloader" do Desktop para o **Dock**
2. Agora você tem acesso com um clique!

---

## Teste Agora Mesmo:

1. Copie esta URL de teste (é o primeiro vídeo do YouTube - 18 segundos):
   ```
   https://www.youtube.com/watch?v=jNQXAC9IVRw
   ```

2. Clique duas vezes no app "YT-DLP Downloader" no Desktop

3. Escolha "Áudio MP3" (é rápido)

4. Aguarde a notificação!

---

## Outros Métodos Disponíveis:

### 2. CLI Interativa (Terminal)

Para uso avançado com todas as opções:

```bash
cd /Users/ecode/Documents/projetos/yt-dlp-script
source venv/bin/activate
python ytdl.py
```

### 3. Script Rápido (Terminal)

Para download rápido direto do terminal:

```bash
/Users/ecode/Documents/projetos/yt-dlp-script/ytdl-quick.sh
```

### 4. Quick Actions do macOS

As Quick Actions foram criadas em `~/Library/Services/`, mas podem precisar de alguns minutos para aparecer no menu de Serviços.

Para usar:
- Copie uma URL (Cmd + C)
- Clique com botão direito em qualquer lugar
- Vá em: **Serviços → YT-DLP Download**

Se não aparecer imediatamente:
1. Reinicie o Mac, ou
2. Vá em **Preferências → Extensões → Finder** e habilite os serviços YT-DLP

---

## Localização dos Downloads:

Todos os vídeos são baixados em: **~/Downloads**

---

## Solução de Problemas:

### App não abre ou dá erro de permissão:

```bash
chmod +x /Users/ecode/Documents/projetos/yt-dlp-script/ytdl-quick.sh
```

### Erro de certificado SSL:

O script usa o yt-dlp instalado no sistema (`/usr/local/bin/yt-dlp`) que já funciona corretamente.

### Quick Actions não aparecem:

Use o método do App no Desktop - é mais simples e confiável!

---

## Arquivos Criados:

- ✅ `ytdl.py` - CLI interativa completa
- ✅ `ytdl-quick.sh` - Script de download rápido
- ✅ `~/Desktop/YT-DLP Downloader.app` - App para Dock
- ✅ `~/Library/Services/YT-DLP *.workflow` - Quick Actions (4)
- ✅ `venv/` - Ambiente virtual Python
- ✅ Scripts de instalação e teste

---

## Próximos Passos:

1. **Teste agora** com a URL de exemplo acima
2. **Arraste o app** para o Dock para acesso rápido
3. **Curta** a facilidade de baixar vídeos com 2 cliques!

---

## Tipos de Download Disponíveis:

| Tipo | Formato | Qualidade | Uso |
|------|---------|-----------|-----|
| Vídeo MP4 | **MP4** | Melhor disponível | Assistir offline |
| Áudio MP3 | **MP3** | Melhor áudio | Músicas, podcasts |
| Vídeo com Legendas | **MP4 + SRT** | Melhor + legendas EN | Estudar idiomas |
| Playlist Áudio | **MP3** | Todos os itens | Álbuns completos |
| Playlist Vídeo | **MP4** | Todos os itens | Séries, cursos |

**Importante:** Todos os vídeos são sempre salvos em formato **MP4** (não m4a), garantindo compatibilidade máxima com todos os players!

---

**Divirta-se baixando vídeos! 🎥**
