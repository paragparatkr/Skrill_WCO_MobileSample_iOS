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
        /// skrillWalletCheckoutURL = This is the URL which is returned in paymentHandles API response (redirect_payment). iOS clients will open this url.
        ///
        /// Please note that you have to pass ``return_url`` parameter in "return_link" in paymenthandles call!!!
        ///
        /// You app should support Universal Links in order to continue with the deeplinking.
        /// More information for Universal links can be found here:
        /// https://developer.apple.com/library/archive/documentation/General/Conceptual/AppSearch/UniversalLinks.html
        /// and better overview for app side support of universal links
        /// https://developer.apple.com/documentation/xcode/supporting-universal-links-in-your-app

        
        let skrillWalletCheckoutURL = "https://api.test.paysafe.com/alternatepayments/v1/redirect?accountId=1001461040&paymentHandleId=c181357e-601b-4b54-b698-f5c4be63ce4a&token=eyJhbGciOiJIUzI1NiJ9.eyJhY2QiOiIxMDAxNDYxMDQwIiwicHlkIjoiYzE4MTM1N2UtNjAxYi00YjU0LWI2OTgtZjVjNGJlNjNjZTRhIiwiZXhwIjoxNjkyMDM3MDI1fQ.rJWmngVyyz37sAxVcCYK934OjCGlDlcdeqiUEeIAfU8"

        guard let url = URL(string: "skrillWalletCheckoutURL") else {
            return
        }

        // Starting Skrill Wallet Checkout in browser.
        UIApplication.shared.open(url)
    }

    func didFinishDeeplinking() {
        /// Method is invoked after deeplink was triggerd
        /// After the execution has return to the module you can continue with the flow
        /// by polling for payment status or keep the current approach.
        ///
        /// In this demo scenario we continue to a success screen after
        /// deeplink has been triggered.
        let successViewController = SuccessViewController()
        present(successViewController, animated: true)
    }
}
