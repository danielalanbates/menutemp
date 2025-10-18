#!/usr/bin/env python3
import subprocess
import sys
import re
import json

def get_iokit_temperature():
    """Try to get temperature from IOKit using ioreg"""
    try:
        # Look for thermal sensors in IOKit
        result = subprocess.run([
            'ioreg', '-rc', 'AppleSmartBattery'
        ], capture_output=True, text=True, timeout=5)
        
        if result.returncode == 0:
            # Look for temperature-related properties
            if 'Temperature' in result.stdout:
                # Parse temperature values
                temp_match = re.search(r'"Temperature"\s*=\s*(\d+)', result.stdout)
                if temp_match:
                    temp_raw = int(temp_match.group(1))
                    # Convert from centi-Celsius to Celsius
                    temp_c = temp_raw / 100.0
                    if 0 < temp_c < 150:  # Reasonable temperature range
                        return temp_c
    except:
        pass
    
    return None

def get_system_temperature():
    """Try to get system temperature using various methods"""
    try:
        # Try system_profiler for thermal information
        result = subprocess.run([
            'system_profiler', 'SPHardwareDataType'
        ], capture_output=True, text=True, timeout=5)
        
        if result.returncode == 0:
            # Look for thermal throttling info
            if 'Thermal State' in result.stdout:
                print("Found thermal state info")
    except:
        pass
    
    return None

def get_powermetrics_temp():
    """Get temperature from powermetrics with sudo"""
    try:
        # Try different powermetrics samplers that might include temperature
        samplers = ['smc', 'thermal_pressure', 'cpu_power']
        
        for sampler in samplers:
            try:
                result = subprocess.run([
                    'sudo', '/usr/bin/powermetrics', 
                    '--samplers', sampler,
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
                        r'Thermal pressure:\s*(\d+\.?\d*)',
                        r'(\d+\.?\d*)\s*°C'
                    ]
                    
                    for pattern in temp_patterns:
                        match = re.search(pattern, output, re.IGNORECASE)
                        if match:
                            temp_c = float(match.group(1))
                            if temp_c > 0 and temp_c < 150:  # Valid temperature range
                                return temp_c
            except:
                continue
        
        # Fallback to CPU power if no temperature found
        result = subprocess.run([
            'sudo', '/usr/bin/powermetrics', 
            '--samplers', 'cpu_power', 
            '-n', '1'
        ], capture_output=True, text=True, timeout=10)
        
        if result.returncode == 0:
            output = result.stdout
            power_match = re.search(r'CPU Power:\s*(\d+\.?\d*)\s*mW', output, re.IGNORECASE)
            if power_match:
                power_mw = float(power_match.group(1))
                if power_mw >= 1000:
                    return f"POWER:{power_mw/1000:.1f}W"
                else:
                    return f"POWER:{int(power_mw)}mW"
                    
    except Exception as e:
        pass
    
    return None

def main():
    # Try different methods to get temperature
    
    # Method 1: IOKit temperature
    temp = get_iokit_temperature()
    if temp is not None:
        print(f"{temp:.1f}°C")
        return
    
    # Method 2: System temperature
    temp = get_system_temperature()
    if temp is not None:
        print(f"{temp:.1f}°C")
        return
    
    # Method 3: Powermetrics temperature
    temp = get_powermetrics_temp()
    if temp is not None:
        if isinstance(temp, str) and temp.startswith("POWER:"):
            print(temp.replace("POWER:", ""))
        else:
            print(f"{temp:.1f}°C")
        return
    
    # Fallback
    print("0.0°C")

if __name__ == "__main__":
    main()