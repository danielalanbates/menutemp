#!/usr/bin/env python3
"""
Temperature Demo Script for MenuTemp
Simulates different temperatures to demonstrate color changes
"""

import sys
import time

# Demo temperatures in Celsius with their expected colors
DEMO_TEMPS = [
    (20.0, "Blue - Cool"),      # ~68°F - Blue
    (24.0, "Blue - Cool"),      # ~75°F - Blue (edge)
    (27.0, "Yellow - Mild"),    # ~81°F - Yellow
    (30.0, "Orange - Warm"),    # ~86°F - Orange
    (32.0, "Orange - Warm"),    # ~90°F - Orange
    (35.0, "Red - Hot"),        # ~95°F - Red
    (40.0, "Red - Hot"),        # ~104°F - Red (very hot)
]

def main():
    """Print demo temperatures"""
    if len(sys.argv) > 1 and sys.argv[1] == "--cycle":
        # Cycle through temperatures
        for temp_c, description in DEMO_TEMPS:
            temp_f = temp_c * 9.0/5.0 + 32.0
            print(f"{temp_c:.1f}°C", flush=True)
            print(f"# {description}: {temp_f:.1f}°F / {temp_c:.1f}°C", file=sys.stderr)
            time.sleep(3)
    else:
        # Just print the first temperature
        temp_c = DEMO_TEMPS[0][0]
        print(f"{temp_c:.1f}°C")

if __name__ == "__main__":
    main()
