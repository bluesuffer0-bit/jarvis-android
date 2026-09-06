# Jarvis on Android

What ports, honestly:

- **The typed agent (yes).** Claude Code runs on the phone inside Termux (a Linux layer for Android), talking to your B AI provider with `glm-5.3-flash`, booting as Jarvis from the same boot config.
- **The memory (yes, if you sync it).** The vault is plain markdown. Push it to a private GitHub repo from the PC, clone it on the phone, and both Jarvises share one memory. Obsidian's Android app can open the same repo folder later if you want to browse it on the phone.
- **The face (yes).** ai-visualizer is one dependency-free Python server; the phone's browser opens the circuit board at `http://127.0.0.1:8790`.
- **The voice (no).** Not with ElevenLabs either — ElevenLabs replaces the voice *model*, but the missing pieces on a phone are the audio plumbing: mic capture and playback through Termux's Linux layer, plus the speech-to-text model that turns your words into text before Jarvis can answer. The voice lives at the desk. If you ever want phone voice for real, that's a custom build — ask Jarvis about it as a project.

## Setup (about 15 minutes, mostly downloads)

1. **Install Termux from F-Droid** — https://f-droid.org/en/packages/com.termux/ . Do NOT use the Play Store version; it is abandoned and broken.
2. **Send `setup-android.sh` to the phone** (email it to yourself, Google Drive, USB — anything).
3. In Termux, run:
   ```
   termux-setup-storage
   bash ~/storage/downloads/setup-android.sh
   ```
   (approve the storage prompt). It installs Ubuntu under Termux, then Claude Code, the boot config, the vault, and the face — all by itself.
4. **Paste your API key** (the only hands-on step). The script prints exactly what to run: `nano ~/.jarvis.env` inside Ubuntu, replace `PASTE-YOUR-KEY` with your real key. Same key as the PC.
5. Close and reopen Termux. Then:
   - `jarvis` — typed Jarvis, right in the terminal.
   - `jarvis-face` — the circuit board opens in your browser.

## Sharing the memory (do this on the PC first)

1. Create a **private** GitHub repo (empty is fine), e.g. `brain-vault`.
2. On the PC run: `bash C:\Users\RDP\my-agent\port-android\sync-vault-to-git.sh https://github.com/YOU/brain-vault.git` — it pushes your vault up.
3. On the phone, when the setup script asks for the vault URL, paste the same URL. After that, each side pulls at session start and pushes after writing (the boot config tells Jarvis how).

## If you'd rather skip Termux entirely

You can control the desk agent from the phone instead: install **Termius** (SSH app), connect to this PC over **Tailscale** (free, both devices), and run `claude` in `C:\Users\RDP\my-agent` from the phone — that IS Jarvis, running on the PC, typed from your phone.

## Honest status

Written and syntax-checked on the PC; **not yet run on a real Android device** — there isn't one attached here. If a step fails on the phone, paste the error to Jarvis on the PC and he'll fix the script.
