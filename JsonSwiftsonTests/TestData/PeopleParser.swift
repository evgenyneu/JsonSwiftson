import Foundation
import JsonSwiftson

public class PeopleParser {
  public class func parse(json: String) -> [Person] {
    let j = JsonSwiftson(json: json)

    let result:[Person] = j.mapArrayOfObjects { j in
      Person(
        id: j["id"].map() ?? 0,
        name: j["name"].map() ?? "",
        age: j["age"].map() ?? 0,
        latitude: j["latitude"].map() ?? 0,
        longitude: j["longitude"].map() ?? 0,
        tags: j["tags"].map() ?? [],
        friends: j["friends"].mapArrayOfObjects { j in
          Friend(
            id: j["id"].map() ?? 0,
            name: j["name"].map() ?? ""
          )
        } ?? []
      )
    } ?? []

    if !j.ok { return [] }

    return result
  }
}
