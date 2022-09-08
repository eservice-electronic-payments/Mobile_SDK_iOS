
# EvoPayments

```markdown
**DEPRECATION WARNING**

Note: We have ended support for iOS 10 and iOS 11.
As from the next release, the minimum supported iOS version will be iOS 12.
```



## Pre-condition

Please note that the call from the Merchant Server to the IPG Gateway API for obtaining an IPG Gateway “Session Token” has been updated. (This update is due to additional data fields mandated by 3DS-Version 2 compliance). It is a prerequisite that the Session Token passed to the Mobile SDK is obtained from that updated Get Session Token API endpoint.

## Integrating the SDK with the Project 

Cocoapods

1. [Install CocoaPods 1.10 or above](https://guides.cocoapods.org/using/getting-started.html)

2. Make sure your version is at least 1.10❗️

    ```bash
    $ pod --version
    ```

3. Create a podfile in your project folder

    ```bash
    $ pod init
    ```

4. Add new pod to your `Podfile`

    ```ruby
    pod 'EvoPayments', :git => 'https://github.com/eservice-electronic-payments/Mobile_SDK_iOS'
    ```
    So your `Podfile` looks as in the example:

    ```ruby
    # Uncomment the next line to define a global platform for your project
    # platform :ios, '9.0'
    
    target 'ProjectName' do
      # Comment the next line if you don't want to use dynamic frameworks
      use_frameworks!
    
      # Pods for ProjectName
      pod 'EvoPayments', :git => 'https://github.com/eservice-electronic-payments/Mobile_SDK_iOS'
    end
    
    ```

5. Install pods in your project folder:

    ```bash
    $ pod install
    ```
    
Manual

1. Clone repository
    ```
    git clone https://github.com/eservice-electronic-payments/Mobile_SDK_iOS.git
    ```

2. Open your iOS project from Xcode. Drag EvoPayments.xcodeproj into Xcode. 

3. Selected Evopayments scheme and build framework.

4. Import EvoPayments start to using SDK.

## Using the SDK

1. Retrieve the Mobile Cashier URL and session token from the IPG Turnkey Gateway API (see Section 1.1 of the IPG Gateway - 2 - AUTH-PURCHASE-VERIFY - Hosted Payment Page document, other API calls are documented similarly) 

    In the example provided in the [iOS Repository](https://github.com/eservice-electronic-payments/iOS_SDK), which can be cloned, a demo session token and Mobile Cashier URL are obtained via the `SessionProvider.swift` class.

    This is an example of the request object:
    ```swift
    struct SessionRequestData {
        let tokenUrl: URL
        let action: String?
        let customerID: String
        let customerFirstName: String?
        let customerLastName: String?
        let amount: Double?
        let currency: String?
        let country: String?
        let language: String?
        let userDevice: String?
        let customerAddressHouseName: String?
        let customerAddressStreet: String?
        let customerAddressCity: String?
        let customerAddressPostalCode: String?
        let customerAddressCountry: String?
        let customerAddressState: String?
        let customerEmail: String?
        let customerPhone: String?

        let additionalParameters: SessionCustomParameter?

        let merchantNotificationUrl: String?
        let merchantLandingPageUrl: String?
        let allowOriginUrl: String?

        let myriadFlowId: String
        //(...)
    ```

    You can add additional parameters by passing an array of parameters to the initializer of `SessionRequestData`:

    ```swift
    let additionalParameters = ["Parameter1","Parameter2"] //create parameters array

    let request = SessionRequestData(
        tokenUrl: content.tokenURL,
        action: action,
        customerID: customerID,
        customerFirstName: customerFirstName,
        customerLastName: customerLastName,
        amount: amount,
        currency: currency,
        country: country,
        language: language,
        userDevice: userDevice,
        customerAddressHouseName: customerAddressHouseName,
        customerAddressStreet: customerAddressStreet,
        customerAddressCity: customerAddressCity,
        customerAddressPostalCode: customerAddressPostalCode,
        customerAddressCountry: customerAddressCountry,
        customerAddressState: customerAddressState,
        customerEmail: customerEmail,
        customerPhone: customerPhone,
        additionalParameters: additionalParameters
    )
    ```

    A full example can be found in `SessionRequestData.swift` of the example app. The response from the server is an `Session` object.

    The merchant must implement a session token and Mobile Cashier URL request mechanism between the merchant server and the iOS app.

2. To display the Webpage via the SDK, after having obtained the `Session`, use either `EVOWebViewController` as a full-screen controller, or `EVOWebView` as a custom view to start Mobile Cashier URL.

    2a. `EVOWebViewController` can be treated as any `UIViewController`, so it can be pushed, presented, etc. You generally want to embed it in a `UINavigationController`. That’s supported out of the box by using:

    ```swift
    let webViewController = EVOWebViewController(session: session) { [weak self] status in
    //Implement your callback to get the payment status
    }
    let navigationController = webViewController.embedInNavigationController()
    navigationController.navigationBar.tintColor = .darkText //Styling
    present(navigationController, animated: true) //present the navigation controller
    ```

    The session will be automatically started in `viewDidLoad` without requiring any action on your behalf.

    2b. `EVOWebView` is a subclass of `UIView`, so it can be used inside any existing `UIViewController`.

    `EVOWebViewController` automatically handles most of the logic needed for the payment process for you, but if you want more control you can embed a `EVOWebView` inside your custom `UIViewController`. 

    Use the `start(session, callback)` function to start the payment process.  

    The first parameter is a `Session` struct. You should create one prior to starting cashier and pass required data in the initializer. 

    ```swift
    struct Session { 
	      let mobileCashierUrl: URL         
	      let token: String         
	      let merchantId: String 
    }
    ```

3. In both cases the callback parameter is a closure. Use it to obtain the `Status` ​enum to learn about the payment-related transaction result.

    ```swift
    enum Status: String {         
          case success = "success"
          case cancelled = "cancel"
          case failed = "failure"
          case timeout = "timeout"
          case undetermined = "undetermined"
          case started = "paymentStarted"            
    }
    ```

    In some cases, the payment process will take more than one step to finish, as with 3DSecure or other authentication methods. This will not need to be handled by your application and it is taken care automatically for you by the framework.

## Good security practices in addition to functions

While using the SDK, `App-Bound Domains` feature should be configured to preserve user privacy by limiting the domains on which an app can utilize powerful APIs to track users during in-app browsing through `WKWebView`. 

*In the example app, for the flexibility to test amongst different cashier URLs that can be retrieved, `App-Bond Domains` was not implemented. However, such control is highly recommended for a production app.*

To configure `App-Bound Domains`:
1. Add the cashier URLs to WKAppBoundDomains in the project `info.plist` file. For example:
```swift
	<key>WKAppBoundDomains</key>
	<array>
		<string>test.secure.eservice.com.pl</string>
		<string>test.myriadpayments.com</string>
	</array>
```

2. Set limitsNavigationsToAppBoundDomains flag in the WKWebView configuration. **This part has already been added to the SDK in `EVOWebView.swift`**:
```swift
	if #available(iOS 14.0, *) {
		config.limitsNavigationsToAppBoundDomains = true
	}
```

Keep in mind that this feature is only available since iOS 14.0 and iPadOS 14.0.

To read more about `App-Bonund Domains` in [here](https://webkit.org/blog/10882/app-bound-domains/).
