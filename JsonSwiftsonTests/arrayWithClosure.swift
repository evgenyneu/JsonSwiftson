//
//  Process an array supplying the mapping closure for each element.
//  This way we can map arrays of structures.
//
//  Example
//  -------
//
//  [ { "planet": "Saturn" }, { "planet": "Moon" } ]
//

import UIKit
import XCTest
import JsonSwiftson

class arrrayWithClosureTests: XCTestCase {
  func testArrayWithClosure() {
    let p = JsonSwiftson(json: "[ { \"planet\": \"Saturn\" }, { \"planet\": \"Moon\" } ]")

    var result: [String] = p.mapArrayOfObjects { m in
      m["planet"].map() ?? "✋"
    } ?? []

    XCTAssert(p.ok)
    XCTAssertEqual(["Saturn", "Moon"], result)
  }

  func testArrayWithClosure_emptyArray() {
    let p = JsonSwiftson(json: "[ ]")

    var result: [String] = p.mapArrayOfObjects { m in
      m["planet"].map() ?? "✋"
    } ?? ["🐮"]

    XCTAssert(p.ok)
    XCTAssertEqual([], result)
  }

  // ----- errors -----

  func testError_arrayWithClosure_null() {
    let p = JsonSwiftson(json: "null")

    var result: [String] = p.mapArrayOfObjects { m in
      m["planet"].map() ?? "✋"
    } ?? ["🐮"]

    XCTAssertFalse(p.ok)
    XCTAssertEqual(["🐮"], result)
  }

  func testError_arrayWithClosure_notAnArray() {
    let p = JsonSwiftson(json: "\"not an array\"")

    var result: [String] = p.mapArrayOfObjects { m in
      m["planet"].map() ?? "✋"
    } ?? ["🐮"]

    XCTAssertFalse(p.ok)
    XCTAssertEqual(["🐮"], result)
  }

  func testError_arrayWithClosure_elementsMissing() {
    let p = JsonSwiftson(json: "[ { \"day\": \"Sat\" }, { \"day\": \"Mon\" } ]")

    var result: [String] = p.mapArrayOfObjects { m in
      m["planet"].map() ?? "✋"
    } ?? ["🐮"]

    XCTAssertFalse(p.ok)
    XCTAssertEqual(["🐮"], result)
  }

  func testError_arrayWithClosure_elementsNull() {
    let p = JsonSwiftson(json: "[ { \"planet\": null }, { \"planet\": \"Moon\" } ]")

    var result: [String] = p.mapArrayOfObjects { m in
      m["planet"].map() ?? "✋"
    } ?? ["🐮"]

    XCTAssertFalse(p.ok)
    XCTAssertEqual(["🐮"], result)
  }

  func testError_arrayWithClosure_elementMissingDownTheLine() {
    let p = JsonSwiftson(json: "[ { \"planet\": \"Saturn\" }, { \"missing\": \"Moon\" } ]")

    var result: [String] = p.mapArrayOfObjects { m in
      m["planet"].map() ?? "✋"
    } ?? ["🐮"]

    XCTAssertFalse(p.ok)
    XCTAssertEqual(["🐮"], result)
  }
}