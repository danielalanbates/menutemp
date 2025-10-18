#!/usr/bin/env python3
from PIL import Image, ImageDraw, ImageFont
import os

def create_thermostat_icon(color, filename):
    # Create a 16x16 image
    img = Image.new('RGBA', (16, 16), (0, 0, 0, 0))  # Transparent background
    draw = ImageDraw.Draw(img)
    
    # Draw a thermostat: circle with temperature scale and numbers
    draw.ellipse([2, 2, 14, 14], fill=color, outline='white', width=1)
    
    # Add temperature numbers (very small)
    font = ImageFont.load_default()
    # Draw numbers at positions
    draw.text((8, 1), "7", fill='white', font=font, anchor='mm')  # Top
    draw.text((14, 8), "8", fill='white', font=font, anchor='lm')  # Right
    draw.text((8, 14), "6", fill='white', font=font, anchor='mm')  # Bottom
    draw.text((1, 8), "5", fill='white', font=font, anchor='rm')  # Left
    
    # Add a pointer (needle)
    draw.line([8, 8, 8, 4], fill='white', width=1)
    
    img.save(filename)

# Create icons
os.makedirs('Resources', exist_ok=True)

create_thermostat_icon((255, 0, 0, 255), 'Resources/hot.png')  # Red
create_thermostat_icon((255, 165, 0, 255), 'Resources/warm.png')  # Orange
create_thermostat_icon((255, 255, 0, 255), 'Resources/mild.png')  # Yellow
create_thermostat_icon((0, 0, 255, 255), 'Resources/cool.png')  # Blue
create_thermostat_icon((0, 0, 255, 255), 'Resources/power.png')  # Blue for power

create_thermostat_icon((0, 0, 0, 255), 'Resources/thermostat.png')  # Black thermostat