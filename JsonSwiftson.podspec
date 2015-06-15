Pod::Spec.new do |s|
  s.name        = "JsonSwiftson"
  s.version     = "2.0.3"
  s.license     = { :type => "MIT" }
  s.homepage    = "https://github.com/evgenyneu/JsonSwiftson"
  s.summary     = "Parses JSON and maps it to Swift types."
  s.description  =  <<-DESC
                    JsonSwiftson is a helper class for parsing JSON text and mapping it to Swift types.

                    The goals of this project:

                    * Map JSON text into Swift structures or classes.
                    * Keep the library tiny by using Swift generics and taking advantage of type casting features of the language.
                    * Expose just a single API method `map()` to handle strings, numbers, booleans and arrays of those types.
                    * Support casting to optional types.
                    * Check if the mapping was successful.
                    * Make sure mapping is fast.
                    DESC
  s.authors     = { "Evgenii Neumerzhitckii" => "sausageskin@gmail.com" }
  s.source      = { :git => "https://github.com/evgenyneu/JsonSwiftson.git", :tag => s.version }
  s.screenshots  = "https://raw.githubusercontent.com/evgenyneu/JsonSwiftson/master/Graphics/GithubLogo/json_swiftson_parser.png"
  s.source_files = "JsonSwiftson/JsonSwiftson.swift"
  s.ios.deployment_target = "8.0"
end