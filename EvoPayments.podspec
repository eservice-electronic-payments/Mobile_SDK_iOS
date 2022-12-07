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
  spec.source_files  = "EvoPayments/EvoPayments/Sources/**/*.swift"
  spec.vendored_frameworks = "EvoPayments/EvoPayments/Sources/Libraries/ipworks3ds_sdk.xcframework"
  spec.swift_version = "5.0"
  spec.info_plist = {
    'WKAppBoundDomains' => [
      'myriadpayments.com',
      'evopaymentgateway.com',
      'boipapaymentgateway.com'
      # 'intelligent-payments.com'
      # 'universalpay.es'
      # 'monetaplatebnisluzby.cz'
      # 'evomexico.mx'
      # 'evosnap.com'
    ]
  }

end
