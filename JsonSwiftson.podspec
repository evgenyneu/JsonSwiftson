Pod::Spec.new do |s|
  s.name        = "JsonSwiftson"
  s.version     = "1.0.1"
  s.license     = { :type => "MIT" }
  s.homepage    = "https://github.com/evgenyneu/JsonSwiftson"
  s.summary     = "Parses JSON and maps it to Swift types."
  s.authors     = { "Evgenii Neumerzhitckii" => "sausageskin@gmail.com" }
  s.source      = { :git => "https://github.com/evgenyneu/JsonSwiftson.git", :tag => "v1.0.0"}
  s.source_files = "JsonSwiftson/JsonSwiftson.swift"
  s.ios.deployment_target = "8.0"
end