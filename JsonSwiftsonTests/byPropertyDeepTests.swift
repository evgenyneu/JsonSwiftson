//
//  Get new mapper by JSON property.
//  It allows us to map property values.
//
//  Example
//  -------
//
//    { "fairy": { "tale" : "✨"} }
//
//

import UIKit
import XCTest
import JsonSwiftson

class byPropertyDeepTests: XCTestCase {
  
  func testProperty() {
    let p = JsonSwiftson(json: "{ \"fairy\": { \"tale\" : \"✨\"} }")
    
    let subP = p["fairy"]["tale"]
    let result: String = subP.map() ?? ""
    
    XCTAssert(p.ok)
    XCTAssert(subP.ok)
    
    XCTAssertEqual("✨", result)
  }

}
