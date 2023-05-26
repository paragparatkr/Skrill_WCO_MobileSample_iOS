//
//  PaymentViewController.swift
//  WCOIntegrationSample
//
//  Created by Edis Hasanov on 19.05.23.
//

import SafariServices
import UIKit

final class PaymentViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(paymentButton)
        NSLayoutConstraint.activate([
            paymentButton.heightAnchor.constraint(equalToConstant: 45),
            paymentButton.widthAnchor.constraint(equalToConstant: 100),
            paymentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paymentButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private lazy var paymentButton: UIButton = {
        let button = UIButton()
        button.setTitle("Pay", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.titleLabel?.tintColor = .white
        return button
    }()

    @objc private func didTapButton() {
        /// This is the URL that iOS clients are opening after sending request to Skrill Wallet Checkout.
        /// It could either contain query parameters or session ID.
        ///
        /// !!! Please note that now you have to pass ``return_url`` parameter. !!!
        ///
        /// You app should support Universal Links in order to continue with the deeplinking.
        /// More information for Universal links can be found here:
        /// https://developer.apple.com/library/archive/documentation/General/Conceptual/AppSearch/UniversalLinks.html
        /// and better overview for app side support of universal links
        /// https://developer.apple.com/documentation/xcode/supporting-universal-links-in-your-app

        /// You might be receiving the link with a Session ID. It's still a valid approach as long as
        /// ``return_url`` parameter is passed to the request that returns Skrill Wallet Checkout session ID
        let skrillWalletCheckoutURL = "https://pay.eu-qa.sandbox.dw-cloud.net/"
        let merchantID = "merchant_id=1"
        let amount = "amount=1"
        let currency = "currency=USD"
        let prefilledEmail = "pay_from_email=your.customers.email@mail.com"
        let paymentMethod = "payment_methods=WLT"
        let returnURL = "return_url=\(Constant.skrillWalletCheckoutDeeplinkURL)"
        let queryParameters = "?\(merchantID)&\(amount)&\(currency)&\(prefilledEmail)&\(paymentMethod)&\(returnURL)"

        guard let url = URL(string: "\(skrillWalletCheckoutURL)\(queryParameters)") else {
            return
        }

        // Starting Skrill Wallet Checkout in browser.
        UIApplication.shared.open(url)
    }

    func didFinishDeeplinking() {
        /// Method is invoked after deeplink passed to Skrill Wallet Checkout was triggerd
        /// After the execution has return to the module you can continue with the flow
        /// by polling for payment status or keep the current approach.
        ///
        /// In this demo scenario we continue to a success screen after
        /// deeplink has been triggered.
        let successViewController = SuccessViewController()
        present(successViewController, animated: true)
    }
}
