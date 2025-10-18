# 🎨 MenuTemp Visual Guide

## Quick Visual Reference

This guide shows exactly what MenuTemp looks like at different temperatures.

---

## Color Examples in Menu Bar

### 🔵 Cool Temperature (65-74°F)

**What you see in your menu bar:**
```
┌─────────────────────────┐
│  🌡️  70.5°F             │  ← Blue text
└─────────────────────────┘
```

**When you click it:**
```
┌─────────────────────────┐
│ Temp: 70.5°F            │  ← Gray (non-interactive)
├─────────────────────────┤
│ Details             ⌘D  │
├─────────────────────────┤
│ Celsius             ⌘U  │
├─────────────────────────┤
│ Quit                ⌘Q  │
└─────────────────────────┘
```

**Details dialog:**
```
╔══════════════════════════════════════╗
║ 🌡️ Temperature Details               ║
╠══════════════════════════════════════╣
║                                      ║
║  Current temperature: 70.5°F         ║
║                                      ║
║  Color Coding:                       ║
║  • Blue: Cool (<75°F)     ← HERE    ║
║  • Yellow: Mild (75-84°F)            ║
║  • Orange: Warm (85-94°F)            ║
║  • Red: Hot (≥95°F)                  ║
║                                      ║
╠══════════════════════════════════════╣
║              [ OK ]                  ║
╚══════════════════════════════════════╝
```

---

### 🟡 Mild Temperature (75-84°F)

**What you see in your menu bar:**
```
┌─────────────────────────┐
│  🌡️  80.2°F             │  ← Yellow text
└─────────────────────────┘
```

**Details dialog:**
```
╔══════════════════════════════════════╗
║ 🌡️ Temperature Details               ║
╠══════════════════════════════════════╣
║                                      ║
║  Current temperature: 80.2°F         ║
║                                      ║
║  Color Coding:                       ║
║  • Blue: Cool (<75°F)                ║
║  • Yellow: Mild (75-84°F)  ← HERE   ║
║  • Orange: Warm (85-94°F)            ║
║  • Red: Hot (≥95°F)                  ║
║                                      ║
╠══════════════════════════════════════╣
║              [ OK ]                  ║
╚══════════════════════════════════════╝
```

---

### 🟠 Warm Temperature (85-94°F)

**What you see in your menu bar:**
```
┌─────────────────────────┐
│  🌡️  90.8°F             │  ← Orange text
└─────────────────────────┘
```

**Details dialog:**
```
╔══════════════════════════════════════╗
║ 🌡️ Temperature Details               ║
╠══════════════════════════════════════╣
║                                      ║
║  Current temperature: 90.8°F         ║
║                                      ║
║  Color Coding:                       ║
║  • Blue: Cool (<75°F)                ║
║  • Yellow: Mild (75-84°F)            ║
║  • Orange: Warm (85-94°F)  ← HERE   ║
║  • Red: Hot (≥95°F)                  ║
║                                      ║
╠══════════════════════════════════════╣
║              [ OK ]                  ║
╚══════════════════════════════════════╝
```

---

### 🔴 Hot Temperature (95°F+)

**What you see in your menu bar:**
```
┌─────────────────────────┐
│  🌡️  98.6°F             │  ← Red text
└─────────────────────────┘
```

**Details dialog:**
```
╔══════════════════════════════════════╗
║ 🌡️ Temperature Details               ║
╠══════════════════════════════════════╣
║                                      ║
║  Current temperature: 98.6°F         ║
║                                      ║
║  Color Coding:                       ║
║  • Blue: Cool (<75°F)                ║
║  • Yellow: Mild (75-84°F)            ║
║  • Orange: Warm (85-94°F)            ║
║  • Red: Hot (≥95°F)        ← HERE   ║
║                                      ║
╠══════════════════════════════════════╣
║              [ OK ]                  ║
╚══════════════════════════════════════╝
```

---

## Celsius Display

### When you toggle to Celsius (⌘U):

**Cool (20°C):**
```
┌─────────────────────────┐
│  🌡️  20.0°C             │  ← Blue text
└─────────────────────────┘
```

**Mild (27°C):**
```
┌─────────────────────────┐
│  🌡️  27.0°C             │  ← Yellow text
└─────────────────────────┘
```

**Warm (32°C):**
```
┌─────────────────────────┐
│  🌡️  32.0°C             │  ← Orange text
└─────────────────────────┘
```

**Hot (38°C):**
```
┌─────────────────────────┐
│  🌡️  38.0°C             │  ← Red text
└─────────────────────────┘
```

