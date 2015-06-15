//
// Detecting performance regressions
//

import UIKit
import XCTest
import JsonSwiftson

class performanceTests: XCTestCase {

  func testPerformanceExample() {

    measureBlock {
      for _ in 1...1000 {
        let p = JsonSwiftson(json: "\"Marsupials are cute\"")
        p.map() ?? ""
      }
    }
  }
}