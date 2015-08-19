//
//  Cast json containing an array.
//
//  Examples
//  ---------
//
//    ["Penguins", "are", "flightless", "birds", "that", "fly", "through", "water"]
//    [1, 2, 3]
//

import UIKit
import XCTest
import JsonSwiftson

class topLevelArrayTests: XCTestCase {

  // Array of strings
  // -------------

  func testArrayOfStrings() {
    let p = JsonSwiftson(json: "[ \"Mitochondria\", \"make\", \"ATP\" ]")
    let result: [String] = p.map() ?? []

    XCTAssert(p.ok)
    XCTAssertEqual(["Mitochondria", "make", "ATP"], result)
  }

  // ----- errors -----

  func testError_array_wrongValueType() {
    let p = JsonSwiftson(json: "[2, 4, 5]")
    let result: [String] = p.map() ?? ["my error"]

    XCTAssertFalse(p.ok)
    XCTAssertEqual(["my error"], result)
  }

  func testError_array_null() {
    let p = JsonSwiftson(json: "null")
    let result: [String] = p.map() ?? ["my null"]

    XCTAssertFalse(p.ok)
    XCTAssertEqual(["my null"], result)
  }
  
  func testError_array_report() {
    let p = JsonSwiftson(json: "null")
    let _: [String] = p.map() ?? ["my null"]
    
    XCTAssertEqual("Array<String>", p.errorMappingToType!)
    XCTAssertEqual(JsonSwiftsonErrors.TypeMappingError, p.errorType!)
    XCTAssertEqual("Could not map root JSON value to Array<String>", p.errorMessage!)
  }

  // Array of numbers
  // -------------

  func testArrayOfIntegers() {
    let p = JsonSwiftson(json: "[2, 5, 9]")
    let result: [Int] = p.map() ?? []

    XCTAssert(p.ok)
    XCTAssertEqual([2, 5, 9], result)
  }

  func testArrayOfDoubles() {
    let p = JsonSwiftson(json: "[2, 5.1, 9.2]")
    let result: [Double] = p.map() ?? []

    XCTAssert(p.ok)
    XCTAssertEqual([2.0, 5.1, 9.2], result)
  }

  // ----- errors -----

  func testError_array_mixedTypes() {
    let p = JsonSwiftson(json: "[2, 5.1, 9.2, \"mixed\" ]")
    let result: [Double] = p.map() ?? [-1.123]

    XCTAssertFalse(p.ok)
    XCTAssertEqual([-1.123], result)
  }

  func testError_arrayOfIntegers_null() {
    let p = JsonSwiftson(json: "null")
    let result: [Int] = p.map() ?? [4_234]

    XCTAssertFalse(p.ok)
    XCTAssertEqual([4_234], result)
  }

  // Array of booleans
  // -------------

  func testArrayOfBooleans() {
    let p = JsonSwiftson(json: "[true, true, true, false]")
    let result: [Bool] = p.map() ?? []

    XCTAssert(p.ok)
    XCTAssertEqual([true, true, true, false], result)
  }

  // Empty array
  // -------------

  func testEmptyArray() {
    let p = JsonSwiftson(json: "[]")
    let result: [Int] = p.map() ?? []

    XCTAssert(p.ok)
    XCTAssertEqual([], result)
  }


  // Array of arrays
  // -------------

  func testArrayOfStringArrays() {
    let p = JsonSwiftson(json:
      "[" +
        "[ \"crab\", \"lobster\", \"shrimp\" ]," +
        "[ \"frog\", \"snake\", \"salamander\" ]" +
      "]")

    let result: [[String]] = p.map() ?? []

    XCTAssert(p.ok)
    XCTAssertEqual(2, result.count)
    XCTAssertEqual(["crab", "lobster", "shrimp"], result[0])
    XCTAssertEqual(["frog", "snake", "salamander"], result[1])
  }
}

