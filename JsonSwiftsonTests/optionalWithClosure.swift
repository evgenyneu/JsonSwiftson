//
//  Map an optional object with a closure using `optional: true` parameter.
//  If the value is null the mapping is considered successful.
//
//  Examples
//  -------
//
//  { "planet": "Moon" }
//  null
//

import UIKit
import XCTest
import JsonSwiftson

class optionalWithClosureTests: XCTestCase {
  struct testPlanet {
    let name: String
  }

  func testOptionalWithClosure() {

    let p = JsonSwiftson(json: "{ \"planet\": \"Saturn\" }")

    let result: testPlanet? = p.map(optional: true) { m in
      testPlanet(
        name: m["planet"].map() ?? ""
      )
    }

    XCTAssert(p.ok)
    XCTAssertEqual("Saturn", result!.name)
  }

  func testOptionalWithClosure_null() {

    let p = JsonSwiftson(json: "null")

    let result: testPlanet? = p.map(optional: true) { m in
      testPlanet(
        name: m["planet"].map() ?? ""
      )
    }

    XCTAssert(p.ok)
    XCTAssert(result == nil)
  }

  // ----- errors -----


  func testError_OptionalWithClosure_wrongType() {

    let p = JsonSwiftson(json: "123")

    let result: testPlanet? = p.map(optional: true) { m in
      testPlanet(
        name: m["planet"].map() ?? ""
      )
    }

    XCTAssertFalse(p.ok)
    XCTAssert(result == nil)
  }

  func testError_OptionalWithClosure_incorrectJson() {

    let p = JsonSwiftson(json: "")

    let result: testPlanet? = p.map(optional: true) { m in
      testPlanet(
        name: m["planet"].map() ?? ""
      )
    }

    XCTAssertFalse(p.ok)
    XCTAssert(result == nil)
  }

  func testError_OptionalWithClosure_missingAttributeInClosure() {

    let p = JsonSwiftson(json: "{ \"missing\": \"value\" }")

    let result: testPlanet? = p.map(optional: true) { m in
      testPlanet(
        name: m["planet"].map() ?? ""
      )
    }

    XCTAssertFalse(p.ok)
    XCTAssert(result == nil)
  }
}