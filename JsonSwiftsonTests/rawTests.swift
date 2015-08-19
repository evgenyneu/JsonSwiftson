import UIKit
import XCTest
import JsonSwiftson

class rawTests: XCTestCase {

  // Strings
  // -------------
  
  func testString() {
    let result = try! JsonSwiftson.parseRaw("\"Possums are cute\"") as! String
    XCTAssertEqual("Possums are cute", result)
  }

  func testStringWithUnicode() {
    let result = try! JsonSwiftson.parseRaw("\"\\u0026🐨日本\"") as! String
    XCTAssertEqual("&🐨日本", result)
  }

  func testString_blank() {
    let result = try! JsonSwiftson.parseRaw("\"Possums are cute\"") as! String
    XCTAssertEqual("Possums are cute", result)
  }

  // ----- errors -----

  func testError_stringWithNoQuotes() {
    var threwError = false
    var result: AnyObject?

    do {
      result = try JsonSwiftson.parseRaw("String without double quotes is not a valid JSON value")
    }
    
    catch _ { threwError = true }

    XCTAssert(threwError)
    XCTAssert(result == nil)
  }
  
  func testError_stringWithNoQuotes_report() {
    let p = JsonSwiftson(json: "incorrect json")
    
    XCTAssertFalse(p.ok)
    XCTAssert(p.errorMappingToType == nil)
    XCTAssertEqual(JsonSwiftsonErrors.ParsingError, p.errorType!)
    XCTAssertEqual("Could not parse text into JSON", p.errorMessage!)
  }

  // Numbers
  // -------------

  func testInteger() {
    let result = try! JsonSwiftson.parseRaw("123") as! Int
    XCTAssertEqual(123, result)
  }

  func testInteger_negative() {
    let result = try! JsonSwiftson.parseRaw("-123") as! Int
    XCTAssertEqual(-123, result)
  }

  func testDouble() {
    let result = try! JsonSwiftson.parseRaw("1.1") as! Double
    XCTAssertEqual(1.1, result)
  }

  func testPowerOfTen() {
    let result = try! JsonSwiftson.parseRaw("1.23e3") as! Double
    XCTAssertEqual(1230, result)
  }

  func testPowerOfTen_withPlusSign() {
    let result = try! JsonSwiftson.parseRaw("1.23e+3") as! Double
    XCTAssertEqual(1230, result)
  }

  func testPowerOfTen_capitalE() {
    let result = try! JsonSwiftson.parseRaw("1.23E3") as! Double
    XCTAssertEqual(1230, result)
  }

  func testNegativePowerOfTen() {
    let result = try! JsonSwiftson.parseRaw("1.23e-3") as! Double
    XCTAssertEqual(0.00123, result)
  }

  // Booleans
  // -------------

  func testBool() {
    let result = try! JsonSwiftson.parseRaw("true") as! Bool
    XCTAssert(result)
  }

  func testBool_false() {
    let result = try! JsonSwiftson.parseRaw("false") as! Bool
    XCTAssertFalse(result)
  }

  // null
  // -------------

  func testNull() {
    let result = try! JsonSwiftson.parseRaw("null") as! NSNull

    // Note that result is NSNull() and not nil
    // NSNull() means valid null JSON value, while nil means parsing/mapping error.
    XCTAssertEqual(NSNull(), result)
  }

  // Empty
  // -------------

  func testError_empty() {
    var threwError = false
    var result: AnyObject?
    
    do {
      result = try JsonSwiftson.parseRaw("")
    }
      
    catch _ { threwError = true }
    
    XCTAssert(threwError)
    XCTAssert(result == nil)
  }

  func testError_empty_spaceCharactersOnly() {
    var threwError = false
    var result: AnyObject?
    
    do {
      result = try JsonSwiftson.parseRaw(" ")
    }
      
    catch _ { threwError = true }
    
    XCTAssert(threwError)
    XCTAssert(result == nil)
  }
}
