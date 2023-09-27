//  CustomButton.swift
//  neobis_ios_auth
//  Created by Askar Soronbekov on 28/9/23.

import UIKit

class ToggleButton: UIButton {
    var isToggled: Bool = false {
        didSet {
            updateImage()
        }
    }
    
    private func updateImage() {
        let imageName = isToggled ? "eye" : "eye-disable"
        let image = UIImage(named: imageName)
        setImage(image, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(toggle), for: .touchUpInside)
        updateImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func toggle() {
        isToggled.toggle()
    }
}
