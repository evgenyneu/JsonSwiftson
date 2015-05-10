//
//  Map an array with optional elemenets using a closure.
//  If an array element is missing or null the mapping is successful.
//
//  Example
//  -------
//
//  Suppose we want to map an attribute with a name "planet".
//  Only the first element in JSON array has "planets" attribute.
//
//  [ { "planet": "Saturn" }, { "planet": null }, { "different": "value" } ]
//
//  This JSON will map to this array: ["planet", nil, nil]
//

import UIKit
import XCTest
import JsonSwiftson

class optionalArrayElementsWithClosureTests: XCTestCase {
  func testOptionalArrayElementsWithClosure_elementsMissing() {
    let p = JsonSwiftson(json: "[" +
      "{ \"different\": \"value\" }," +
      "{ \"planet\": \"Saturn\" }" +
    "]")

    var result: [String?] = p.mapArrayOfObjects(optional: true) { m in
      m["planet"].map(optional: true)
    } ?? ["🐨"]

    XCTAssert(p.ok)

    XCTAssertEqual(2, result.count)
    XCTAssert(result[0] == nil)
    XCTAssertEqual("Saturn", result[1]!)
  }

  func testOptionalArrayElementsWithClosure_elementsNull() {
    let p = JsonSwiftson(json: "[" +
      "{ \"planet\": \"Saturn\" }," +
      "{ \"planet\": null}," +
    "]")

    var result: [String?] = p.mapArrayOfObjects(optional: true) { m in
      m["planet"].map(optional: true)
    } ?? ["🐨"]

    XCTAssert(p.ok)
    XCTAssertEqual(2, result.count)
    XCTAssertEqual("Saturn", result[0]!)
    XCTAssert(result[1] == nil)
  }

  // ----- errors -----

  func testError_optionalArrayElementsWithClosure_wrongType() {
    let p = JsonSwiftson(json: "[" +
      "{ \"planet\": \"Saturn\" }," +
      "{ \"planet\": 123}," +
    "]")

    var result: [String?] = p.mapArrayOfObjects(optional: true) { m in
      m["planet"].map(optional: true)
    } ?? ["🐨"]

    XCTAssertFalse(p.ok)
    XCTAssertEqual(1, result.count)
    XCTAssertEqual("🐨", result[0]!)
  }

  func testError_optionalArrayElementsWithClosure_notAnArray() {
    let p = JsonSwiftson(json: "\"not an array\"")

    var result: [String?] = p.mapArrayOfObjects(optional: true) { m in
      m["planet"].map(optional: true)
    } ?? ["🐨"]

    XCTAssertFalse(p.ok)
    XCTAssertEqual(1, result.count)
    XCTAssertEqual("🐨", result[0]!)
  }
}