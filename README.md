````markdown
(THIS WAS GENERATED VIA CHATGPT)
# Arch Linux Window Manager Templates

This repository contains two simple Arch Linux window manager templates, each with an `install.sh` script to quickly set up a working graphical environment.

The goal is to provide:
- A **lightweight, minimal setup** (i3)
- A **more modern, feature-rich setup** (Hyprland)

Both are keyboard-focused and suitable for daily use, including running browsers, terminals, and development tools.

---

## 📁 Repository Structure
.
├── i3 (lightweight)/
│   └── install.sh
└── hyprland (heavier)/
    └── install.sh
````

---

## ✎ i3 (Lightweight)

A **minimal, X11-based tiling window manager** setup focused on speed, simplicity, and low resource usage.

### Included Software

* **i3-wm** – Keyboard-driven tiling window manager
* **i3status** – Status bar information
* **dmenu** – Application launcher
* **alacritty** – GPU-accelerated terminal emulator

### Install

```bash
cd "i3 (lightweight)"
chmod +x install.sh
./install.sh
```

### Start i3

```bash
startx
```

> Ideal for older hardware, VMs, or users who want maximum control with minimal overhead.

---

## 🖥️ Hyprland (Heavier)

A **modern Wayland-based tiling compositor** with animations, rounded corners, and advanced features.

### Included Software

* **hyprland** – Wayland compositor
* **xdg-desktop-portal-hyprland** – Screen sharing & portals
* **waybar** – Status bar
* **hyprpaper** – Wallpaper utility
* **kitty** – Terminal emulator
* **dolphin** – File manager
* **wl-clipboard** – Clipboard utilities
* **Fonts**

  * JetBrains Mono Nerd Font
  * Noto Fonts + Emoji
* **Audio**

  * PipeWire
  * WirePlumber
* **polkit-kde-agent** – Authentication agent
* **grim + slurp** – Screenshots

### Install

```bash
cd "hyprland (heavier)"
chmod +x install.sh
./install.sh
```

### Start Hyprland

```bash
Hyprland
```

> Best for users who want a modern desktop experience with tiling, animations, and Wayland support.

---

## ⚠️ Notes

* These scripts are intended for **Arch Linux**.
* Both scripts perform a full system update using:

  ```bash
  sudo pacman -Syu
  ```
* You may need to configure:

  * Display manager (optional)
  * GPU drivers
  * Input devices
  * Dotfiles / configs

---

## 🧠 Which One Should I Choose?

| Feature           | i3       | Hyprland         |
| ----------------- | -------- | ---------------- |
| Display Protocol  | X11      | Wayland          |
| Resource Usage    | Very Low | Moderate         |
| Animations        | ❌        | ✅                |
| Keyboard Driven   | ✅        | ✅                |
| Beginner Friendly | ✅        | ⚠️ (more config) |

---

## 📜 License

Do whatever you want with it.

Happy tiling 🚀

```

---

If you want, I can:
- Add **screenshots section placeholders**
- Write **per-WM config explanations**
- Add a **one-liner install command**
- Adjust tone (more minimal / more flashy)

Just tell me.
```
