import Foundation

func runProcess(_ launchPath: String, args: [String], input: String? = nil, timeout: TimeInterval = 2) -> String? {
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
        print("Failed to run: \(error)")
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

func readPowermetricsFull() -> String? {
    let pm = "/usr/bin/powermetrics"
    print("Testing powermetrics without sudo...")
    if let out = runProcess(pm, args: ["--samplers", "cpu_power", "-n", "1"], timeout: 6) {
        print("Success without sudo!")
        return String(out.prefix(400))
    }
    print("Failed without sudo, need root privileges")
    return nil
}

func parseTempNumber(_ s: String) -> Double? {
    var numStr = ""
    var foundDigit = false
    for ch in s {
        if ch.isNumber || ch == "." || ch == "-" {
            numStr.append(ch)
            foundDigit = true
        } else if foundDigit {
            break
        }
    }
    if numStr.isEmpty { return nil }
    return Double(numStr)
}

func readPowermetricsPower() -> String? {
    if let full = readPowermetricsFull() {
        print("Got powermetrics output: \(full)")
        if let range = full.range(of: "CPU Power", options: .caseInsensitive) {
            let s = String(full[range.lowerBound...])
            if let n = parseTempNumber(s) {
                let value = Double(n)
                if value >= 1000.0 {
                    let w = value / 1000.0
                    return String(format: "%.1f W", w)
                } else {
                    let mv = Int(round(value))
                    return "\(mv) mW"
                }
            }
        }
    }
    return nil
}

print("Testing power reading...")
if let power = readPowermetricsPower() {
    print("Power: \(power)")
} else {
    print("Could not read power")
}