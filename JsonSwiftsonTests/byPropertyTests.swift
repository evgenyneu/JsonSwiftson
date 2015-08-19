//
//  Get new mapper by JSON property.
//  It allows us to map property values.
//
//  Example
//  -------
//
//    { "fairy": "little" }
//
//

import UIKit
import XCTest
import JsonSwiftson

class byPropertyTests: XCTestCase {

  func testProperty() {
    let p = JsonSwiftson(json: "{ \"Sun\": \"Saturn\"  }")

    let subP = p["Sun"]
    let result: String = subP.map() ?? ""

    XCTAssert(p.ok)
    XCTAssert(subP.ok)

    XCTAssertEqual("Saturn", result)
  }

  func testOptionalPropertyDoesNotExist() {
    let p = JsonSwiftson(json: "{ \"Sun\": \"Saturn\"  }")

    let subP = p["Mon"]
    let result: String = subP.map(optional: true) ?? "👍"

    XCTAssert(p.ok)
    XCTAssert(subP.ok)

    XCTAssertEqual("👍", result)
  }

  // ----- errors -----

  func testError_propertyDoesNotExist() {
    let p = JsonSwiftson(json: "{ \"Sun\": \"Saturn\"  }")

    let subP = p["Mon"]
    let result: String = subP.map() ?? "🙊"

    XCTAssertFalse(p.ok)
    XCTAssertFalse(subP.ok)

    XCTAssertEqual("🙊", result)
  }

  func testError_parentJsonIsNotAnObject() {
    let p = JsonSwiftson(json: "\"not object\"")

    let subP = p["Mon"]
    let result: String = subP.map() ?? "🙊"

    XCTAssertFalse(p.ok)
    XCTAssertFalse(subP.ok)

    XCTAssertEqual("🙊", result)
    XCTAssert(p.errorMappingToType == nil)
    XCTAssertEqual(JsonSwiftsonErrors.CanNotGetAttribute, p.errorType)
//    XCTAssertEqual("Could not map root JSON value to Array<String>", p.errorMessage!)
  }
}