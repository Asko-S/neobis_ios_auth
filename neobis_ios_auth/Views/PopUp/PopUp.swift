//
//  PopUp.swift
//  neobis_ios_auth
//
//  Created by Askar Soronbekov 
//

import Foundation
import UIKit
import SnapKit

class PopupView: UIPresentationController {
    let dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        return view
    }()

    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        dimmingView.frame = containerView.bounds
        containerView.insertSubview(dimmingView, at: 0)

        dimmingView.alpha = 0
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate { _ in
                self.dimmingView.alpha = 1
            }
        }
    }

    override func dismissalTransitionWillBegin() {
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate { _ in
                self.dimmingView.alpha = 0
            }
        }
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        let size = CGSize(width: containerView.bounds.width * 0.75, height: containerView.bounds.height * 0.5)
        let origin = CGPoint(x: (containerView.bounds.width - size.width) / 2, y: (containerView.bounds.height - size.height) / 2)
        return CGRect(origin: origin, size: size)
    }
}

