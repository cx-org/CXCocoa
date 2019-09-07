Pod::Spec.new do |s|

    s.name         = "CXCocoa"
    s.version      = "0.0.1-beta.1"
    s.summary      = "Cocoa extensions built on top of CombineX"
    s.homepage     = "https://github.com/cx-org/CXCocoa"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = { "Quentin Jin" => "luoxiustm@gmail.com" }

    s.swift_versions              = ['5.0']
    s.osx.deployment_target       = "10.12"
    s.ios.deployment_target       = "10.0"
    s.tvos.deployment_target      = "10.0"
    s.watchos.deployment_target   = "3.0"

    s.source = { :git => "https://github.com/cx-org/CXCocoa.git", :tag => "#{s.version}" }
    s.source_files  = "Sources/Shared/**/*.{swift,h,m}"
    s.ios.source_files = "Sources/UIKit/**/*.swift"

    s.dependency 'CXFoundation', '~> 0.0.1-beta.3'
  
end
