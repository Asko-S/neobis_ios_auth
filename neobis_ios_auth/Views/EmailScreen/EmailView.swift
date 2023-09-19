//
//  EmailView.swift
//  neobis_ios_auth
//
//  Created by Askar Soronbekov 
//

import Foundation
import UIKit
import SnapKit

class EmailView : UIView, UITextFieldDelegate {
    
    let smileImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "smile")
        
        return image
    }()
    
    let messageLabel : UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "Смейся\nи улыбайся\nкаждый день")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        label.attributedText = attributedText
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor(red: 93/255, green: 95/255, blue: 249/255, alpha: 1.0)
        label.font = UIFont(name: "GothamPro-Medium", size: 40)
        
        return label
    }()
    
    let loginField : CustomTextField = {
        let field = CustomTextField()
        field.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
        field.placeholder = "Электронная почта"
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        field.leftView = leftView
        field.leftViewMode = .always
        field.layer.cornerRadius = 8
        field.returnKeyType = .search
        return field
    }()
    
    let enterButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
        button.layer.cornerRadius = 16
        let buttonTitle = "Далее"
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(UIColor(red: 156/255, green: 164/255, blue: 171/255, alpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        
        button.contentVerticalAlignment = .center
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loginField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = .white
        
        setupView()
        setupConstraints()
    }
    
    @objc func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }
    
    func setupView() {
        addSubview(messageLabel)
        addSubview(smileImage)
        addSubview(loginField)
        addSubview(enterButton)
    }
    
    func setupConstraints() {
        messageLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height * 116 / 812)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width * 335 / 375)
            make.height.equalTo(UIScreen.main.bounds.height * 144 / 812)
        }
        
        smileImage.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 101 / 812)
            make.trailing.equalToSuperview().inset(UIScreen.main.bounds.width * 20 / 375)
            make.height.equalTo(UIScreen.main.bounds.height * 80 / 812)
            make.width.equalTo(UIScreen.main.bounds.height * 80 / 812)
        }
        
        loginField.snp.makeConstraints{ make in
            make.top.equalTo(messageLabel.snp.bottom).offset(UIScreen.main.bounds.height * 60 / 812)
            make.centerX.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 60 / 812)
            make.width.equalTo(UIScreen.main.bounds.width * 335 / 375)
        }
        
        enterButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 440 / 812)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width * 335 / 375)
            make.height.equalTo(UIScreen.main.bounds.height * 65 / 812)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if updatedText.contains("@") {
            enterButton.backgroundColor = UIColor(red: 93/255, green: 95/255, blue: 249/255, alpha: 1.0)
            enterButton.setTitleColor(UIColor.white, for: .normal)
        } else {
            enterButton.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
            enterButton.setTitleColor(UIColor(red: 156/255, green: 164/255, blue: 171/255, alpha: 1.0), for: .normal)
        }
        
        return true
    }

}

