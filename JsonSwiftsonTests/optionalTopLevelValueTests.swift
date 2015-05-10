//
//  Map json value that may be optional using `optional: true` parameter.
//  If the value is null the mapping is considered successful.
//
//  Examples
//  ---------
//
//    "a string"
//    123
//    true
//    null
//

import UIKit
import XCTest
import JsonSwiftson

class optionalTopLevelValueTests: XCTestCase {

  // Strings
  // -------------

  func testOptionalString() {
    let p = JsonSwiftson(json: "\"Marsupials are cute\"")
    let result: String? = p.map(optional: true)

    XCTAssert(p.ok)
    XCTAssertEqual("Marsupials are cute", result!)
  }


  func testOptionalString_null() {
    let p = JsonSwiftson(json: "null")
    let result: String? = p.map(optional: true)

    XCTAssert(p.ok)
    XCTAssert(result == nil)
  }

  // ----- errors -----

  func testError_optionalString_wrongType() {
    let p = JsonSwiftson(json: "123456")
    let result: String? = p.map(optional: true)

    XCTAssertFalse(p.ok)
    XCTAssert(result == nil)
  }

  func testError_optionalString_incorrectJson() {
    let p = JsonSwiftson(json: "{ icorrect")
    let result: String? = p.map(optional: true)

    XCTAssertFalse(p.ok)
    XCTAssert(result == nil)
  }

  // Numbers
  // -------------

  func testOptionalInteger() {
    let p = JsonSwiftson(json: "423")
    let result: Int? = p.map(optional: true)

    XCTAssert(p.ok)
    XCTAssertEqual(423, result!)
  }

  func testOptionalInteger_null() {
    let p = JsonSwiftson(json: "null")
    let result: Int? = p.map(optional: true)

    XCTAssert(p.ok)
    XCTAssert(result == nil)
  }

  // ----- errors -----

  func testError_optionalInteger_wrongType() {
    let p = JsonSwiftson(json: "\"not a number\"")
    let result: Int? = p.map(optional: true)

    XCTAssertFalse(p.ok)
    XCTAssert(result == nil)
  }

  // Booleans
  // -------------

  func testOptionalBool() {
    let p = JsonSwiftson(json: "true")
    let result: Bool? = p.map(optional: true)

    XCTAssert(p.ok)
    XCTAssertEqual(true, result!)
  }

  func testOptionalBool_null() {
    let p = JsonSwiftson(json: "null")
    let result: Bool? = p.map(optional: true)

    XCTAssert(p.ok)
    XCTAssert(result == nil)
  }

  // ----- errors -----

  func testError_optionalBool_wrongType() {
    let p = JsonSwiftson(json: "\"not a bool\"")
    let result: Bool? = p.map(optional: true)

    XCTAssertFalse(p.ok)
    XCTAssert(result == nil)
  }
}
