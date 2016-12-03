import Foundation

// Try changing the sleeping time to simulate different load. Observe the values logged in Console. It may not print all values from 1 to 9999 if it cannot keep up with the producer's rate. When the sleep time is larger, the block will be executed less frequently.
func simulateHeavyProcessing() { Thread.sleep(forTimeInterval: 0.1) }

let channel = ThrottledChannel<Int> {
    print($0)
    simulateHeavyProcessing()
}

for i in 1..<10000 {
    channel.send(i)
}
