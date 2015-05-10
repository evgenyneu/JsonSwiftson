//
//  Map json array that may be optional using `optional: true` parameter.
//  If the value is null the mapping is considered successful.
//
//  Examples
//  ---------
//
//    ["Gorilla", "Chimpanzee", "Human"]
//    [234, 5430, 2]
//    null
//

import UIKit
import XCTest
import JsonSwiftson

class optionalTopLevelArrayTests: XCTestCase {
  // Array of strings
  // -------------

  func testArrayOfStrings() {
    let p = JsonSwiftson(json: "[ \"Mitochondria\", \"make\", \"ATP\" ]")
    let result: [String]? = p.map(optional: true)

    XCTAssert(p.ok)
    XCTAssertEqual(["Mitochondria", "make", "ATP"], result!)
  }

  func testArrayOfStrings_null() {
    let p = JsonSwiftson(json: "null")
    let result: [String]? = p.map(optional: true)

    XCTAssert(p.ok)
    XCTAssert(result == nil)
  }

  // ----- errors -----

  func testError_arrayOfStrings_wrongType() {
    let p = JsonSwiftson(json: "123")
    let result: [String]? = p.map(optional: true)

    XCTAssertFalse(p.ok)
    XCTAssert(result == nil)
  }

  func testError_arrayOfStrings_incorrectJson() {
    let p = JsonSwiftson(json: "1 2 3")
    let result: [String]? = p.map(optional: true)

    XCTAssertFalse(p.ok)
    XCTAssert(result == nil)
  }

  // Array of numbers
  // -------------

  func testArrayOfNumbers() {
    let p = JsonSwiftson(json: "[3, 5, 7]")
    let result: [Int]? = p.map(optional: true)

    XCTAssert(p.ok)
    XCTAssertEqual([3, 5, 7], result!)
  }

  func testArrayOfNumbers_null() {
    let p = JsonSwiftson(json: "null")
    let result: [Int]? = p.map(optional: true)

    XCTAssert(p.ok)
    XCTAssert(result == nil)
  }

  // ----- errors -----

  func testError_arrayOfNumbers_wrongType() {
    let p = JsonSwiftson(json: "[\"not a number\"]")
    let result: [Int]? = p.map(optional: true)

    XCTAssertFalse(p.ok)
    XCTAssert(result == nil)
  }

  func testError_arrayOfNumbers_invalidJson() {
    let p = JsonSwiftson(json: "\"")
    let result: [Int]? = p.map(optional: true)

    XCTAssertFalse(p.ok)
    XCTAssert(result == nil)
  }
}

