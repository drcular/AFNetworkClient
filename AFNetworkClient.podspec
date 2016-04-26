Pod::Spec.new do |s|
  s.name = "AFNetworkClient"
  s.version = "0.1.1"
  s.summary = "AFNetworkClient mod"
  s.homepage = "https://github.com/drcular/AFNetworkClient.git"
  s.license = { :type => "Apache License, Version 2.0", :file => "LICENSE" }
  s.authors = "Lucas"
  s.ios.deployment_target = "8.0"
  s.source = { :git => "https://github.com/drcular/AFNetworkClient.git", :tag => "v0.1.1" }
  s.source_files = "AFNetworkClient/**/*.{h,m}"
  s.frameworks = "Foundation", "UIKit", "CoreGraphics"
  s.dependency 'SVProgressHUD', '~> 2.0.3'
  s.dependency 'AFNetworking', '~> 3.0.4'
end