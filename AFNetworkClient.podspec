Pod::Spec.new do |s|
  s.name = "AFNetworkClient"
  s.version = "0.1.0"
  s.summary = "AFNetworkClient mod"
  s.homepage = "https://github.com/diatche/ios-charts-bootstrap"
  s.license = { :type => "Apache License, Version 2.0", :file => "LICENSE" }
  s.authors = "Lucas"
  s.ios.deployment_target = "8.0"
  s.source = { :git => "https://github.com/diatche/ios-charts-bootstrap", :tag => "v0.1.0" }
  s.source_files = "Classes", "AFNetworkClient/**/*.{h,m}"
  s.frameworks = "Foundation", "UIKit", "CoreGraphics"
  s.dependency 'SVProgressHUD', '~> 2.0.3'
  s.dependency 'AFNetworking', '~> 3.0.4'
end