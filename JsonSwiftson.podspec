Pod::Spec.new do |s|
  s.name        = "JsonSwiftson"
  s.version     = "4.0.0"
  s.license     = { :type => "MIT" }
  s.homepage    = "https://github.com/evgenyneu/JsonSwiftson"
  s.summary     = "A JSON parser with concise API written in Swift for iOS, macOS, tvOS and watchOS"
  s.description  =  <<-DESC
                    JsonSwiftson is a JSON parser that exposes just a single API method `map()` for mapping JSON attributes to various Swift types including arrays.

                    * Maps JSON text into Swift structures or classes.
                    * Keeps the library tiny by using Swift generics and taking advantage of type casting features of the language.
                    * Supports casting to optional types.
                    * Indicates if the mapping was successful.
                    * Makes sure mapping is fast.
                    DESC
  s.authors     = { "Evgenii Neumerzhitckii" => "sausageskin@gmail.com" }
  s.source      = { :git => "https://github.com/evgenyneu/JsonSwiftson.git", :tag => s.version }
  s.screenshots  = "https://raw.githubusercontent.com/evgenyneu/JsonSwiftson/master/Graphics/GithubLogo/json_swiftson_parser.png"
  s.source_files = "JsonSwiftson/JsonSwiftson.swift"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
end