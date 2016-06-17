import Foundation

/**

A JSON mapper for Swift. It allows to parse JSON text and map it to Swift classes and structures.

    struct Person {
      let name: String
      let age: Int
    }

    let j = JsonSwiftson(json: "{ \"name\": \"Peter\", \"age\": 41 }")

    let person = Person(
      name: j["name"].map() ?? "",
      age: j["age"].map() ?? 0
    )

    if !j.ok { /* report error */ }

*/
public final class JsonSwiftson {
  
  /**

  Indicates if the mapping was successful.
  `map` and `mapArrayOfObjects` methods return `nil` in case of error.

  */
  public var ok = true

  /**
  
  Initialize a new mapper.
  
  - parameter json:  Provide text in JSON format.
  
  */
  public init(json: String) {
    self.parent = nil
    parsedRawValue = JsonSwiftson.parseRaw(json)
  }

  
  /**
  
  Map JSON value to a string, number, boolean, null or an array.
  Use optional `withClosure` parameter to map it to an optional Swift structure.

  - parameter optional: When `true` the mapping is considered successful even when JSON value is null.
  - parameter withClosure: Supplying a closure is useful together with `optional: true` parameter. It allows mapping JSON to an optional Swift structure.
  - returns: A value from JSON.
  
  */
  public func map<T>(optional: Bool = false,
    withClosure closure: ((JsonSwiftson)->(T?))? = nil) -> T? {

    if optional && parsedRawValue is NSNull {
      return nil // Value can be optional
    }

    if let closure = closure {
      
      let result = closure(self)
      if !ok { return nil }
      return result
      
    } else {
      if let value = parsedRawValue as? T {
        return value
      }
    }

    // Mapping has failed
    reportError()
    return nil
  }

  /**
  
  Map JSON value to an array of objects supplying the closure for its elements.

  Tip: use `map` method instead of `mapArrayOfObjects` for mapping arrays of simple values
  like strings, numbers and booleans.

  - parameter optional:  When optional is `true` the mapping is successful even when JSON value is null.
  - parameter withClosure: Supply mapping closure for array elements.
  - returns: A value from JSON.
  
  */
  public func mapArrayOfObjects<T: Collection>(optional: Bool = false,
    withClosure closure: (JsonSwiftson)->(T.Iterator.Element)) -> T? {

    if optional && parsedRawValue is NSNull {
      return nil // Value can be optional
    }

    if let items = parsedRawValue as? NSArray {
      
      var parsedItems = Array<T.Iterator.Element>()

      for item in items {
        let itemMapper = JsonSwiftson(anyObject: item, parent: self)
        let itemMappingResult = closure(itemMapper)
        if !ok { return nil }
        parsedItems.append(itemMappingResult)
      }
      
      return parsedItems as? T
      
    } else {
      // Error - value is not an array
      reportError()
      return nil
    }
  }
  
  /**
  
  Return a new parser for JSON attribute.
  
  */
  public subscript(name: String) -> JsonSwiftson {
    if let dictionary = parsedRawValue as? NSDictionary {
      
      if let value = dictionary[name] {
        
        // Property does exist in the dictionary
        return JsonSwiftson(anyObject: value, parent: self)
        
      } else {
        
        // Property does NOT exist
        return JsonSwiftson(anyObject: NSNull(), parent: self)
        
      }
      
    } else {
      
      // Failed to cast JSON to dictionary
      reportError()
      return JsonSwiftson(json: "")
      
    }
  }
  
  // MARK: - Internal functionality

  private var parsedRawValue: AnyObject?
  private let parent: JsonSwiftson?
  
  private init(anyObject: AnyObject?, parent: JsonSwiftson) {
    self.parent = parent
    parsedRawValue = anyObject
  }

  
  /**

  Parse JSON text into AnyObject. This function is used internally during initialization.
  Null JSON values are parsed as NSNull objects and not as nil values.

  - returns: An object that can be a Dictionary, Arrays, String, numeric type, boolean or NSNull. Returns nil if parsing failed.
  
  */
  static func parseRaw(_ json: String) -> AnyObject? {
    if let encoded = json.data(using: String.Encoding.utf8) {
      do {
        return try JSONSerialization.jsonObject(with: encoded,
          options: JSONSerialization.ReadingOptions.allowFragments)
      } catch _ {}
    }

    return nil // failed to convert text to NSData
  }

  private func reportError() {
    parent?.reportError()
    ok = false
  }
}
