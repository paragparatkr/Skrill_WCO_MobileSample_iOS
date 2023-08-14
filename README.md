Sample iOS project aiming to provide guidelines for Skrill Payment Method integration via Payments API.

# Overview
On September 30, the US bank Chase stops supporting in-process webview traffic. his topic raises the need for updated Skrill payment method integration guidelines for mobile applications.

Our recommendation is to start Skrill in an Out of process via browser. An essential part of being able to keep a good UX is to be able to redirect the customer from the browser back to the merchant's app once the payment is completed.

In order to keep the good UX the merchant app have to initialize Skrill Checkout with ``return_url`` which on the other hand should be registered in the app as Universal Link and Associated Domain. This means that when the payment is made and the browser loads the return_url then the app will be able to intercept that url and get back to foreground again.

**Technical guidelines**: Skrill redirect_payment url should be loaded in a browser (out-of-process).Universal Link and Associated domain should be registered in the application. Host a json file on your domain on this particular URL https://<fully qualified domain>/.well-known/apple-app-site-association with appLinks components describing the deeplinking points to your app.More information in Apple's documentation: https://developer.apple.com/documentation/xcode/supporting-associated-domains. Implement your deeplinking logic in your app's AppDelegate file. https://developer.apple.com/documentation/xcode/supporting-universal-links-in-your-app https://developer.apple.com/library/archive/documentation/General/Conceptual/AppSearch/UniversalLinks.html
  
# About this sample
This sample project is to be used as a guide only. It cannot be ran and tested since the app doesnt have a hosted domain and since it does not have app ID to include in apple-app-site-association json. 
  Key points in the Sample projects are the deeplink method from AppDelegate.swift, opening the Safari browser from the didTapButton method of PaymentViewController.swift and the didFinishDeeplinking method from PaymentViewController.swift.
