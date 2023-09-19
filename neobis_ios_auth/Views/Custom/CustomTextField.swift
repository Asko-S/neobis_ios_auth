//  Custom.swift
//  neobis_ios_auth
//  Created by Askar Soronbekov

import Foundation
import UIKit
import SnapKit

class CustomTextField: UITextField {
    
    var floatingLabel: UILabel = UILabel()
    var defaultPlaceholderColor: UIColor = UIColor.lightGray

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    func commonInit() {
        self.autocapitalizationType = .none
        floatingLabel.textColor = defaultPlaceholderColor
        floatingLabel.font = UIFont(name: "GothamPro-Medium", size: 16)
        addSubview(floatingLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.attributedPlaceholder = nil
        if floatingLabel.superview == nil {
            addSubview(floatingLabel)
        }
        if isFirstResponder || !(text?.isEmpty ?? true) {
            floatingLabel.frame = CGRect(x: 8, y: 0, width: bounds.width, height: 16)
            floatingLabel.textColor = defaultPlaceholderColor
            floatingLabel.font = UIFont(name: "GothamPro-Medium", size: 12)
        } else {
            floatingLabel.frame = CGRect(x: 8, y: 0, width: bounds.width, height: bounds.height)
            floatingLabel.textColor = defaultPlaceholderColor
            floatingLabel.font = UIFont(name: "GothamPro-Medium", size: 16)

        }

    }

    override var placeholder: String? {
        didSet {
            floatingLabel.text = placeholder
        }
    }

    override var text: String? {
        didSet {
            layoutSubviews()
        }
    }

    override func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        UIView.animate(withDuration: 0.3) {
            self.layoutSubviews()
        }
        return result
    }

    override func resignFirstResponder() -> Bool {
        let result = super.resignFirstResponder()
        UIView.animate(withDuration: 0.3) {
            self.layoutSubviews()
        }
        return result
    }
}

