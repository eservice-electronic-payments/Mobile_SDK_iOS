Pod::Spec.new do |spec|
  spec.name         = "EvoPayments"
  spec.version      = "2.1.5"
  spec.summary      = "A library to easily integrate EvoPayments to your iOS app."

  spec.description  = <<-DESC
  A library to easily integrate EvoPayments to your iOS app.
  See README.md for more information.
                   DESC

  spec.homepage     = "https://github.com/eservice-electronic-payments/Mobile_SDK_iOS"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = "Intelligent Payments Ltd."
  spec.platform     = :ios, "14.0"
  spec.source       = { :git => "https://github.com/eservice-electronic-payments/Mobile_SDK_iOS", :tag => "2.0" }
  spec.source_files  = "EvoPayments/EvoPayments/Sources/**/*.swift", "EvoPayments/EvoPayments/Sources/*.plist"
   # spec.source_files  = "EvoPayments/EvoPayments/Sources/*.{swift,plist}"
  spec.vendored_frameworks = "EvoPayments/EvoPayments/Sources/Libraries/ipworks3ds_sdk.xcframework"
  spec.swift_version = "5.0"
  # spec.resources = 'Info.plist'
  spec.pod_target_xcconfig = { 'INFOPLIST_FILE' => '${PODS_TARGET_SRCROOT}/Sources/Info.plist' }

end
