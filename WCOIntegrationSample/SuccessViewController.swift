//
//  SuccessViewController.swift
//  WCOIntegrationSample
//
//  Created by Edis Hasanov on 26.05.23.
//

import UIKit

final class SuccessViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(successLabel)
        NSLayoutConstraint.activate([
            successLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            successLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            successLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private lazy var successLabel: UILabel = {
        let label = UILabel()
        label.text = "Your payment was received and processed successfully. 6$ were added to you balance."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
