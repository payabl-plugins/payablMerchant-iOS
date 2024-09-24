# PayabalMerchant

Welcome to the `PayabalMerchant` repository! This repository contains the SDK for integrating Payabal Merchant services into your iOS applications. Whether you're using SwiftUI or UIKit, this guide will help you get started with the integration.

## Table of Contents

- [Installation](#installation)
  - [Swift Package Manager (SPM)](#swift-package-manager-spm)
  - [CocoaPods](#cocoapods)
- [Integration Guide](#integration)
  - [SwiftUI](#swiftui)
  - [UIKit](#uikit)
- [Flow Diagram](#flow-diagram)
- [Contributing](#contributing)
- [License](#license)


## Installation

### Swift Package Manager (SPM)

To install the SDK, follow these steps:
1. In Xcode, select File > Add Packages… and enter https://github.com/payabl-plugins/payablMerchant-iOS as the repository URL.
2. Select the latest version number from our [releases page](https://github.com/payabl-plugins/payablMerchant-iOS/releases)

### CocoaPods

To integrate PayabalMerchant into your Xcode project using CocoaPods, add it to your `Podfile`:

    pod 'PayabalMerchant', '~> 1.0'

Then, run the following command:

    $ pod install


## Integration

### **SwiftUI**

To use PayabalMerchant in a SwiftUI project:

#### 1. Server-side

This integration requires endpoints on your server that talk to the Payabl API. Use our official libraries for access to the Payabl API from your server:

// TODO: Require assistance from BE on how to integrate server to server

#### 2. Add an endpoint

Your app should reach out to your server to start a payment session from payabl server, note that
for security reasons your app can't directly communicate with payabl server.

Payabl server will return 
  - Session id
  - Transaction id
  - Ephemeral key
  
This data should be returned to the mobile client to initate `PayablPaymentPage`


### 3. Import the package in your Swift file:

       import PayabalMerchant

### 4. Integrate Payabl payemnt page 

Example usage:
```
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

       import PayabalMerchant

2. [Add specific instructions for using the main features of PayabalMerchant in UIKit]

Example usage:

    class ViewController: UIViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let payabalMerchantView = PayabalMerchantUIView()
            view.addSubview(payabalMerchantView)
            
            // Set up constraints
        }
    }

## How It Works

[Brief explanation of how PayabalMerchant works]

[Placeholder for detailed flow diagram]

![PayabalMerchant Flow](placeholder_for_flow_diagram.png)

## Additional Features

[List and briefly explain any additional features of PayabalMerchant]

## Troubleshooting

[Common issues and their solutions]

## License

PayabalMerchant is released under the MIT license. See [LICENSE](LICENSE) for details.
