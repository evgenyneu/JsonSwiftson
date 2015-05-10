//
// Map JSON to Swift types.
//
// Example:
// -------
//
//   let j = JsonSwiftson(json: "{ \"name\": \"Peter\" }")
//   let name: String = j["name"].map() ?? ""
//   if !j.ok { /* report failure */ }
//

import Foundation

public final class JsonSwiftson {
  // Contains the result or mapping. If false - mapping has failed.
  public var ok = true

  private var parsedRawValue: AnyObject?
  private let parent: JsonSwiftson?

  public init(json: String) {
    self.parent = nil
    parsedRawValue = JsonSwiftson.parseRaw(json)
  }

  private init(anyObject: AnyObject?, parent: JsonSwiftson) {
    self.parent = parent
    parsedRawValue = anyObject
  }

  //
  // Map JSON value to a string, number, boolean, null or an array.
  // Use optional `withClosure` parameter to map it to an optional Swift structure.
  //
  // Arguments
  // ----------
  //
  // optional
  //
  //    When optional is true the mapping is successful even when JSON value is null.
  //
  // withClosure
  //
  //    Supplying a closure is useful together with `optional: true` parameter.
  //    That allows mapping JSON to an optional Swift structure.
  //
  public func map<T>(optional: Bool = false,
    withClosure closure: ((JsonSwiftson)->(T?))? = nil) -> T? {

    if optional && parsedRawValue is NSNull {
      // Value can be optional
      return nil
    }

    if let currentClosure = closure {
      let result = currentClosure(self)
      if !ok { return nil }
      return result
    } else {
      if let currentValue = parsedRawValue as? T {
        return currentValue
      }
    }

    // Parsing error
    reportError()
    return nil
  }

  //
  // Map JSON value to an array supplying the closure for its elements.
  //
  // Arguments
  // ----------
  //
  // optional
  //
  //    When optional is true the mapping is successful even when JSON value is null.
  //
  // withClosure
  //
  //    Supply mapping closure for array elements.
  //
  public func mapArrayOfObjects<T: CollectionType>(optional: Bool = false,
    withClosure closure: (JsonSwiftson)->(T.Generator.Element)) -> T? {

    if optional && parsedRawValue is NSNull {
      // Value can be optional
      return nil
    }

    if let items = parsedRawValue as? NSArray {
      var parsedItems = Array<T.Generator.Element>()

      for item in items {
        let itemMapper = JsonSwiftson(anyObject: item, parent: self)
        let itemMappingResult = closure(itemMapper)
        if !ok { return nil }
        parsedItems.append(itemMappingResult)
      }
      
      return parsedItems as? T
    } else {
      // Not an array
      reportError()
      return nil
    }
  }

  //
  // Parses string into AnyObject.
  // This function is used internally during initialization.
  //
  // Return value:
  //
  //  Returns an object that can be converted to a Swift type.
  //  Returns nil if parsing failed.
  //  Note: null JSON values are parsed as NSNull objects and not as nil values.
  //
  public static func parseRaw(json: String) -> AnyObject? {

    let encoded = json.dataUsingEncoding(NSUTF8StringEncoding)

    if let currentEncoded = encoded {
      var error: NSError?

      let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(currentEncoded,
        options: NSJSONReadingOptions.AllowFragments,
        error: &error)

      if error != nil { return nil } // parsing error

      return parsedObject
    }

    return nil // dataUsingEncoding failed
  }

  // Returns a new parser for the attribute
  public subscript(name: String) -> JsonSwiftson {
    if let currentDict = parsedRawValue as? NSDictionary {
      if let currentValue: AnyObject = currentDict[name] as AnyObject? {
        // Value exists in the property
        return JsonSwiftson(anyObject: currentValue, parent: self)
      } else {
        // Property does not exist
        return JsonSwiftson(anyObject: NSNull(), parent: self)
      }
    } else {
      // Parent JSON is not an object
      reportError()
      return JsonSwiftson(json: "")
    }
  }

  private func reportError() {
    if let currentParent = parent {
      currentParent.reportError()
    }

    ok = false
  }
}
