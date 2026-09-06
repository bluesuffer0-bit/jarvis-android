# Jarvis for Android

The Android port of the fullstack-agent stack: your Jarvis agent running on your phone, with shared memory with the PC copy and the circuit-board face in your phone's browser.

**What works on the phone:**

- **Typed Jarvis** — Claude Code inside Termux, on your B AI provider (`glm-5.3-flash`), booting from the same Jarvis identity.
- **Shared memory** — the Brain vault syncs through a private GitHub repo, so phone-Jarvis and PC-Jarvis are one brain, not two.
- **The face** — `jarvis-face` starts the visualizer server and opens the board in your browser, wired to the same signal bus the voice writes.
- **The voice (walkie-talkie)** — `jarvis-voice`: Android's speech recognition for ears, claude for the brain, ElevenLabs for the mouth (falls back to Android's built-in voice without a key). Say something, Jarvis answers out loud, and the circuit board follows along. Honest limits: it is push-to-talk, not ambient — a Google dialog pops each turn instead of always listening, and it cannot be interrupted mid-sentence. The PC's backtalk stays the premium voice experience; this is the phone-grade version.

**Requirements:** an Android phone (64-bit — every phone from roughly 2018 onward), about 1 GB of storage, and internet.

---

## Part A — on the PC first (10 minutes)

1. **Create a private GitHub repo** for the memory. Name it anything (e.g. `brain-vault`), set it to **Private**, and create it empty (no README).
2. **Push your vault up.** In Git Bash (or ask Jarvis):
   ```
   bash /c/Users/RDP/my-agent/port-android/sync-vault-to-git.sh https://github.com/bluesuffer0-bit/brain-vault.git
   ```
   The first push opens a GitHub sign-in window — that's Git Credential Manager doing its one-time job.
3. Have your **B AI API key** handy (the same one the PC uses).

## Part B — on the phone (15 minutes, mostly downloads)

1. **Install Termux from F-Droid:** https://f-droid.org/en/packages/com.termux/
   Do NOT use the Play Store version — it is abandoned and broken.
2. **Get `setup-android.sh` onto the phone** — either:
   - from the GitHub repo (if it exists): open Termux and run
     ```
     curl -fsSL https://raw.githubusercontent.com/bluesuffer0-bit/jarvis-android/main/setup-android.sh -o setup-android.sh
     ```
   - or from the zip: send the zip to the phone (email/Drive/USB), extract it with the Files app, and copy `setup-android.sh` into the Downloads folder.
3. **Run it.** In Termux:
   ```
   termux-setup-storage
   bash ~/storage/downloads/setup-android.sh
   ```
   Approve the storage permission, then let it work. It installs Ubuntu (about 300 MB), then Claude Code, the boot config, the vault, and the face — all by itself.
4. **Paste your API key** — the only hands-on step. The script prints this when it finishes:
   ```
   proot-distro login ubuntu
   nano ~/.jarvis.env
   ```
   Replace `PASTE-YOUR-KEY` with your real key (Ctrl-O saves, Ctrl-X exits), then type `exit` to leave Ubuntu.
5. **Close and reopen Termux.** Then:
   - `jarvis` — typed Jarvis, right in the terminal. First reply: *"All systems online, sir. What are we working on today?"*
   - `jarvis-face` — the circuit board opens in your browser at `http://127.0.0.1:8790`. Keep the Termux window open while the face runs.

## Part C — daily use

- **Typed chat:** open Termux, type `jarvis`. Same personality, same memory, same model as the PC.
- **Voice:** install the **Termux:API app** from F-Droid first (https://f-droid.org/en/packages/com.termux.api/ — the plugin app that hands Termux the mic and speaker), then type `jarvis-voice`. He greets you out loud; each turn pops a Google listening dialog; his reply comes through the speaker (ElevenLabs if you put `export ELEVENLABS_API_KEY="..."` in `~/.jarvis.env`, Android's voice otherwise). Say "goodbye" to hang up. Run `jarvis-face` in a second Termux session and the circuit board follows the conversation live.
  One honest tradeoff baked in: the voice line runs Claude with auto-approved permissions (it cannot stop and ask mid-walkie-talkie). Its blast radius is the phone's own Ubuntu sandbox — your Android files stay outside it. The typed line still behaves like the PC.
- **Memory sync:** phone-Jarvis pulls the vault when a session starts and pushes after it writes (the boot config tells him how — `git pull`/`git push` in `~/Brain`). On the PC, run the sync script (or ask Jarvis) to push your latest vault before long phone sessions and after PC ones. Conflicts are rare and Jarvis can reconcile them.
- **Stopping things:** Ctrl-C in Termux stops whatever is running; closing the Termux window stops everything.
- **Updating:** delete nothing; re-run `setup-android.sh` — it is safe to re-run and only fills in what is missing.

## Troubleshooting

- **`bash: ~/storage/downloads/...: No such file`** — run `termux-setup-storage` first and accept the permission prompt.
- **Jarvis says "Please run /login"** — the key in `~/.jarvis.env` is still the placeholder, or Termux wasn't restarted after editing it. `nano ~/.jarvis.env`, fix, `exit`, reopen Termux.
- **`jarvis: command not found`** — restart Termux (the launcher PATH is added to `.bashrc`).
- **Old 32-bit phone / install.sh fails** — the native Claude Code build needs arm64. Anything recent works; a 2016-era phone may not.
- **Anything else** — paste the exact error to Jarvis on the PC. Fixing this stack is his job, not yours.

## No-Termux alternative: control the desk agent instead

If you'd rather not run Linux on the phone: install **Tailscale** (free) on PC and phone, install **Termius** (SSH app) on the phone, and connect to the PC over Tailscale. Then `claude` in `C:\Users\RDP\my-agent` from your phone IS Jarvis — running on the PC, typed from anywhere.

## Honest status

Written and syntax-checked on the PC; **not yet run on a real Android device.** If a step misbehaves, paste the error to PC-Jarvis — the fix belongs to him.

## License

AGPL-3.0-or-later (see LICENSE). Your vault, your key, your repo: nothing here phones home except the AI provider you point it at.
