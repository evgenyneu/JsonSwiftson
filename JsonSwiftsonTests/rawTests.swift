import UIKit
import XCTest
import JsonSwiftson

class rawTests: XCTestCase {

  // Strings
  // -------------
  
  func testString() {
    let result = JsonSwiftson.parseRaw("\"Possums are cute\"") as! String
    XCTAssertEqual("Possums are cute", result)
  }

  func testStringWithUnicode() {
    let result = JsonSwiftson.parseRaw("\"\\u0026🐨日本\"") as! String
    XCTAssertEqual("&🐨日本", result)
  }

  func testString_blank() {
    let result = JsonSwiftson.parseRaw("\"Possums are cute\"") as! String
    XCTAssertEqual("Possums are cute", result)
  }

  // ----- errors -----

  func testError_stringWithNoQuotes() {
    let result: Any?
      = JsonSwiftson.parseRaw("String without double quotes is not a valid JSON value")

    XCTAssert(result == nil)
  }

  // Numbers
  // -------------

  func testInteger() {
    let result = JsonSwiftson.parseRaw("123") as! Int
    XCTAssertEqual(123, result)
  }

  func testInteger_negative() {
    let result = JsonSwiftson.parseRaw("-123") as! Int
    XCTAssertEqual(-123, result)
  }

  func testDouble() {
    let result = JsonSwiftson.parseRaw("1.1") as! Double
    XCTAssertEqual(1.1, result)
  }

  func testPowerOfTen() {
    let result = JsonSwiftson.parseRaw("1.23e3") as! Double
    XCTAssertEqual(1230, result)
  }

  func testPowerOfTen_withPlusSign() {
    let result = JsonSwiftson.parseRaw("1.23e+3") as! Double
    XCTAssertEqual(1230, result)
  }

  func testPowerOfTen_capitalE() {
    let result = JsonSwiftson.parseRaw("1.23E3") as! Double
    XCTAssertEqual(1230, result)
  }

  func testNegativePowerOfTen() {
    let result = JsonSwiftson.parseRaw("1.23e-3") as! Double
    XCTAssertEqual(0.00123, result)
  }

  // Booleans
  // -------------

  func testBool() {
    let result = JsonSwiftson.parseRaw("true") as! Bool
    XCTAssert(result)
  }

  func testBool_false() {
    let result = JsonSwiftson.parseRaw("false") as! Bool
    XCTAssertFalse(result)
  }

  // null
  // -------------

  func testNull() {
    let result = JsonSwiftson.parseRaw("null") as! NSNull

    // Note that result is NSNull() and not nil
    // NSNull() means valid null JSON value, while nil means parsing/mapping error.
    XCTAssertEqual(NSNull(), result)
  }

  // Empty
  // -------------

  func testError_empty() {
    let result: Any? = JsonSwiftson.parseRaw("")
    XCTAssert(result == nil)
  }

  func testError_empty_spaceCharactersOnly() {
    let result: Any? = JsonSwiftson.parseRaw(" ")
    XCTAssert(result == nil)
  }
}
