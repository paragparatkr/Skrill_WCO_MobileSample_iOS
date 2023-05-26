//
//  AppDelegate.swift
//  WCOIntegrationSample
//
//  Created by Edis Hasanov on 19.05.23.
//

import UIKit

enum Constant {
    static let skrillWalletCheckoutDeeplinkURL = "https://yourappname.com/app/skrill_wallet_checkout"
}

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    weak var viewController: PaymentViewController?

    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let rootViewController = PaymentViewController()
        viewController = rootViewController

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()

        return true
    }

    func application(_: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler _: ([UIUserActivityRestoring]?) -> Void) -> Bool {
        /// Deeplink handling.
        /// Make sure to add Associated Domains to your target’s Signing & Capabilities tab.
        /// More on how to add Associated Domains can be found here.
        /// https://developer.apple.com/documentation/xcode/supporting-associated-domains
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
              let url = userActivity.webpageURL else {
            return false
        }
        /// You can introduce different mechanisms for matching received deeplink.
        /// In this case we are only interested  in Skrill Wallet Checkout deeplink.
        if url.absoluteString.hasPrefix(Constant.skrillWalletCheckoutDeeplinkURL) {
            /// Once deeplink is received we need to notify the responsible class to continue it's execution.
            viewController?.didFinishDeeplinking()
            return true
        } else {
            return false
        }
    }
}
