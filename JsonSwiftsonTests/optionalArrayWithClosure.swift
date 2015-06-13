//
//  Map an optional array with a closure using `optional: true` parameter.
//  If the value is null the mapping is considered successful.
//
//  Examples
//  -------
//
//  [ { "planet": "Saturn" }, { "planet": "Moon" } ]
//  null
//

import UIKit
import XCTest
import JsonSwiftson

class optionalArrayWithClosureTests: XCTestCase {
  func testOptionalArrayWithClosure() {
    let p = JsonSwiftson(json: "[ { \"planet\": \"Saturn\" }, { \"planet\": \"Moon\" } ]")

    let result: [String]? = p.mapArrayOfObjects(optional: true) { m in
      m["planet"].map() ?? "✋"
    }

    XCTAssert(p.ok)
    XCTAssertEqual(["Saturn", "Moon"], result!)
  }

  func testOptionalArrayWithClosure_null() {
    let p = JsonSwiftson(json: "null")

    let result: [String]? = p.mapArrayOfObjects(optional: true) { m in
      m["planet"].map() ?? "✋"
    }

    XCTAssert(p.ok)
    XCTAssert(result == nil)
  }

  // ----- errors -----

  func testError_optionalArrayWithClosure_wrongType() {
    let p = JsonSwiftson(json: "234")

    let result: [String]? = p.mapArrayOfObjects(optional: true) { m in
      m["planet"].map() ?? "✋"
    }

    XCTAssertFalse(p.ok)
    XCTAssert(result == nil)
  }

  func testError_optionalArrayWithClosure_incorrectJson() {
    let p = JsonSwiftson(json: "{ incorrect")

    let result: [String]? = p.mapArrayOfObjects(optional: true) { m in
      m["planet"].map() ?? "✋"
    }

    XCTAssertFalse(p.ok)
    XCTAssert(result == nil)
  }

}