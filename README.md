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

To integrate PayabalMerchant into your Xcode project using SPM, add it to the dependencies value of your `Package.swift`:

    dependencies: [
        .package(url: "https://github.com/yourusername/PayabalMerchant.git", .upToNextMajor(from: "1.0.0"))
    ]

### CocoaPods

To integrate PayabalMerchant into your Xcode project using CocoaPods, add it to your `Podfile`:

    pod 'PayabalMerchant', '~> 1.0'

Then, run the following command:

    $ pod install

## Integration

<!-- tabs:start -->
#### **SwiftUI**

To use PayabalMerchant in a SwiftUI project:

1. Import the package in your Swift file:

       import PayabalMerchant

2. [Add specific instructions for using the main features of PayabalMerchant in SwiftUI]

Example usage:

    class DemoCartViewModel: ObservableObject {
      @Published var paymentPage: PBLPaymentPage
  
      init() {
        let config = PBLConfiguration(
        sessionId: "fa5cc7f8eab3fb8692132bd9fdebf504dd951db5",
        transactionId: "215509341",
        ephemeralKey: "key",
        merchantId: "mselsoudany",
        customerId: "user@mail.com",
        environment: .sandbox
      )
      self.paymentPage = PBLPaymentPage(configuration: config)
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
    }
  }

#### **UIKit**

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
<!-- tabs:end -->

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
