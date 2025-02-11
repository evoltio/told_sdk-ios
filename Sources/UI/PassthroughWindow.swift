//
//  PassthroughWindow.swift
//  Told
//
//  Created by Jérémy Magnier on 19/01/2025.
//

import UIKit

final class PassthroughWindow: UIWindow {
    override init(
        windowScene: UIWindowScene
    ) {
        super.init(windowScene: windowScene)
        windowLevel = .alert
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        super.hitTest(point, with: event).flatMap { hitView in
            if #available(iOS 18, *) {
                // iOS 18 breaking change (not looking for child views) see => https://forums.developer.apple.com/forums/thread/762292
                _hitTest(point, from: hitView).flatMap { childView in
                    rootViewController?.view == childView ? nil : hitView
                }
            } else {
                rootViewController?.view == hitView ? nil : hitView
            }
        }
    }

    private func _hitTest(_ point: CGPoint, from view: UIView) -> UIView? {
        let converted = convert(point, to: view)

        guard view.bounds.contains(converted)
                && view.isUserInteractionEnabled
                && !view.isHidden
                && view.alpha > 0
        else { return nil }

        for view in view.subviews.reversed() {
            if let view = _hitTest(point, from: view) {
                return view
            }
        }
        return view
    }
}
