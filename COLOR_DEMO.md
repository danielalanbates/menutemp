# 🌡️ MenuTemp Color Demonstration

This document demonstrates how MenuTemp's color-coded temperature display changes based on CPU temperature.

## Color Zones

MenuTemp uses four distinct color zones to help you quickly assess your Mac's temperature at a glance:

### 🔵 Blue - Cool (< 75°F / < 24°C)
**Status**: All good! Your Mac is running cool.

**Example Temperatures:**
- 65°F / 18°C - Idle, well-ventilated
- 70°F / 21°C - Light usage
- 74°F / 23°C - Normal browsing

**Menu Bar Display:**
```
🌡️ 70.5°F    (in blue text)
```

**What it means**: Your Mac is comfortably cool. No thermal concerns.

---

### 🟡 Yellow - Mild (75-84°F / 24-29°C)
**Status**: Normal operation under moderate load.

**Example Temperatures:**
- 75°F / 24°C - Multiple apps running
- 80°F / 27°C - Video playback
- 84°F / 29°C - Light compilation

**Menu Bar Display:**
```
🌡️ 80.2°F    (in yellow text)
```

**What it means**: Temperature is elevated but within normal operating range. Your Mac is working but not stressed.

---

### 🟠 Orange - Warm (85-94°F / 29-34°C)
**Status**: Getting toasty! Heavy workload detected.

**Example Temperatures:**
- 85°F / 29°C - Heavy multitasking
- 90°F / 32°C - Video rendering
- 94°F / 34°C - Gaming or intensive tasks

**Menu Bar Display:**
```
🌡️ 90.8°F    (in orange text)
```

**What it means**: Your Mac is working hard. Consider:
- Closing unnecessary apps
- Improving ventilation
- Taking a break from intensive tasks

---

### 🔴 Red - Hot (≥ 95°F / ≥ 35°C)
**Status**: Hot! Time to cool down.

**Example Temperatures:**
- 95°F / 35°C - Sustained heavy load
- 100°F / 38°C - Rendering or compiling
- 105°F / 41°C - Maximum sustained load

**Menu Bar Display:**
```
🌡️ 98.6°F    (in red text)
```

**What it means**: Your Mac is running hot. You should:
- Close resource-intensive apps
- Check for runaway processes
- Ensure proper ventilation
- Consider using a cooling pad
- Let your Mac cool down

---

## Visual Examples

### Temperature Progression

Here's how the display changes as temperature increases:

```
Cold Boot → Light Usage → Moderate Load → Heavy Load → Intensive Task
    ⬇️           ⬇️              ⬇️              ⬇️             ⬇️
   🔵 68°F     🔵 74°F        🟡 80°F        🟠 90°F       🔴 100°F
   Cool        Cool           Mild           Warm          Hot
```

### Details Dialog at Different Temps

**At 70°F (Cool - Blue):**
```
🌡️ Temperature Details
━━━━━━━━━━━━━━━━━━━━━━━━━━
Current temperature: 70.0°F

Color Coding:
• Blue: Cool (<75°F)       ← YOU ARE HERE
• Yellow: Mild (75-84°F)
• Orange: Warm (85-94°F)
• Red: Hot (≥95°F)
```

**At 82°F (Mild - Yellow):**
```
🌡️ Temperature Details
━━━━━━━━━━━━━━━━━━━━━━━━━━
Current temperature: 82.0°F

Color Coding:
• Blue: Cool (<75°F)
• Yellow: Mild (75-84°F)   ← YOU ARE HERE
• Orange: Warm (85-94°F)
• Red: Hot (≥95°F)
```

**At 92°F (Warm - Orange):**
```
🌡️ Temperature Details
━━━━━━━━━━━━━━━━━━━━━━━━━━
Current temperature: 92.0°F

Color Coding:
• Blue: Cool (<75°F)
• Yellow: Mild (75-84°F)
• Orange: Warm (85-94°F)   ← YOU ARE HERE
• Red: Hot (≥95°F)
```

**At 100°F (Hot - Red):**
```
🌡️ Temperature Details
━━━━━━━━━━━━━━━━━━━━━━━━━━
Current temperature: 100.0°F

Color Coding:
• Blue: Cool (<75°F)
• Yellow: Mild (75-84°F)
• Orange: Warm (85-94°F)
• Red: Hot (≥95°F)         ← YOU ARE HERE
```

---

## Temperature Unit Toggle

The color thresholds remain consistent regardless of which unit you're using:

### Fahrenheit Display:
```
🔵 < 75°F
🟡 75-84°F
🟠 85-94°F
🔴 ≥ 95°F
```

### Celsius Display:
```
🔵 < 24°C
🟡 24-29°C
🟠 29-34°C
🔴 ≥ 35°C
```

**Note**: The actual temperature thresholds are the same; only the units change.

---

## Real-World Scenarios

### Scenario 1: Web Browsing
**Temperature**: ~72°F (22°C)
**Color**: 🔵 Blue
**Action**: None needed - enjoy!

### Scenario 2: Video Editing
**Temperature**: ~88°F (31°C)
**Color**: 🟠 Orange
**Action**: Normal for this task, monitor if it stays high

### Scenario 3: Gaming Session
**Temperature**: ~95°F (35°C)
**Color**: 🔴 Red
**Action**: Consider breaks, ensure good airflow

### Scenario 4: Export/Rendering
**Temperature**: ~102°F (39°C)
**Color**: 🔴 Red
**Action**: This is expected for heavy tasks, but monitor closely

---

## Testing the Colors

Want to see how the colors look? Here's what to try:

### Low Temperature (Blue):
1. Let your Mac idle for 10-15 minutes
2. Close all resource-intensive apps
3. MenuTemp should show blue

### Medium Temperature (Yellow):
1. Open several apps (Safari, Mail, Messages)
2. Play a YouTube video
3. MenuTemp should transition to yellow

### High Temperature (Orange/Red):
1. Run a CPU-intensive task (video export, compilation, etc.)
2. Watch MenuTemp change to orange, then possibly red
3. **Warning**: Don't stress your Mac unnecessarily!

---

## Color Psychology

MenuTemp's color scheme was chosen carefully:

- 🔵 **Blue** = Calm, cool, safe
- 🟡 **Yellow** = Caution, attention, awareness
- 🟠 **Orange** = Warning, action needed
- 🔴 **Red** = Alert, urgent, hot

This intuitive system lets you monitor your Mac's thermal state at a glance without reading the exact temperature.

---

## Troubleshooting Colors

### Colors Don't Change
- Verify the temperature values are actually changing
- Check Details to see the actual temperature
- Restart MenuTemp

### Wrong Color for Temperature
- The app uses the same thresholds for all Macs
- Some activities may not generate as much heat on newer Macs
- Apple Silicon Macs generally run cooler than Intel

### Always Shows Same Color
- This is normal if your workload is consistent
- Try varying your activity to see different colors
- Ensure temperature sensors are working (check Details)

---

**Remember**: These colors are guidelines. Every Mac is different, and thermal management varies by model, age, and workload.

🌡️ **Stay cool!**
