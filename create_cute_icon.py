#!/usr/bin/env python3
"""Create a cute thermometer icon for the Menu Temp app"""
import os
import subprocess
from PIL import Image, ImageDraw, ImageFont

def create_cute_thermometer_icon():
    """Create a cute thermometer icon with gradient colors"""

    # Create iconset directory
    iconset_dir = "/Users/daniel/Documents/GitHub/copilot/Menu_temp/AppIcon.iconset"
    os.makedirs(iconset_dir, exist_ok=True)

    # Define sizes needed for macOS app icons
    sizes = [
        (16, "icon_16x16.png"),
        (32, "icon_16x16@2x.png"),
        (32, "icon_32x32.png"),
        (64, "icon_32x32@2x.png"),
        (128, "icon_128x128.png"),
        (256, "icon_128x128@2x.png"),
        (256, "icon_256x256.png"),
        (512, "icon_256x256@2x.png"),
        (512, "icon_512x512.png"),
        (1024, "icon_512x512@2x.png")
    ]

    for size, filename in sizes:
        # Create image with transparent background
        img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
        draw = ImageDraw.Draw(img)

        # Calculate dimensions
        margin = size * 0.1
        bulb_radius = size * 0.2
        tube_width = size * 0.15
        tube_height = size * 0.5

        # Center positions
        center_x = size / 2
        bulb_center_y = size - margin - bulb_radius
        tube_top = bulb_center_y - bulb_radius - tube_height

        # Draw thermometer tube (light gray rounded rectangle)
        tube_left = center_x - tube_width / 2
        tube_right = center_x + tube_width / 2
        tube_color = (230, 230, 250, 255)  # Light lavender
        draw.rounded_rectangle(
            [tube_left, tube_top, tube_right, bulb_center_y - bulb_radius],
            radius=tube_width / 2,
            fill=tube_color,
            outline=(180, 180, 200, 255),
            width=max(1, int(size * 0.02))
        )

        # Draw mercury/temperature indicator (gradient from orange to red)
        mercury_height = tube_height * 0.6
        mercury_top = bulb_center_y - bulb_radius - mercury_height

        # Create gradient effect
        for i in range(int(mercury_height)):
            ratio = i / mercury_height
            # Gradient from red (bottom) to orange (top)
            r = int(255 - (40 * ratio))  # 255 -> 215
            g = int(69 + (96 * ratio))   # 69 -> 165
            b = int(0 + (0 * ratio))      # 0 -> 0
            color = (r, g, b, 255)

            y_pos = mercury_top + i
            draw.line(
                [(tube_left + 2, y_pos), (tube_right - 2, y_pos)],
                fill=color,
                width=1
            )

        # Draw bulb at bottom (red/orange gradient)
        bulb_color = (255, 69, 0, 255)  # Red-orange
        draw.ellipse(
            [center_x - bulb_radius, bulb_center_y - bulb_radius,
             center_x + bulb_radius, bulb_center_y + bulb_radius],
            fill=bulb_color,
            outline=(200, 50, 0, 255),
            width=max(1, int(size * 0.02))
        )

        # Add shine effect to bulb
        shine_radius = bulb_radius * 0.3
        shine_offset = bulb_radius * 0.3
        draw.ellipse(
            [center_x - shine_offset - shine_radius, bulb_center_y - shine_offset - shine_radius,
             center_x - shine_offset + shine_radius, bulb_center_y - shine_offset + shine_radius],
            fill=(255, 150, 100, 150)  # Semi-transparent white-orange
        )

        # Draw temperature marks on the tube (if size is large enough)
        if size >= 128:
            mark_count = 3
            mark_spacing = tube_height / (mark_count + 1)
            for i in range(1, mark_count + 1):
                y_pos = tube_top + (i * mark_spacing)
                # Left mark
                draw.line(
                    [(tube_left - size * 0.03, y_pos), (tube_left, y_pos)],
                    fill=(100, 100, 120, 255),
                    width=max(1, int(size * 0.015))
                )
                # Right mark
                draw.line(
                    [(tube_right, y_pos), (tube_right + size * 0.03, y_pos)],
                    fill=(100, 100, 120, 255),
                    width=max(1, int(size * 0.015))
                )

        # Add a cute face on larger icons
        if size >= 256:
            face_y = tube_top + tube_height * 0.3
            eye_radius = size * 0.02

            # Left eye
            draw.ellipse(
                [center_x - size * 0.06 - eye_radius, face_y - eye_radius,
                 center_x - size * 0.06 + eye_radius, face_y + eye_radius],
                fill=(80, 80, 100, 255)
            )

            # Right eye
            draw.ellipse(
                [center_x + size * 0.06 - eye_radius, face_y - eye_radius,
                 center_x + size * 0.06 + eye_radius, face_y + eye_radius],
                fill=(80, 80, 100, 255)
            )

            # Smile
            smile_y = face_y + size * 0.05
            draw.arc(
                [center_x - size * 0.05, smile_y - size * 0.02,
                 center_x + size * 0.05, smile_y + size * 0.03],
                start=0, end=180,
                fill=(80, 80, 100, 255),
                width=max(2, int(size * 0.015))
            )

        # Save the image
        output_path = os.path.join(iconset_dir, filename)
        img.save(output_path, 'PNG')
        print(f"✓ Created {filename} ({size}x{size})")

    # Convert iconset to icns using iconutil
    icns_path = os.path.join(os.path.dirname(iconset_dir), "app_icon.icns")
    try:
        subprocess.run([
            "iconutil", "-c", "icns",
            iconset_dir,
            "-o", icns_path
        ], check=True, capture_output=True)
        print(f"\n✓ Created app_icon.icns at {icns_path}")

        # Keep the iconset directory for now (don't clean up)
        # subprocess.run(["rm", "-rf", iconset_dir])
        print(f"✓ Iconset directory preserved at {iconset_dir}")

        return icns_path

    except subprocess.CalledProcessError as e:
        print(f"✗ Failed to create icns: {e}")
        return None

if __name__ == "__main__":
    print("Creating cute thermometer icon...")
    result = create_cute_thermometer_icon()
    if result:
        print(f"\n🎉 Success! Icon created at: {result}")
    else:
        print("\n❌ Failed to create icon")
