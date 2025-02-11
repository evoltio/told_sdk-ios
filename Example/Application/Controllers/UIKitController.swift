//
//  HomeController.swift
//  Told Example
//
//  Created by Jérémy Magnier on 10/01/2025.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import UIKit
import SwiftUI

struct UIKitControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        UINavigationController(
            rootViewController: UIKitController()
        )
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) { }
}

final class UIKitController: UIViewController {
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.isScrollEnabled = true
        view.alwaysBounceVertical = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let buttonChild: UIButton = {
        var configuration: UIButton.Configuration = .bordered()
        configuration.title = "Push Child Controller"
        return .init(configuration: configuration)
    }()

    private let buttonChildDelay: UIButton = {
        var configuration: UIButton.Configuration = .bordered()
        configuration.title = "Push Child Delay Controller"
        return .init(configuration: configuration)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(scrollView)
        view.addConstraints([
            view.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor)
        ])


        buttonChild.addAction(
            UIAction { [weak self] _ in
                let controller: UIViewController = .init()
                controller.view.backgroundColor = .red
                self?.navigationController?.pushViewController(ChildController(), animated: true)
            },
            for: .touchUpInside
        )

        buttonChildDelay.addAction(
            UIAction { [weak self] _ in
                let controller: UIViewController = .init()
                controller.view.backgroundColor = .blue
                self?.navigationController?.pushViewController(ChildDelayController(), animated: true)
            },
            for: .touchUpInside
        )

        let container: UIStackView = .init()
        container.spacing = UIStackView.spacingUseSystem
        container.axis = .vertical
        container.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(container)
        scrollView.addConstraints([
            scrollView.frameLayoutGuide.centerXAnchor.constraint(equalTo: container.centerXAnchor),
        ])

        container.addArrangedSubview(buttonChild)
        container.addArrangedSubview(buttonChildDelay)
    }
}
