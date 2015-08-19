//
//  Map json containing non-object value. It can be a string, number, boolean or null.
//
//  Examples
//  ---------
//
//  "a string"
//  123
//  true
//  null
//

import UIKit
import XCTest
import JsonSwiftson

class topLevelValueTests: XCTestCase {

  // Strings
  // -------------

  func testString() {
    let p = JsonSwiftson(json: "\"Marsupials are cute\"")
    let result: String = p.map() ?? ""

    XCTAssert(p.ok)
    XCTAssertEqual("Marsupials are cute", result)
  }

  // ----- errors -----

  func testError_string_noQuotes() {
    let p = JsonSwiftson(json: "String without quotes is not a valid JSON value")
    let result: String = p.map() ?? "incorrect"

    XCTAssertFalse(p.ok)
    XCTAssertEqual("incorrect", result)
  }

  func testError_string_missing() {
    let p = JsonSwiftson(json: "")
    let result: String = p.map() ?? "test missing"

    XCTAssertFalse(p.ok)
    XCTAssertEqual("test missing", result)
  }

  func testError_string_null() {
    let p = JsonSwiftson(json: "null")
    let result: String = p.map() ?? "test null"

    XCTAssertFalse(p.ok)
    XCTAssertEqual("test null", result)
  }
  
  func testError_string_report() {
    let p = JsonSwiftson(json: "String without quotes is not a valid JSON value")
    let _: String = p.map() ?? "incorrect"
    
    XCTAssertEqual("String", p.errorMappingToType!)
    XCTAssertEqual(JsonSwiftsonErrors.TypeMappingError, p.errorType!)
    XCTAssertEqual("Could not map root JSON value to String", p.errorMessage!)
  }

  // Numbers
  // -------------

  func testInteger() {
    let p = JsonSwiftson(json: "987")
    let result: Int = p.map() ?? 0

    XCTAssert(p.ok)
    XCTAssertEqual(987, result)
  }

  func testInteger_negative() {
    let p = JsonSwiftson(json: "-987")
    let result: Int = p.map() ?? 0

    XCTAssert(p.ok)
    XCTAssertEqual(-987, result)
  }

  func testDouble() {
    let p = JsonSwiftson(json: "44.07")
    let result: Double = p.map() ?? 0

    XCTAssert(p.ok)
    XCTAssertEqual(44.07, result)
  }

  func testPowerOfTen() {
    let p = JsonSwiftson(json: "1.2e5")
    let result: Double = p.map() ?? 0

    XCTAssert(p.ok)
    XCTAssertEqual(120_000, result)
  }

  func testPowerOfTen_capitalE() {
    let p = JsonSwiftson(json: "3.4E2")
    let result: Double = p.map() ?? 0

    XCTAssert(p.ok)
    XCTAssertEqual(340, result)
  }

  func testNegativePowerOfTen() {
    let p = JsonSwiftson(json: "1.1e-3")
    let result: Double = p.map() ?? 0

    XCTAssert(p.ok)
    XCTAssertEqual(0.0011, result)
  }

  // ----- errors -----

  func testError_integer_null() {
    let p = JsonSwiftson(json: "null")
    let result: Int = p.map() ?? -1392

    XCTAssertFalse(p.ok)
    XCTAssertEqual(-1392, result)
  }

  func testError_integer_incorrect() {
    let p = JsonSwiftson(json: "123 345")
    let result: Int = p.map() ?? 34535

    XCTAssertFalse(p.ok)
    XCTAssertEqual(34535, result)
  }
  
  func testError_integer_report() {
    let p = JsonSwiftson(json: "null")
    let _: Int = p.map() ?? -1392
    
    XCTAssertEqual("Int", p.errorMappingToType!)
    XCTAssertEqual(JsonSwiftsonErrors.TypeMappingError, p.errorType!)
    XCTAssertEqual("Could not map root JSON value to Int", p.errorMessage!)
  }

  // Booleans
  // -------------

  func testBool_true() {
    let p = JsonSwiftson(json: "true")
    let result: Bool = p.map() ?? true

    XCTAssert(p.ok)
    XCTAssertEqual(true, result)
  }

  func testBool_false() {
    let p = JsonSwiftson(json: "false")
    let result: Bool = p.map() ?? true

    XCTAssert(p.ok)
    XCTAssertEqual(false, result)
  }

  // null
  // -------------

  func testNull() {
    let p = JsonSwiftson(json: "null")
    let result: NSNull = p.map() ?? NSNull()

    XCTAssert(p.ok)
    XCTAssertEqual(NSNull(), result) // Note that result is NSNull() and not nil
  }

  // ----- errors -----

  func testError_null_incorrect() {
    let p = JsonSwiftson(json: "incorrect")
    let result: NSNull = p.map() ?? NSNull()

    XCTAssertFalse(p.ok)
    XCTAssertEqual(NSNull(), result)
  }
}
