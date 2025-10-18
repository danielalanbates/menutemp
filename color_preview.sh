#!/bin/bash

# MenuTemp Color Preview Script
# Displays color-coded temperature examples in the terminal

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║        MenuTemp Color Demonstration Preview              ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# ANSI color codes
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
ORANGE='\033[0;33m'
RED='\033[0;31m'
RESET='\033[0m'
BOLD='\033[1m'

echo "How MenuTemp displays different temperatures:"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${BOLD}🔵 BLUE - Cool (< 75°F / < 24°C)${RESET}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "Menu Bar: ${BLUE}${BOLD}🌡️  65.0°F${RESET}"
echo -e "Menu Bar: ${BLUE}${BOLD}🌡️  70.5°F${RESET}"
echo -e "Menu Bar: ${BLUE}${BOLD}🌡️  74.0°F${RESET}"
echo "Status: All good! Your Mac is running cool."
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${BOLD}🟡 YELLOW - Mild (75-84°F / 24-29°C)${RESET}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "Menu Bar: ${YELLOW}${BOLD}🌡️  75.0°F${RESET}"
echo -e "Menu Bar: ${YELLOW}${BOLD}🌡️  80.2°F${RESET}"
echo -e "Menu Bar: ${YELLOW}${BOLD}🌡️  84.0°F${RESET}"
echo "Status: Normal operation under moderate load."
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${BOLD}🟠 ORANGE - Warm (85-94°F / 29-34°C)${RESET}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "Menu Bar: ${ORANGE}${BOLD}🌡️  85.0°F${RESET}"
echo -e "Menu Bar: ${ORANGE}${BOLD}🌡️  90.8°F${RESET}"
echo -e "Menu Bar: ${ORANGE}${BOLD}🌡️  94.0°F${RESET}"
echo "Status: Getting toasty! Heavy workload detected."
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${BOLD}🔴 RED - Hot (≥ 95°F / ≥ 35°C)${RESET}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "Menu Bar: ${RED}${BOLD}🌡️  95.0°F${RESET}"
echo -e "Menu Bar: ${RED}${BOLD}🌡️  98.6°F${RESET}"
echo -e "Menu Bar: ${RED}${BOLD}🌡️ 105.0°F${RESET}"
echo "Status: Hot! Time to cool down."
echo ""

echo "═══════════════════════════════════════════════════════════"
echo ""
echo "💡 Toggle between Fahrenheit and Celsius with ⌘U"
echo "📊 View details with ⌘D"
echo ""
echo "Note: Actual colors in MenuTemp will match your macOS theme"
echo "      and appear in the menu bar status area."
echo ""
