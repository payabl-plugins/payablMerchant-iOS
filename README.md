# payabl. iOS SDK

Welcome to our repository! It contains our iOS SDK for integrating into your iOS app. Supporting both SwiftUI and UIKit with our guide that will help you to get started with integration of our SDK into you app in no time!

## Table of Contents
- [Integration Workflow](#integration-workflow)
- [Installation](#installation)
  - [Swift Package Manager (SPM)](#swift-package-manager-spm)
- [Integration Guide](#integration)
  - [SwiftUI](#swiftui)
  - [UIKit](#uikit)
- [License](#license)

## Integration Workflow

![image](https://github.com/user-attachments/assets/79b06a1c-f032-4ae6-9a39-0afcaf75a8f9)

## Installation

### Swift Package Manager (SPM)

To install the SDK, follow these steps:
1. In Xcode, select File > Add Packages… and enter https://github.com/payabl-plugins/payablMerchant-iOS as the repository URL
2. Select the latest version number from our [releases page](https://github.com/payabl-plugins/payablMerchant-iOS/releases)

## Integration

#### 1. Merchant Server

This integration requires setting up your server to be able to call our mobile SDK backend API. Refer to the [Setup Server](https://docs.payabl.com/docs/setup-your-server) page of our Mobile SDK integration documentation.

#### 2. Add an endpoint

Your app should reach out to your server to start a payment session from payabl server, note that
for security reasons your app can't directly communicate with payabl server.

Payabl server will return 
  - `session_id`
  - `ephemeral_key`
  - `transaction_id`
  
This data should be returned to the mobile client to initate `PayablPaymentPage`

### 3. Import the package in your Swift file:

```swift
    import PayabalMerchant
```

### **SwiftUI**
To use PayabalMerchant in a SwiftUI project:

### Integrate a payemnt page 

Example usage:
```swift
    class DemoCartViewModel: ObservableObject {
      @Published var paymentPage: PBLPaymentPage?
      let backendCheckoutUrl = = URL(string: "backend_endpoint/payment_page")!

      func preparePaymentPage() {
        var request = URLRequest(url: backendCheckoutUrl)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
        guard let data = data,
              let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
        else { return }
        let sessionId = json["sessionId"]
        let transactionId = json["transactionId"]
        let ephemeralKey = json["empheralKey"]
        let merchantId = json["merchantId"]
        
        
        let config = PBLConfiguration(
          sessionId: sessionId,
          transactionId: transactionId,
          ephemeralKey: ephemeralKey,
          merchantId: merchantId,
          customerId: currentUser.shared.email, // any customer identifer can work
          environment: .sandbox
        )
        self.paymentPage = PBLPaymentPage(configuration: config)
      }
    }
    
    func didFinishCheckout(result: PBLPaymentResult) {
      switch result {
      case .canceled:
        print("Client has canceled the checkout proccess")
      case .completed:
        print("Client has successfuly completed checkout")
      case .failed(let error):
        print("Failed due to: ", error.localizedDescription)
      default:
        fatalError()
      }
    }
  }
  
  struct ContentView: View {
    let demoCartViewModel = DemoCartViewModel()
    var body: some View {
        VStack {
          PBLPaymentButton(paymentPage: demo.paymentPage) { result in
            demoCartViewModel.didFinishCheckout(result: result)
          } content: {
            Text("Checkout")
              .padding()
          }
        }
        .foregroundStyle(.white)
        .background(.black)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding()
        .onAppear { demoCartViewModel.preparePaymentPage() }
    }
  }
```
### **UIKit**

To use PayabalMerchant in a UIKit project:

1. Import the package in your Swift file:

```swift
   import PayabalMerchant
```

Example usage:

```swift
    class ViewController: UIViewController {
        let pblPaymentPage: PBLPaymentPage?
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let checkoutButton = UIButton(type: .system)
            checkoutButton.setTitle("Checkout", for: .normal)
            checkoutButton.setTitleColor(.white, for: .normal)
            checkoutButton.backgroundColor = .blue
            checkoutButton.layer.cornerRadius = 8
            checkoutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)

            checkoutButton.frame = CGRect(x: 50, y: 200, width: 200, height: 50)
            
            self.view.addSubview(checkoutButton)
            
            checkoutButton.addTarget(self, action: #selector(payableOrder), for: .touchUpInside)
        }

        @objc func payableOrder() {
            var request = URLRequest(url: backendCheckoutUrl)
            request.httpMethod = "POST"
            let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            else { return }
            let sessionId = json["sessionId"]
            let transactionId = json["transactionId"]
            let ephemeralKey = json["empheralKey"]
            let merchantId = json["merchantId"]
            
            
            let config = PBLConfiguration(
              sessionId: sessionId,
              transactionId: transactionId,
              ephemeralKey: ephemeralKey,
              merchantId: merchantId,
              customerId: currentUser.shared.email, // any customer identifer can work
              environment: .sandbox
            )
            pblPaymentPage = PBLPaymentPage(configuration: config)
            pblPaymentPage.present(from: self) { status in
            switch status {
              case .canceled:
                print("Client has canceled the checkout proccess")
              case .completed:
                print("Client has successfuly completed checkout")
              case .failed(let error):
                print("Failed due to: ", error.localizedDescription)
              default:
                fatalError()
              }
            }
        }
    }
```
## Additional Features
- **Apple Pay**: check our [Apple Pay related API documentation](https://docs.payabl.com/docs/ios-apple-pay) for details on how to configure Apple Pay for your app.
- **3-D Secure 2.x**: Enhanced security to reduce fraud and chargebacks
- **Interface Customization:** supports dark and light modes
- **Save Card** - Save cards for the future payments (up to four cards)

## Troubleshooting
Please refer to our API documentation [troubleshooting page](https://docs.payabl.com/docs/error-handling-troubleshooting-guidelines).

## License
PayabalMerchant is released under the MIT license. See [license](LICENSE) for details.
