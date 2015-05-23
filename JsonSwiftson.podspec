Pod::Spec.new do |s|
  s.name        = "JsonSwiftson"
  s.version     = "1.0.6"
  s.license     = { :type => "MIT" }
  s.homepage    = "https://github.com/evgenyneu/JsonSwiftson"
  s.summary     = "Parses JSON and maps it to Swift types."
  s.authors     = { "Evgenii Neumerzhitckii" => "sausageskin@gmail.com" }
  s.source      = { :git => "https://github.com/evgenyneu/JsonSwiftson.git", :tag => s.version }
  s.screenshots  = "https://raw.githubusercontent.com/evgenyneu/moa/master/Graphics/Hunting_Moa.jpg"
  s.source_files = "JsonSwiftson/JsonSwiftson.swift"
  s.ios.deployment_target = "8.0"
end