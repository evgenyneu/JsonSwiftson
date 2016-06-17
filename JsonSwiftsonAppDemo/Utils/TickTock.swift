
//
//  Measures elapsed time
//
//  Usage:
//
//    let tick = TickTock()
//    ... code to measure execution time for
//    tick.formattedWithMs()
//
//    Output: [TOCK] 10.2 ms
//

import Foundation

class TickTock {
  var startTime:Date
  
  init() {
    startTime = Date()
  }
  
  func measure() -> Double {
    return Double(Int(-startTime.timeIntervalSinceNow * 10000)) / 10
  }
  
  func formatted() -> String {
    let elapsedMs = measure()
    return String(format: "%.1f", elapsedMs)
  }
  
  func formattedWithMs(_ message: String? = nil) -> String {
    let outputPrefix = message ?? "[TOCK]"
    return "\(outputPrefix) \(formatted()) ms"
  }
  
  func output(_ message: String? = nil) {
    print(formattedWithMs(message))
  }
}
