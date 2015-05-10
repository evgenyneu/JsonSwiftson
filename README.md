<img src='https://raw.githubusercontent.com/evgenyneu/JsonSwiftson/master/Graphics/GithubLogo/json_swiftson_parser.png' width='256' alt='JsonSwiftson JSON parser for Swift' >

# JSON to Swift mapper

A helper class for parsing JSON text and mapping it to Swift types.

### The goals of this library

* Map JSON text into Swift structures or classes.
* Keep the library [source code](https://github.com/evgenyneu/JsonSwiftson/blob/master/JsonSwiftson/JsonSwiftson.swift) tiny by using Swift generics and taking advantage of type casting features of the language.
* Use just a single method `map()` to handle strings, numbers, booleans and arrays of those types.
* Support casting to optional types.
* Check if the mapping was successful.
* Make sure mapping is fast.
* Use test-driven development approach for writing the library code.


### Example 

The following is an example of serializing JSON into a `Person` structure.

```
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
```

## Setup

#### Add the source file (iOS 7+)

Simply add [JsonSwiftson.swift](https://github.com/evgenyneu/JsonSwiftson/blob/master/JsonSwiftson/JsonSwiftson.swift) file to your Xcode project.

#### Setup with Carthage (iOS 8+)

Alternatively, you can setup it up with Carthage by adding the following line to you Cartfile:

```
github "evgenyneu/JsonSwiftson" ~> 1.0
```

#### Setup with CocoaPods (iOS 8+)

If you are using CocoaPods add this line to your Podfile:

```Podfile
use_frameworks!
pod 'JsonSwiftson', '~> 1.0'
```

## Usage

1. Add `import JsonSwiftson` to your source code if you used Carthage or CocoaPods setup.
1. Create an instance of `JsonSwiftson` class.
1. Call `map` or `mapArrayOfObjects` methods.
1. Optionally, check `ok` property to see if mapping was successful.

### Map simple values

Simple values are strings, numbers and booleans.

```Swift
// String
let stringMapper = JsonSwiftson(json: "\"Hello World\"")
let string: String? = stringMapper.map()

// Integer
let intMapper = JsonSwiftson(json: "123")
let int: Int? = intMapper.map()

// Double
let doubleMapper = JsonSwiftson(json: "123.456")
let double: Double? = doubleMapper.map()

// Boolean
let boolMapper = JsonSwiftson(json: "true")
let bool: Bool? = boolMapper.map()
```

### Map property by name

Use square brackets to reach JSON properties by name: mapper["name"]`.

```Swift
let mapper = JsonSwiftson(json: "{ \"name\": \"Michael\" }")
let name: String? = mapper["name"].map()
```

### Map arrays of simple values

Here is how you can map arrays of strings, numbers and booleans.

```Swift
// String
let stringMapper = JsonSwiftson(json: "[\"One\", \"Two\"]")
let string: [String]? = stringMapper.map()

// Integer
let intMapper = JsonSwiftson(json: "[1, 2]")
let int: [Int]? = intMapper.map()

// Double
let doubleMapper = JsonSwiftson(json: "[1.1, 2.2]")
let double: [Double]? = doubleMapper.map()

// Boolean
let boolMapper = JsonSwiftson(json: "[true, false]")
let bool: [Bool]? = boolMapper.map()
```

### Map an array of objects

Use `mapArrayOfObjects` with a closure to map array of objects.

```Swift
struct Person {
  let name: String
  let age: Int
}

let mapper = JsonSwiftson(json:
  "[ " +
    "{ \"name\": \"Peter\", \"age\": 41 }," +
    "{ \"name\": \"Ted\", \"age\": 51 }" +
  "]")

let value: [Person]? = mapper.mapArrayOfObjects { j in
  Person(
    name: j["name"].map() ?? "",
    age: j["age"].map() ?? 0
  )
}
```

**Tip**: Use `map` method instead of `mapArrayOfObjects` for mapping arrays of simple values like strings, numbers and booleans.

### Mapping to Swift structures

```Swift
struct Person {
  let name: String
  let age: Int
}

let mapper = JsonSwiftson(json: "{ \"name\": \"Peter\", \"age\": 41 }")

let value = Person(
  name: mapper["name"].map() ?? "",
  age: mapper["age"].map() ?? 0
)
```

### Check if mapping was successful

Verify the `ok` property to see if mapping was successful.
Mapping fails for incorrect JSON and type casting problems.

```Swift
let successMapper = JsonSwiftson(json: "\"Correct type\"")
let string: String? = successMapper.map()
successMapper.ok // true

let failMapper = JsonSwiftson(json: "\"Wrong type\"")
let number: Int? = failMapper.map()
failMapper.ok // false
```

**Note**: `map` and `mapArrayOfObjects` methods always return `nil` if mapping fails.

### Allow missing values

Mapping fails by default if JSON value is null or attribute is missing.

**Tip:** Pass `optional: true` parameter to `map` or `mapArrayOfObjects` methods to allow missing values.

```Swift
let mapper = JsonSwiftson(json: "{ }")
let string: String? = mapper["name"].map(optional: true)
mapper.ok // true
```

### Allow missing objects

Use `map` method with `optional: true` parameter and a closure to allow empty objects.

```
struct Person {
  let name: String
  let age: Int
}

let mapper = JsonSwiftson(json: "null") // empty

let value: Person? = mapper.map(optional: true) { j in
  Person(
    name: j["name"].map() ?? "",
    age: j["age"].map() ?? 0
  )
}

mapper.ok // true
```

### Tip: map to a non-optional type

Use `??` operator after the mapper if you need to map to a non-optional type like `let number: Int`.

```Swift
let mapper = JsonSwiftson(json: "123")
let number: Int = mapper.map() ?? 0
```

### Performance benchmark

This demo app is a performance benchmark. It maps a large JSON file containing 100 records. The process is repeated 100 times.

<img src='https://raw.githubusercontent.com/evgenyneu/JsonSwiftson/master/Graphics/json_swiftson_screenshot.png' alt='Json Swiftson performance benchmark' width='320'>

## Alternative solutions

Here are some other popular libraries that can help taming JSON in Swift.

* [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
* [json-swift](https://github.com/owensd/json-swift)
* [Argo](https://github.com/thoughtbot/Argo)
* [JSONJoy-Swift](https://github.com/daltoniam/JSONJoy-Swift)
* [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper)

## Feedback is welcome

If you have a question feel free to create an issue ticket.

