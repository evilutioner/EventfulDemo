//
//  SafariView.swift
//  EventfulDemo
//
//  Created by Oleg Marchik on 1/5/20.
//  Copyright © 2020 Oleg Marchik. All rights reserved.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    typealias UIViewControllerType = CustomSafariViewController

    var url: URL?

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> CustomSafariViewController {
        return CustomSafariViewController()
    }

    func updateUIViewController(_ safariViewController: CustomSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        safariViewController.url = url
    }
}
