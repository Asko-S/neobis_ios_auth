//  InfoView.swift
//  neobis_ios_auth
//  Created by Askar Soronbekov

import Foundation
import UIKit
import SnapKit

class InfoView : UIView, UITextFieldDelegate {
    
    let nameField: CustomTextField = {
        let field = CustomTextField()
        field.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
        field.placeholder = "Имя"
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        field.leftView = leftView
        field.leftViewMode = .always
        field.layer.cornerRadius = 8
        field.returnKeyType = .search
        
        let button = UIButton(type: .custom)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(field.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        field.rightView = button
        field.rightViewMode = .always
        
        return field
    }()
    
    let secondNameField: CustomTextField = {
        let field = CustomTextField()
        field.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
        field.placeholder = "Фамилия"
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        field.leftView = leftView
        field.leftViewMode = .always
        field.layer.cornerRadius = 8
        field.returnKeyType = .search
        
        let button = UIButton(type: .custom)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(field.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        field.rightView = button
        field.rightViewMode = .always
        
        return field
    }()
    
    let dateField: CustomTextField = {
        let field = CustomTextField()
        field.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
        field.placeholder = "Дата рождения"
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        field.leftView = leftView
        field.leftViewMode = .always
        field.layer.cornerRadius = 8
        field.returnKeyType = .search
        
        let button = UIButton(type: .custom)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(field.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        field.rightView = button
        field.rightViewMode = .always
        
        return field
    }()
    
    let mailField : CustomTextField = {
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
        let buttonTitle = "Войти"
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(UIColor(red: 156/255, green: 164/255, blue: 171/255, alpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        
        button.contentVerticalAlignment = .center
        
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        mailField.delegate = self
        nameField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = .white
        
        setupView()
        setupConstraints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }
    
    func setupView() {
        addSubview(mailField)
        addSubview(nameField)
        addSubview(secondNameField)
        addSubview(dateField)
        addSubview(enterButton)
    }
    
    func setupConstraints() {
        
        mailField.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 346 / 812)
            make.centerX.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 60 / 812)
            make.width.equalTo(UIScreen.main.bounds.width * 335 / 375)
        }
        
        nameField.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 94 / 812)
            make.centerX.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 60 / 812)
            make.width.equalTo(UIScreen.main.bounds.width * 335 / 375)
        }
        
        secondNameField.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 178 / 812)
            make.centerX.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 60 / 812)
            make.width.equalTo(UIScreen.main.bounds.width * 335 / 375)
        }
        
        dateField.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 262 / 812)
            make.centerX.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 60 / 812)
            make.width.equalTo(UIScreen.main.bounds.width * 335 / 375)
        }
        
        enterButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 450 / 812)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width * 335 / 375)
            make.height.equalTo(UIScreen.main.bounds.height * 65 / 812)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if textField == mailField {
            
            if updatedText.contains("@") && nameField.text!.count >= 1 {
                enterButton.backgroundColor = UIColor(red: 93/255, green: 95/255, blue: 249/255, alpha: 1.0)
                enterButton.setTitleColor(UIColor.white, for: .normal)
            } else {
                enterButton.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
                enterButton.setTitleColor(UIColor(red: 156/255, green: 164/255, blue: 171/255, alpha: 1.0), for: .normal)
            }
        }
        
        if textField == nameField {
            if secondNameField != nil && mailField.text!.contains("@") && (nameField.text != nil) && (dateField.text != nil){
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
