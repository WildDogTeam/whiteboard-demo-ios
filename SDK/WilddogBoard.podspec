Pod::Spec.new do |s|
  s.name                = "WilddogBoard"
  s.version             = "1.0.0"
  s.summary             = "aaaaaaa"
  s.description         = "bbbbbbbbbbbbbbbb"
  s.homepage            = "https://www.wilddog.com/"
  s.license             = { :type => "Copyright", :text => "Copyright 2017 Wilddog" }
  s.authors             = { "Wilddog" => "ceo@wilddog.com" }

  s.platform            = :ios, "8.0"
  s.source              = { :git => "", :tag => "0.0.1" }

  s.vendored_frameworks = "Framework/WilddogBoard.framework"

end
