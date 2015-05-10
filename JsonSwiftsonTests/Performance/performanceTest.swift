//
// Detecting performance regressions
//

import UIKit
import XCTest
import JsonSwiftson

class performanceTests: XCTestCase {

  func testPerformanceExample() {

    measureBlock {
      for x in 1...1000 {
        let p = JsonSwiftson(json: "\"Marsupials are cute\"")
        let result: String = p.map() ?? ""
      }
    }
  }
}