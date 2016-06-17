# A JSON parser with concise API written in Swift for iOS, macOS, tvOS and watchOS

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)][carthage]
[![CocoaPods Version](https://img.shields.io/cocoapods/v/JsonSwiftson.svg?style=flat)][cocoadocs]
[![License](https://img.shields.io/cocoapods/l/JsonSwiftson.svg?style=flat)][cocoadocs]
[![Platform](https://img.shields.io/cocoapods/p/JsonSwiftson.svg?style=flat)][cocoadocs]
[cocoadocs]: http://cocoadocs.org/docsets/JsonSwiftson
[carthage]: https://github.com/Carthage/Carthage

JsonSwiftson is a JSON parser that exposes just a single API method `map()` for mapping JSON attributes to Swift types.

<img src='https://raw.githubusercontent.com/evgenyneu/JsonSwiftson/master/Graphics/GithubLogo/json_swiftson_parser.png' width='200' alt='JsonSwiftson JSON parser for Swift'>

* Maps JSON text into Swift structures or classes.
* Keeps the library [source code](https://github.com/evgenyneu/JsonSwiftson/blob/master/JsonSwiftson/JsonSwiftson.swift) tiny by using Swift generics and taking advantage of type casting features of the language.
* Supports casting to optional types.
* Indicates if the mapping was successful.
* Makes sure the mapping is fast.

### Example

The following is an example of mapping a JSON text into a Swift `Person` structure.

```Swift
struct Person {
  let name: String
  let age: Int
}

let mapper = JsonSwiftson(json: "{ \"name\": \"Peter\", \"age\": 41 }")

let person = Person(
  name: mapper["name"].map() ?? "",
  age: mapper["age"].map() ?? 0
)

if !mapper.ok { /* report error */ }
```

## Setup

There are three ways you can add JsonSwiftson into your project.

#### Add the source file (iOS 7+)

Simply add [JsonSwiftson.swift](https://github.com/evgenyneu/JsonSwiftson/blob/master/JsonSwiftson/JsonSwiftson.swift) file to your Xcode project.

#### Setup with Carthage (iOS 8+)

Alternatively, add `github "evgenyneu/JsonSwiftson" ~> 3.0` to your Cartfile and run `carthage update`.

#### Setup with CocoaPods (iOS 8+)

If you are using CocoaPods add this text to your Podfile and run `pod install`.

    use_frameworks!
    target 'Your target name'
    pod 'JsonSwiftson', '~> 3.0'


#### Setup with Swift Package Manager

Add the following text to your Package.swift and run `swift build`.

```Swift
import PackageDescription

let package = Package(
    name: "YourPackageName",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/evgenyneu/JsonSwiftson.git",
                 versions: Version(3,0,0)..<Version(4,0,0))
    ]
)
```


#### Legacy Swift versions

Setup a [previous version](https://github.com/evgenyneu/JsonSwiftson/wiki/Legacy-Swift-versions) of the library if you use an older version of Swift.



## Usage

1) Add `import JsonSwiftson` to your source code if you used Carthage or CocoaPods setup.

2) Create an instance of `JsonSwiftson` class and supply a JSON text for parsing.

```Swift
let mapper = JsonSwiftson(json: "{ \"person\": { \"name\": \"Michael\" }}")
```

3) Supply a JSON attribute name and call the `map` method. The type of the JSON value is inferred from the context.

```Swift
let name: String? = mapper["person"]["name"].map()
```

The example above mapped JSON to an optional type. One can map to a non-optional by using the `??` operator and supplying a default value.

```Swift
let name: String = mapper["person"]["name"].map() ?? "Default name"
```

4) Optionally, check `ok` property to see if mapping was successful.

```Swift
if !mapper.ok { /* report error */ }
```

### Map to simple Swift types

Use the `map` method to parse JSON to types like strings, numbers and booleans.


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

Use square brackets to reach JSON properties by name: `mapper["name"]`.

```Swift
let mapper = JsonSwiftson(json: "{ \"name\": \"Michael\" }")
let name: String? = mapper["name"].map()
```

One can use square brackets more than once to reach deeper JSON properties: `mapper["person"]["name"]`.

```Swift
let mapper = JsonSwiftson(json: "{ \"person\": { \"name\": \"Michael\" }}")
let name: String? = mapper["person"]["name"].map()
```

### Map arrays of simple values

JsonSwiftson will automatically map to the arrays of strings, numbers and booleans.

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

let people: [Person]? = mapper.mapArrayOfObjects { j in
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

let person = Person(
  name: mapper["name"].map() ?? "",
  age: mapper["age"].map() ?? 0
)
```

### Check if mapping was successful

Verify the `ok` property to see if mapping was successful.
Mapping fails for incorrect JSON and type casting problems.

**Note**: `map` and `mapArrayOfObjects` methods always return `nil` if mapping fails.

```Swift
let successMapper = JsonSwiftson(json: "\"Correct type\"")
let string: String? = successMapper.map()
if successMapper.ok { print("👏👏👏") }

let failMapper = JsonSwiftson(json: "\"Wrong type\"")
let number: Int? = failMapper.map()
if !failMapper.ok { print("🐞") }
```

### Allow missing values

Mapping fails by default if JSON value is null or attribute is missing.

**Tip:** Pass `optional: true` parameter to allow missing JSON attributes and null values.

```Swift
let mapper = JsonSwiftson(json: "{ }")
let string: String? = mapper["name"].map(optional: true)
if mapper.ok { print("👏👏👏") }
```

### Allow missing objects

Use `map` method with `optional: true` parameter and a closure to allow empty objects.

```
struct Person {
  let name: String
  let age: Int
}

let mapper = JsonSwiftson(json: "null") // empty

let person: Person? = mapper.map(optional: true) { j in
  Person(
    name: j["name"].map() ?? "",
    age: j["age"].map() ?? 0
  )
}

if mapper.ok { print("👏👏👏") }
```

### Tip: map to a non-optional type

Use `??` operator after the mapper if you need to map to a non-optional type like `let number: Int`.

```Swift
let numberMapper = JsonSwiftson(json: "123")
let number: Int = numberMapper.map() ?? 0

let arrayMapper = JsonSwiftson(json: "[1, 2, 3]")
let numbers: [Int] = arrayMapper.map() ?? []
```

### Performance benchmark

The project includes a demo app that runs performance benchmark. It maps a large JSON file containing 100 records. The process is repeated 100 times.

<img src='https://raw.githubusercontent.com/evgenyneu/JsonSwiftson/master/Graphics/json_swiftson_screenshot.png' alt='Json Swiftson performance benchmark' width='320'>

## Alternative solutions

Here is a list of excellent libraries that can help taming JSON in Swift.

* [Argo](https://github.com/thoughtbot/Argo)
* [json-swift](https://github.com/owensd/json-swift)
* [JSONJoy-Swift](https://github.com/daltoniam/JSONJoy-Swift)
* [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper)
* [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)

## License

JsonSwiftson is released under the [MIT License](LICENSE).
