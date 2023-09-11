//  LoginView.swift
//  neobis_ios_auth
//  Created by Askar Soronbekov

import Foundation
import UIKit
import SnapKit

class LoginScreenView : UIView, UITextFieldDelegate {
    
    let smileImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "smile")
        
        return image
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
    
    let passwordField: CustomTextField = {
        let field = CustomTextField()
        field.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
        field.placeholder = "Пароль"
        field.isSecureTextEntry = true
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        field.leftView = leftView
        field.leftViewMode = .always
        field.layer.cornerRadius = 8
        field.returnKeyType = .search

        let button = UIButton(type: .custom)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.setImage(UIImage(named: "eye"), for: .normal)
        button.setImage(UIImage(named: "eye-disable"), for: .selected)
        button.frame = CGRect(x: CGFloat(field.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        field.rightView = button
        field.rightViewMode = .always

        return field
    }()
    
    let enterButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
        button.layer.cornerRadius = 16
        let buttonTitle = "Войти"
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(UIColor(red: 156/255, green: 164/255, blue: 171/255, alpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        
        button.contentVerticalAlignment = .center
        
        return button
    }()
    
    let resetPasswordButton : UIButton = {
        let button = UIButton()
        let buttonTitle = "Забыли пароль?"
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        button.contentVerticalAlignment = .center
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loginField.delegate = self
        passwordField.delegate = self
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
        passwordField.isSecureTextEntry = !passwordField.isSecureTextEntry
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }
    
    func setupView() {
        addSubview(smileImage)
        addSubview(loginField)
        addSubview(passwordField)
        addSubview(enterButton)
        addSubview(resetPasswordButton)
    }
    
    func setupConstraints() {
        smileImage.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 76 / 812)
            make.centerX.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 120 / 812)
            make.width.equalTo(UIScreen.main.bounds.height * 120 / 812)
        }
        
        loginField.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 246 / 812)
            make.centerX.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 60 / 812)
            make.width.equalTo(UIScreen.main.bounds.width * 335 / 375)
        }
        
        passwordField.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 320 / 812)
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
        
        resetPasswordButton.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().inset(UIScreen.main.bounds.height * 69 / 812)
            make.width.equalTo(UIScreen.main.bounds.width * 335 / 375)
            make.centerX.equalToSuperview()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if textField == loginField {
   
            if updatedText.contains("@") && passwordField.text!.count >= 8 {
                enterButton.backgroundColor = UIColor(red: 93/255, green: 95/255, blue: 249/255, alpha: 1.0)
                enterButton.setTitleColor(UIColor.white, for: .normal)
            } else {
                enterButton.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
                enterButton.setTitleColor(UIColor(red: 156/255, green: 164/255, blue: 171/255, alpha: 1.0), for: .normal)
            }
        }
        
        if textField == passwordField {
            if updatedText.count >= 8 && loginField.text!.contains("@") {
                enterButton.backgroundColor = UIColor(red: 93/255, green: 95/255, blue: 249/255, alpha: 1.0)
                enterButton.setTitleColor(UIColor.white, for: .normal)
            } else {
                enterButton.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
                enterButton.setTitleColor(UIColor(red: 156/255, green: 164/255, blue: 171/255, alpha: 1.0), for: .normal)
            }
        }
        
        return true
    }
}
