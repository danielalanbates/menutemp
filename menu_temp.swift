import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    var tempMenuItem: NSMenuItem!
    var unitToggleMenuItem: NSMenuItem!
    var timer: Timer?
    var useFahrenheit: Bool = true  // Default to Fahrenheit

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory) // hide Dock icon

        // Load user preference for temperature unit
        useFahrenheit = UserDefaults.standard.object(forKey: "useFahrenheit") as? Bool ?? true

        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem.button {
            // Use SF Symbol thermostat icon
            if #available(macOS 11.0, *) {
                let config = NSImage.SymbolConfiguration(pointSize: 14, weight: .regular)
                if let img = NSImage(systemSymbolName: "thermometer.medium", accessibilityDescription: "Thermostat")?.withSymbolConfiguration(config) {
                    img.isTemplate = true  // Make it black
                    img.size = NSSize(width: 16, height: 16)
                    button.image = img
                }
            } else {
                button.title = "🌡️" // fallback emoji
            }
            // show image and a short title next to it
            button.imagePosition = .imageLeft
            // Set initial title with default color
            let initialTitle = NSAttributedString(string: "--", attributes: [.foregroundColor: NSColor.labelColor])
            button.attributedTitle = initialTitle
        }

        let menu = NSMenu()
        tempMenuItem = NSMenuItem(title: "Temp: --", action: nil, keyEquivalent: "")
        tempMenuItem.isEnabled = false
        menu.addItem(tempMenuItem)
        menu.addItem(NSMenuItem.separator())

        let details = NSMenuItem(title: "Details", action: #selector(detailsAction), keyEquivalent: "d")
        details.target = self
        menu.addItem(details)

        menu.addItem(NSMenuItem.separator())

        unitToggleMenuItem = NSMenuItem(title: "Celsius", action: #selector(toggleTemperatureUnit), keyEquivalent: "u")
        unitToggleMenuItem.target = self
        updateUnitToggleTitle()
        menu.addItem(unitToggleMenuItem)

        menu.addItem(NSMenuItem.separator())

        let quit = NSMenuItem(title: "Quit", action: #selector(quitAction), keyEquivalent: "q")
        quit.target = self
        menu.addItem(quit)

        statusItem.menu = menu

        // initial update
        updateTemp()

        // periodic updates
        timer = Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
    }

    @objc func timerFired() {
        updateTemp()
    }

    func updateTemp() {
        let tempString = getCPUTemp()
        DispatchQueue.main.async {
            // show a short value next to the status icon
            if let btn = self.statusItem.button {
                // Update text color based on temperature
                let color = self.getColorForTemp(tempString)
                let attributedTitle = NSAttributedString(string: tempString, attributes: [.foregroundColor: color])
                btn.attributedTitle = attributedTitle
            }
            // also update the details menu item for the dropdown
            self.tempMenuItem.title = "Temp: \(tempString)"
        }
    }

    func getColorForTemp(_ tempString: String) -> NSColor {
        let tempValue = parseTempNumber(tempString) ?? 0

        if tempString.contains("mW") || tempString.contains("W") {
            return NSColor.systemBlue
        }

        // Convert to Fahrenheit for color thresholds if currently in Celsius
        var tempInF = tempValue
        if tempString.contains("°C") {
            tempInF = tempValue * 9.0/5.0 + 32.0
        }

        if tempInF >= 95 {
            return NSColor.systemRed
        } else if tempInF >= 85 {
            return NSColor.systemOrange
        } else if tempInF >= 75 {
            return NSColor.systemYellow
        } else {
            return NSColor.systemBlue
        }
    }

    @objc func detailsAction() {
        let details = getDetails()
        let alert = NSAlert()
        alert.messageText = "🌡️ Temperature Details"
        alert.informativeText = details
        alert.addButton(withTitle: "OK")

        // Add a cute thermometer icon to the alert
        if #available(macOS 11.0, *) {
            alert.icon = NSImage(systemSymbolName: "thermometer.medium", accessibilityDescription: "Temperature")
        }

        alert.runModal()
    }

    @objc func toggleTemperatureUnit() {
        useFahrenheit = !useFahrenheit
        UserDefaults.standard.set(useFahrenheit, forKey: "useFahrenheit")
        updateUnitToggleTitle()
        updateTemp()  // Refresh the display with new units
    }

    func updateUnitToggleTitle() {
        if useFahrenheit {
            unitToggleMenuItem.title = "Celsius"
        } else {
            unitToggleMenuItem.title = "Fahrenheit"
        }
    }

    @objc func quitAction() {
        NSApp.terminate(nil)
    }

    // MARK: - Temperature helpers

    func getCPUTemp() -> String {
        // Get the raw reading from our temperature scripts
        if let raw = readOSXCPUTemp() {
            let s = raw.trimmingCharacters(in: .whitespacesAndNewlines)
            // Check if it's power data from our Python script
            if s.contains("mW") || s.contains("W") {
                return s  // Return power data directly
            }
            // Check if it's temperature data
            if s.contains("°C") || s.contains("°F") {
                // Parse the temperature and convert based on user preference
                if s.range(of: "[fF]", options: .regularExpression) != nil {
                    if let f = parseTempNumber(s) {
                        if useFahrenheit {
                            return String(format: "%.1f°F", f)
                        } else {
                            let c = (f - 32.0) * 5.0/9.0
                            return String(format: "%.1f°C", c)
                        }
                    }
                } else if s.range(of: "[cC]", options: .regularExpression) != nil || s.contains("°") {
                    if let c = parseTempNumber(s), c != 0.0 {
                        if useFahrenheit {
                            let f = c * 9.0/5.0 + 32.0
                            return String(format: "%.1f°F", f)
                        } else {
                            return String(format: "%.1f°C", c)
                        }
                    }
                }
            }
        }
        // If we couldn't get a valid temperature, try power fallback
        if let power = readPowermetricsPower() {
            return "\(power)"
        }
        return "No sensors"
    }

    // Try various sources and return temperature in Celsius, if found
    func fetchTemperatureC() -> Double? {
        // 1) user command / osx-cpu-temp
        if let raw = readOSXCPUTemp() {
            // try to detect unit in the string
            let s = raw.trimmingCharacters(in: .whitespacesAndNewlines)
            if s.range(of: "[fF]", options: .regularExpression) != nil {
                if let n = parseTempNumber(s) {
                    // ignore a 32.0°F reading which corresponds to 0°C (sensor-null)
                    if n == 32.0 { /* treat as invalid */ }
                    else { return (n - 32.0) * 5.0/9.0 }
                }
            }
            if s.range(of: "[cC]", options: .regularExpression) != nil || s.contains("°") {
                if let n = parseTempNumber(s) {
                    // treat an explicit 0.0°C as invalid (many CLIs print 0.0 when sensor is unavailable)
                    if n == 0.0 { /* ignore and continue */ }
                    else { return n }
                }
            }
            // fallback: if numeric and reasonable assume C when <= 120
            if let n = parseTempNumber(s), n <= 120 {
                // Treat a raw 0.0 reading as invalid (many tools report 0.0 when sensor is unavailable)
                if n == 0.0 {
                    // ignore this result and continue to other sources
                } else {
                    return n
                }
            }
        }

        // 2) powermetrics output
        if let full = readPowermetricsFull() {
            // prefer explicit Celsius lines
            if let m = full.range(of: "\\d+\\.?\\d*\\s*°?\\s*C", options: .regularExpression) {
                let s = String(full[m])
                if let n = parseTempNumber(s) {
                    if n == 0.0 { /* ignore */ } else { return n }
                }
            }
            // try lines containing 'temperature' labels
            let labels = ["CPU die temperature", "Package temperature", "CPU package temperature", "CPU Temperature", "CPU Temp"]
            for lab in labels {
                if let r = full.range(of: lab, options: [.caseInsensitive, .regularExpression]) {
                    let tail = String(full[r.lowerBound...])
                    if let n = parseTempNumber(tail) { return n }
                }
            }
            // try Fahrenheit lines
            if let m = full.range(of: "\\d+\\.?\\d*\\s*°?\\s*F", options: .regularExpression) {
                let s = String(full[m])
                if let n = parseTempNumber(s) {
                    if n == 32.0 { /* ignore */ } else { return (n - 32.0) * 5.0/9.0 }
                }
            }
        }

        return nil
    }

    func getDetails() -> String {
        var parts: [String] = []
        if let v = readOSXCPUTemp() {
            // Check if this is a power reading (contains mW or W)
            if v.contains("mW") || v.contains("W") {
                parts.append("Current reading: \(v) (CPU power consumption)")
            } else if let n = parseTempNumber(v), n == 0.0 {
                parts.append("Temperature sensor unavailable")
            } else {
                // Convert based on user preference
                var displayTemp = v
                if v.contains("°C") || v.contains("°c") {
                    if let celsius = parseTempNumber(v) {
                        if useFahrenheit {
                            let fahrenheit = celsius * 9.0/5.0 + 32.0
                            displayTemp = String(format: "%.1f°F", fahrenheit)
                        } else {
                            displayTemp = String(format: "%.1f°C", celsius)
                        }
                    }
                } else if v.contains("°F") || v.contains("°f") {
                    if let fahrenheit = parseTempNumber(v) {
                        if useFahrenheit {
                            displayTemp = String(format: "%.1f°F", fahrenheit)
                        } else {
                            let celsius = (fahrenheit - 32.0) * 5.0/9.0
                            displayTemp = String(format: "%.1f°C", celsius)
                        }
                    }
                }
                parts.append("Current temperature: \(displayTemp)")
            }
        }

        // Try to get powermetrics temperature and convert based on preference
        if let pmTemp = readPowermetricsTemp() {
            if let celsius = parseTempNumber(pmTemp) {
                if useFahrenheit {
                    let fahrenheit = celsius * 9.0/5.0 + 32.0
                    parts.append("Powermetrics: \(String(format: "%.1f°F", fahrenheit))")
                } else {
                    parts.append("Powermetrics: \(String(format: "%.1f°C", celsius))")
                }
            }
        }

        // Try to get power reading as well
        if let power = readPowermetricsPower() {
            parts.append("CPU Power: \(power)")
        }

        if parts.isEmpty {
            return "No temperature sensors available.\n\nThis Mac may not expose temperature data through standard interfaces."
        }

        let cool = useFahrenheit ? "<75°F" : "<24°C"
        let mild = useFahrenheit ? "75-84°F" : "24-29°C"
        let warm = useFahrenheit ? "85-94°F" : "29-34°C"
        let hot = useFahrenheit ? "≥95°F" : "≥35°C"

        let colorExplanation = """

Color Coding:
• Blue: Cool (\(cool))
• Yellow: Mild (\(mild))
• Orange: Warm (\(warm))
• Red: Hot (\(hot))
"""
        return parts.joined(separator: "\n\n") + colorExplanation
    }

    func readOSXCPUTemp() -> String? {
        // Get the app bundle path
        let bundle = Bundle.main
        let bundlePath = bundle.bundlePath
        let resourcesPath = bundle.resourcePath ?? bundlePath
        
        // First try our advanced Python script from app bundle
        let advancedScript = "\(resourcesPath)/get_temp_advanced.py"
        if FileManager.default.isExecutableFile(atPath: advancedScript) {
            if let out = runProcess("/usr/bin/python3", args: [advancedScript]) {
                let result = out.trimmingCharacters(in: .whitespacesAndNewlines)
                if !result.isEmpty && result != "0.0°C" {
                    return result
                }
            }
        }
        
        // Fallback to basic Python script from app bundle
        let basicScript = "\(resourcesPath)/get_temp.py"
        if FileManager.default.isExecutableFile(atPath: basicScript) {
            if let out = runProcess("/usr/bin/python3", args: [basicScript]) {
                let result = out.trimmingCharacters(in: .whitespacesAndNewlines)
                if !result.isEmpty && result != "0.0°C" {
                    return result
                }
            }
        }
        
        // Try absolute paths as fallback (for development)
        let devAdvancedScript = "/Users/daniel/Documents/GitHub/copilot/Menu_temp/get_temp_advanced.py"
        if FileManager.default.isExecutableFile(atPath: devAdvancedScript) {
            if let out = runProcess("/usr/bin/python3", args: [devAdvancedScript]) {
                let result = out.trimmingCharacters(in: .whitespacesAndNewlines)
                if !result.isEmpty && result != "0.0°C" {
                    return result
                }
            }
        }
        
        // Prefer a user-provided command stored in UserDefaults
        if let userCmd = UserDefaults.standard.string(forKey: "tempCommand"), !userCmd.isEmpty {
            if let out = runProcess(userCmd, args: []) {
                return out.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }

        // env override
        if let envCmd = ProcessInfo.processInfo.environment["CPU_TEMP_CMD"], !envCmd.isEmpty {
            if let out = runProcess(envCmd, args: []) {
                return out.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }

        let candidates = ["/opt/homebrew/bin/osx-cpu-temp", "/usr/local/bin/osx-cpu-temp"]
        // check PATH via which
        if let which = runProcess("/usr/bin/which", args: ["osx-cpu-temp"])?.trimmingCharacters(in: .whitespacesAndNewlines), !which.isEmpty {
            var list = [which]
            list.append(contentsOf: candidates)
            for c in list {
                if FileManager.default.isExecutableFile(atPath: c) {
                    if let out = runProcess(c, args: []) {
                        return out.trimmingCharacters(in: .whitespacesAndNewlines)
                    }
                }
            }
        } else {
            for c in candidates {
                if FileManager.default.isExecutableFile(atPath: c) {
                    if let out = runProcess(c, args: []) {
                        return out.trimmingCharacters(in: .whitespacesAndNewlines)
                    }
                }
            }
        }
        return nil
    }

    func readPowermetricsFull() -> String? {
        let pm = "/usr/bin/powermetrics"
        if !FileManager.default.isExecutableFile(atPath: pm) { return nil }
        // Prefer the cpu_power sampler which emits CPU Power lines; fall back to all samplers if needed
        if let out = runProcess(pm, args: ["--samplers", "cpu_power", "-n", "1"], timeout: 6) ?? runProcess(pm, args: ["-A", "-n", "1"], timeout: 6) {
            // return a short excerpt (first 400 chars)
            let excerpt = String(out.prefix(400))
            return excerpt
        }

        // If powermetrics failed when run without privileges, try using sudo with a password
        if let password = getKeychainPassword() {
            // Supply the password via stdin to sudo (-S). Do not log or store the password.
            // Use the cpu_power sampler under sudo so CPU Power lines are returned, matching the non-root sampling preference.
            if let out2 = runProcess("/usr/bin/sudo", args: ["-S", pm, "--samplers", "cpu_power", "-n", "1"], input: password + "\n", timeout: 8) {
                let excerpt = String(out2.prefix(400))
                return excerpt
            }
        }

        return nil
    }

    func readPowermetricsTemp() -> String? {
        if let full = readPowermetricsFull() {
            // Common labels to search for in powermetrics output (use regex and case-insensitive)
            let patterns = ["CPU die temperature", "Package temperature", "CPU package temperature", "CPU Temp", "CPU Temperature", "CPU\\s*package", "package temperature"]
            for p in patterns {
                if let range = full.range(of: p, options: [.regularExpression, .caseInsensitive]) {
                    let s = String(full[range.lowerBound...])
                    if let n = parseTempNumber(s) {
                        return String(format: "%.1f°C", n)
                    }
                }
            }

            // last resort: search the entire output for first floating number followed by 'C' or '°C'
            if let m = full.range(of: "\\d+\\.?\\d*\\s?°?C", options: .regularExpression) {
                let s = String(full[m])
                if let n = parseTempNumber(s) {
                    return String(format: "%.1f°C", n)
                }
            }
        }
        return nil
    }

    func readPowermetricsPower() -> String? {
        if let full = readPowermetricsFull() {
            if let range = full.range(of: "CPU Power", options: .caseInsensitive) {
                let s = String(full[range.lowerBound...])
                if let n = parseTempNumber(s) {
                    // n is in mW per powermetrics output
                    let value = Double(n)
                    // If >= 1000 mW, show in Watts with one decimal (e.g. 6.3 W)
                    if value >= 1000.0 {
                        let w = value / 1000.0
                        return String(format: "%.1f W", w)
                    } else {
                        let mv = Int(round(value))
                        return "\(mv) mW"
                    }
                }
            }
            // fallback: search for Combined Power or GPU/CPU power lines
            if let range = full.range(of: "Combined Power", options: .caseInsensitive) {
                let s = String(full[range.lowerBound...])
                if let n = parseTempNumber(s) {
                    let value = Double(n)
                    if value >= 1000.0 {
                        let w = value / 1000.0
                        return String(format: "combined: %.1f W", w)
                    } else {
                        let mv = Int(round(value))
                        return "combined: \(mv) mW"
                    }
                }
            }
        }
        return nil
    }

    // Helper to extract the first floating number found in a string
    func parseTempNumber(_ s: String) -> Double? {
        // Use Character set filtering to capture digits, dot and minus
        var numStr = ""
        var foundDigit = false
        for ch in s {
            if ch.isNumber || ch == "." || ch == "-" {
                numStr.append(ch)
                foundDigit = true
            } else if foundDigit {
                // break after the first run of number characters
                break
            }
        }
        if numStr.isEmpty { return nil }
        return Double(numStr)
    }

    @discardableResult
    func runProcess(_ launchPath: String, args: [String], input: String? = nil, timeout: TimeInterval = 10) -> String? {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: launchPath)
        task.arguments = args

        let outPipe = Pipe()
        task.standardOutput = outPipe
        task.standardError = Pipe()

        var inPipe: Pipe? = nil
        if input != nil {
            inPipe = Pipe()
            task.standardInput = inPipe
        }

        do {
            try task.run()
        } catch {
            return nil
        }

        if let input = input, let p = inPipe {
            if let data = input.data(using: .utf8) {
                p.fileHandleForWriting.write(data)
            }
            p.fileHandleForWriting.closeFile()
        }

        // wait up to timeout seconds
        let deadline = Date().addingTimeInterval(timeout)
        while task.isRunning && Date() < deadline {
            RunLoop.current.run(mode: .default, before: Date().addingTimeInterval(0.01))
        }
        if task.isRunning {
            task.terminate()
            return nil
        }
        let data = outPipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: data, encoding: .utf8)
    }

    // Read a password from Keychain using service name "MenuTemp"
    func getKeychainPassword() -> String? {
        if let out = runProcess("/usr/bin/security", args: ["find-generic-password", "-s", "MenuTemp", "-w"], timeout: 2) {
            let pwd = out.trimmingCharacters(in: .whitespacesAndNewlines)
            if pwd.isEmpty { return nil }
            return pwd
        }
        return nil
    }
}

let delegate = AppDelegate()
let app = NSApplication.shared
app.delegate = delegate
app.run()
