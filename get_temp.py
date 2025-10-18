#!/usr/bin/env python3
import subprocess
import sys
import re

def get_powermetrics_temp():
    """Get temperature from powermetrics with sudo"""
    try:
        # Run powermetrics with sudo
        result = subprocess.run([
            'sudo', '/usr/bin/powermetrics', 
            '--samplers', 'cpu_power', 
            '-n', '1'
        ], capture_output=True, text=True, timeout=10)
        
        if result.returncode == 0:
            output = result.stdout
            
            # Look for temperature patterns
            temp_patterns = [
                r'CPU die temperature:\s*(\d+\.?\d*)\s*°?C',
                r'Package temperature:\s*(\d+\.?\d*)\s*°?C',
                r'CPU package temperature:\s*(\d+\.?\d*)\s*°?C',
                r'CPU Temperature:\s*(\d+\.?\d*)\s*°?C',
                r'(\d+\.?\d*)\s*°C'
            ]
            
            for pattern in temp_patterns:
                match = re.search(pattern, output, re.IGNORECASE)
                if match:
                    temp_c = float(match.group(1))
                    if temp_c > 0:  # Valid temperature
                        return temp_c
            
            # If no temperature found, try to get power
            power_match = re.search(r'CPU Power:\s*(\d+\.?\d*)\s*mW', output, re.IGNORECASE)
            if power_match:
                power_mw = float(power_match.group(1))
                if power_mw >= 1000:
                    return f"POWER:{power_mw/1000:.1f}W"
                else:
                    return f"POWER:{int(power_mw)}mW"
                    
    except subprocess.TimeoutExpired:
        pass
    except Exception:
        pass
    
    return None

def main():
    temp = get_powermetrics_temp()
    if temp is not None:
        if isinstance(temp, str) and temp.startswith("POWER:"):
            print(temp.replace("POWER:", ""))
        else:
            print(f"{temp:.1f}°C")
    else:
        print("0.0°C")

if __name__ == "__main__":
    main()