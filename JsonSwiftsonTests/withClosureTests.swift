//
//  Map an object with a closure.
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

class withClosureTests: XCTestCase {
  struct testPlanet {
    let name: String
  }

  func testOptionalWithClosure() {

    let p = JsonSwiftson(json: "{ \"planet\": \"Saturn\" }")

    var result: testPlanet = p.map { m in
      testPlanet(
        name: m["planet"].map() ?? ""
      )
    } ?? testPlanet(name: "🐝")

    XCTAssert(p.ok)
    XCTAssertEqual("Saturn", result.name)
  }

  // ----- errors -----

  func testError_optionalWithClosure_null() {

    let p = JsonSwiftson(json: "null")

    var result: testPlanet = p.map { m in
      testPlanet(
        name: m["planet"].map() ?? ""
      )
    } ?? testPlanet(name: "🐝")

    XCTAssertFalse(p.ok)
    XCTAssertEqual("🐝", result.name)
  }

  func testError_optionalWithClosure_childAttributeIsNull() {

    let p = JsonSwiftson(json: "{ \"planet\": null }")

    var result: testPlanet = p.map { m in
      testPlanet(
        name: m["planet"].map() ?? ""
      )
    } ?? testPlanet(name: "🐝")

    XCTAssertFalse(p.ok)
    XCTAssertEqual("🐝", result.name)
  }
}
