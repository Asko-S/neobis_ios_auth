//
//  ResetView.swift
//  neobis_ios_auth
//  Created by Askar Soronbekov

import Foundation
import UIKit
import SnapKit

class ResetView : UIView, UITextFieldDelegate {
    
    let newPassword : CustomTextField = {
        let field = CustomTextField()
        field.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
        field.placeholder = "Придумайте пароль"
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
        button.addTarget(self, action: #selector(toggleNewPasswordVisibility), for: .touchUpInside)
        field.rightView = button
        field.rightViewMode = .always
        
        return field
    }()
    
    let repeatPassword: CustomTextField = {
        let field = CustomTextField()
        field.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
        field.placeholder = "Повторите пароль"
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
        button.addTarget(self, action: #selector(toggleRepeatPasswordVisibility), for: .touchUpInside)
        field.rightView = button
        field.rightViewMode = .always
        
        return field
    }()
    
    let authCode: CustomTextField = {
        let field = CustomTextField()
        field.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
        field.placeholder = "Введите секретный код"
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        field.leftView = leftView
        field.leftViewMode = .always
        field.layer.cornerRadius = 8
        field.returnKeyType = .search
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: CGFloat(field.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        field.rightView = button
        field.rightViewMode = .always
        
        return field
    }()
    
    let enterButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        let buttonTitle = "Далее"
        button.setTitle(buttonTitle, for: .normal)
        button.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
        button.setTitleColor(UIColor(red: 156/255, green: 164/255, blue: 171/255, alpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        
        button.contentVerticalAlignment = .center
        
        return button
    }()
    
    let firstLabel : UILabel = {
        let label = UILabel()
        label.text = "•Заглавная буква"
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        label.textColor = UIColor(red: 0.758, green: 0.758, blue: 0.758, alpha: 1)
        
        return label
    }()
    
    let secondLabel : UILabel = {
        let label = UILabel()
        label.text = "•Цифры"
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        label.textColor = UIColor(red: 0.758, green: 0.758, blue: 0.758, alpha: 1)
        
        return label
    }()
    
    let thirdLabel : UILabel = {
        let label = UILabel()
        label.text = "•Специальные символы"
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        label.textColor = UIColor(red: 0.758, green: 0.758, blue: 0.758, alpha: 1)
        
        return label
    }()
    
    let fourthLabel : UILabel = {
        let label = UILabel()
        label.text = "•Совпадение пароля"
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        label.textColor = UIColor(red: 0.758, green: 0.758, blue: 0.758, alpha: 1)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        newPassword.delegate = self
        repeatPassword.delegate = self
        
        newPassword.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        repeatPassword.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = .white
        
        setupView()
        setupConstraints()
    }
    
    @objc func toggleNewPasswordVisibility(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        newPassword.isSecureTextEntry = !newPassword.isSecureTextEntry
    }
    
    @objc func toggleRepeatPasswordVisibility(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        repeatPassword.isSecureTextEntry = !repeatPassword.isSecureTextEntry
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }
    
    func setupView() {
        addSubview(newPassword)
        addSubview(repeatPassword)
        addSubview(enterButton)
        addSubview(firstLabel)
        addSubview(secondLabel)
        addSubview(thirdLabel)
        addSubview(fourthLabel)
        addSubview(authCode)
    }
    
    func setupConstraints() {
        
        newPassword.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 128 / 812)
            make.centerX.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 60 / 812)
            make.width.equalTo(UIScreen.main.bounds.width * 335 / 375)
        }
        
        repeatPassword.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 212 / 812)
            make.centerX.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 60 / 812)
            make.width.equalTo(UIScreen.main.bounds.width * 335 / 375)
        }
        
        authCode.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 296 / 812)
            make.centerX.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 60 / 812)
            make.width.equalTo(UIScreen.main.bounds.width * 335 / 375)
        }
        
        enterButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 524 / 812)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width * 335 / 375)
            make.height.equalTo(UIScreen.main.bounds.height * 65 / 812)
        }
        
        firstLabel.snp.makeConstraints{ make in
            make.top.equalTo(repeatPassword.snp.bottom).offset(UIScreen.main.bounds.height * 112 / 812)
            make.leading.equalTo(repeatPassword.snp.leading)
        }
        
        secondLabel.snp.makeConstraints{ make in
            make.top.equalTo(repeatPassword.snp.bottom).offset(UIScreen.main.bounds.height * 139 / 812)
            make.leading.equalTo(repeatPassword.snp.leading)
        }
        
        thirdLabel.snp.makeConstraints{ make in
            make.top.equalTo(repeatPassword.snp.bottom).offset(UIScreen.main.bounds.height * 166 / 812)
            make.leading.equalTo(repeatPassword.snp.leading)
        }
        
        fourthLabel.snp.makeConstraints{ make in
            make.top.equalTo(repeatPassword.snp.bottom).offset(UIScreen.main.bounds.height * 193 / 812)
            make.leading.equalTo(repeatPassword.snp.leading)
        }
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        let resultString = newPassword.text ?? ""
        
        let upperCaseLetterCharacterSet = CharacterSet.uppercaseLetters
        let digitCharacterSet = CharacterSet.decimalDigits
        let specialCharacterSet = CharacterSet.symbols.union(CharacterSet.punctuationCharacters)
        
        if resultString.rangeOfCharacter(from: upperCaseLetterCharacterSet) != nil {
            firstLabel.textColor = UIColor(red: 93/255, green: 95/255, blue: 249/255, alpha: 1.0)
        } else {
            firstLabel.textColor = UIColor(red: 0.758, green: 0.758, blue: 0.758, alpha: 1)
        }
        
        if resultString.rangeOfCharacter(from: digitCharacterSet) != nil {
            secondLabel.textColor = UIColor(red: 93/255, green: 95/255, blue: 249/255, alpha: 1.0)
        } else {
            secondLabel.textColor = UIColor(red: 0.758, green: 0.758, blue: 0.758, alpha: 1)
        }
        
        if resultString.rangeOfCharacter(from: specialCharacterSet) != nil {
            thirdLabel.textColor = UIColor(red: 93/255, green: 95/255, blue: 249/255, alpha: 1.0)
        } else {
            thirdLabel.textColor = UIColor(red: 0.758, green: 0.758, blue: 0.758, alpha: 1)
        }
        
        if newPassword.text == repeatPassword.text {
            fourthLabel.textColor = UIColor(red: 93/255, green: 95/255, blue: 249/255, alpha: 1.0)
        } else {
            fourthLabel.textColor = UIColor(red: 0.758, green: 0.758, blue: 0.758, alpha: 1)
        }
        
        updateButtonColor()
    }
    
    func updateButtonColor() {
        if firstLabel.textColor == secondLabel.textColor && secondLabel.textColor == thirdLabel.textColor && thirdLabel.textColor == fourthLabel.textColor && fourthLabel.textColor ==  UIColor(red: 93/255, green: 95/255, blue: 249/255, alpha: 1.0) {
            enterButton.backgroundColor = UIColor(red: 93/255, green: 95/255, blue: 249/255, alpha: 1.0)
            enterButton.setTitleColor(.white, for: .normal)
        } else {
            enterButton.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
            enterButton.setTitleColor(UIColor(red: 156/255, green: 164/255, blue: 171/255, alpha: 1.0), for: .normal)
        }
    }
    
}
