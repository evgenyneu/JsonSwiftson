import UIKit
import XCTest
import JsonSwiftson

class rawArrayTests: XCTestCase {
  
  // Array of strings
  // -------------

  func testArrayOfStrings() {
    let result = try! JsonSwiftson.parseRaw("[ \"double-blind\", \"randomized\" ]") as! [String]
    XCTAssertEqual(["double-blind", "randomized"], result)
  }

  // Array of numbers
  // -------------

  func testArrayOfIntegers() {
    let result = try! JsonSwiftson.parseRaw("[123, 456]") as! [Int]
    XCTAssertEqual([123, 456], result)
  }

  func testArrayOfDoubles() {
    let result = try! JsonSwiftson.parseRaw("[1.1, 2.2, 3]") as! [Double]
    XCTAssertEqual([1.1, 2.2, 3.0], result)
  }
}
