# KDE/KWin Configuration

Custom keyboard shortcuts for efficient window management. Plasma 6, Wayland.

## Not stowed — copied

**Do not `stow kde`.** KConfig saves by writing a temp file and renaming it over
the target, which destroys a symlink and leaves a real file behind. A stowed KDE
config silently stops tracking the first time you touch System Settings.

That is exactly what happened here: the symlinks broke sometime before
2026-07, and the repo drifted ~148 lines out of date without any visible sign.
These files are now **copied**, via `sync.sh`:

```bash
./sync.sh pull    # live -> repo   (after changing things in System Settings)
./sync.sh push    # repo -> live   (fresh machine; log out of Plasma first)
./sync.sh diff    # show what differs
```

`pull` is the one you'll use. Run it after tweaking shortcuts, then commit.

## Shortcuts

**Window Overview:**
- `Win+Tab` - See all windows (all desktops)
- `Win+W` - Overview (current desktop)
- `Win+A` - Desktop Grid (all desktops)

**Virtual Desktops:**
- `Ctrl+1-4` - Switch to desktop 1-4
- `Ctrl+Shift+1-4` - Move window to desktop 1-4

**Window Management:**
- `Win+Arrow Keys` - Quick tile windows (left/right/up/down)
- `Win+Q` - Close window
- `Win+F` - Fullscreen

**Disabled:**
- `Alt+Tab` - **DISABLED** (forces better window management habits)
- **Activities** (`Win+Q` / `Win+A` by default) - unbound, so those keys are
  free for Close Window and Desktop Grid. Plasma assigns Activities these by
  default and will silently win the conflict otherwise.

## Notes

- Designed for Plasma 6
- `Win+1-9` kept for taskbar icons (Plasma default)
- Alt+Tab disabled to encourage using overview instead
- A Plasma upgrade reverted `Win+Q`, `Win+A`, and `Win+Tab` to defaults at some
  point; restored 2026-07-18. If they vanish again, suspect an upgrade reset
  plus the Activities conflict above.
- `kglobalshortcutsrc` also carries ~20 **Polonium** tiling bindings
  (`Meta+H/J/K/L` etc). That tiling setup was never got working, so the bindings
  are inert. Safe to strip if you give up on it.

## Editing shortcuts

Change them in System Settings, then `./sync.sh pull`. Editing the file by hand
while Plasma runs does not work — kwin holds the shortcuts in memory and
rewrites the file on logout. To script a change, go through kglobalaccel:

```bash
busctl --user call org.kde.kglobalaccel /kglobalaccel org.kde.KGlobalAccel \
  setForeignShortcut asai 4 "kwin" "Window Close" "KWin" "Close Window" 1 268435537
```

The trailing ints are Qt keycodes (`Meta` = 268435456, plus the key: `Q` = 81).
Passing `0` keys unbinds. Plasma persists the change to disk itself.
