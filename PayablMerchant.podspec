Pod::Spec.new do |s|
    s.name             = 'PayablMerchant'
    s.version          = '0.0.1'
    s.summary          = 'Easy secure online payments'
    s.description      = <<-DESC
    Use `PayablMerchant` framework for easy secure online payment integration for your iOS apps.
    DESC
    s.homepage         = 'https://github.com/yourusername/PayablMerchant'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Your Name' => 'your.email@example.com' }
    s.source           = { :git => 'https://github.com/yourusername/PayablMerchant.git', :tag => s.version.to_s }
    s.ios.deployment_target = '16.0'
    s.vendored_frameworks = 'PayablMerchant.xcframework'
    s.swift_version = '5.3'
  end