**Details in Celsius mode:**
```
╔══════════════════════════════════════╗
║ 🌡️ Temperature Details               ║
╠══════════════════════════════════════╣
║                                      ║
║  Current temperature: 32.0°C         ║
║                                      ║
║  Color Coding:                       ║
║  • Blue: Cool (<24°C)                ║
║  • Yellow: Mild (24-29°C)            ║
║  • Orange: Warm (29-34°C)  ← HERE   ║
║  • Red: Hot (≥35°C)                  ║
║                                      ║
╠══════════════════════════════════════╣
║              [ OK ]                  ║
╚══════════════════════════════════════╝
```

---

## Power Display Mode

**When temperature sensors aren't available:**

```
┌─────────────────────────┐
│  🌡️  6.3 W              │  ← Blue text (power mode)
└─────────────────────────┘
```

**Details in power mode:**
```
╔══════════════════════════════════════╗
║ 🌡️ Temperature Details               ║
╠══════════════════════════════════════╣
║                                      ║
║  Current reading: 6.3 W              ║
║  (CPU power consumption)             ║
║                                      ║
║  CPU Power: 6.3 W                    ║
║                                      ║
║  Color Coding:                       ║
║  • Blue: Cool (<75°F)                ║
║  • Yellow: Mild (75-84°F)            ║
║  • Orange: Warm (85-94°F)            ║
║  • Red: Hot (≥95°F)                  ║
║                                      ║
╠══════════════════════════════════════╣
║              [ OK ]                  ║
╚══════════════════════════════════════╝
```

---

## Menu Structure

**The complete menu breakdown:**

```
Menu Bar Icon: 🌡️  XX.X°F  (colored text)
           │
           ├─ Click icon opens dropdown:
           │
           ├─ Temp: XX.X°F          (gray, non-interactive)
           ├─ ─────────────────     (separator)
           ├─ Details         ⌘D   (opens dialog)
           ├─ ─────────────────     (separator)
           ├─ Celsius         ⌘U   (toggle, changes to "Fahrenheit")
           ├─ ─────────────────     (separator)
           └─ Quit            ⌘Q   (exits app)
```

---

## Animation Flow

**Temperature increasing:**

```
Idle → Light work → Heavy work → Max load
 ⬇️        ⬇️            ⬇️           ⬇️
🔵 68°F → 🔵 74°F → 🟡 80°F → 🟠 88°F → 🔴 96°F
```

**Temperature decreasing:**

```
Max load → Cooldown → Normal → Idle
   ⬇️          ⬇️         ⬇️       ⬇️
🔴 96°F → 🟠 88°F → 🟡 78°F → 🔵 70°F
```

---

## Keyboard Shortcuts Visual

```
┌────────────────────────────────────┐
│  Keyboard Shortcuts                │
├────────────────────────────────────┤
│  ⌘ D  →  Open Details Dialog       │
│  ⌘ U  →  Toggle °F ↔ °C           │
│  ⌘ Q  →  Quit MenuTemp             │
└────────────────────────────────────┘
```

---

## Icon States

The thermometer icon (🌡️) remains constant, but the **text color** changes:

| Temperature | Icon | Text Color | Example |
|-------------|------|------------|---------|
| < 75°F | 🌡️ | 🔵 Blue | `🌡️ 70.0°F` |
| 75-84°F | 🌡️ | 🟡 Yellow | `🌡️ 80.0°F` |
| 85-94°F | 🌡️ | 🟠 Orange | `🌡️ 90.0°F` |
| ≥ 95°F | 🌡️ | 🔴 Red | `🌡️ 98.0°F` |

---

## Testing the Colors Live

Want to see the colors change in real-time? Try this:

1. **Launch MenuTemp** - Should start at idle temperature (blue)
2. **Open Activity Monitor** - Mild load, may turn yellow
3. **Export a video** or **compile code** - Should turn orange/red
4. **Close everything** - Watch it cool back down to blue

**Or run the preview script:**
```bash
./color_preview.sh
```

---

## Color Accessibility

MenuTemp's color scheme is designed to be accessible:

- **High contrast** - Colors are distinct even in light/dark mode
- **Multiple indicators** - Icon + color + numeric value
- **Clear labels** - Details dialog explains each zone
- **Consistent** - Same colors mean the same thing every time

**For users with color blindness:**
- The numeric temperature is always visible
- The Details dialog provides text descriptions
- Four distinct colors reduce confusion

---

🎨 **Enjoy your color-coded temperature monitoring!**
