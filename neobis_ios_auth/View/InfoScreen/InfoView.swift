//  InfoView.swift
//  neobis_ios_auth
//  Created by Askar Soronbekov

import Foundation
import UIKit
import SnapKit

class InfoView: UIView, UITextFieldDelegate {
    
    // MARK: - Properties
    
    let nameField = createCustomTextField(placeholder: "Имя")
    let secondNameField = createCustomTextField(placeholder: "Фамилия")
    let dateField = createCustomTextField(placeholder: "Дата рождения")
    let mailField = createCustomTextField(placeholder: "Электронная почта")
    
    let enterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
        button.layer.cornerRadius = 16
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(UIColor(red: 156/255, green: 164/255, blue: 171/255, alpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        button.contentVerticalAlignment = .center
        return button
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextFields()
        mailField.delegate = self
        nameField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        backgroundColor = .white
        setupView()
        setupConstraints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }
    
    // MARK: - Private Methods
    
    private func setupTextFields() {
        [nameField, secondNameField, dateField, mailField].forEach { textField in
            textField.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
            textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
            textField.leftViewMode = .always
            textField.layer.cornerRadius = 8
            textField.returnKeyType = .search
            let button = UIButton(type: .custom)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
            button.frame = CGRect(x: CGFloat(textField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
            textField.rightView = button
            textField.rightViewMode = .always
        }
    }
    
    private func setupView() {
        [mailField, nameField, secondNameField, dateField, enterButton].forEach { subview in
            addSubview(subview)
        }
    }
    
    private func setupConstraints() {
        let topOffsets: [CGFloat] = [346, 94, 178, 262, 450]
        
        [mailField, nameField, secondNameField, dateField, enterButton].enumerated().forEach { index, view in
            view.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(UIScreen.main.bounds.height * topOffsets[index] / 812)
                make.centerX.equalToSuperview()
                make.height.equalTo(UIScreen.main.bounds.height * 60 / 812)
                make.width.equalTo(UIScreen.main.bounds.width * 335 / 375)
            }
        }
    }
    
    // MARK: - UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if textField == mailField {
            if updatedText.contains("@") && !nameField.text!.isEmpty {
                enterButton.backgroundColor = UIColor(red: 93/255, green: 95/255, blue: 249/255, alpha: 1.0)
                enterButton.setTitleColor(UIColor.white, for: .normal)
            } else {
                enterButton.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
                enterButton.setTitleColor(UIColor(red: 156/255, green: 164/255, blue: 171/255, alpha: 1.0), for: .normal)
            }
        }
        
        if textField == nameField {
            if !secondNameField.text!.isEmpty && updatedText.contains("@") && !dateField.text!.isEmpty {
                enterButton.backgroundColor = UIColor(red: 93/255, green: 95/255, blue: 249/255, alpha: 1.0)
                enterButton.setTitleColor(UIColor.white, for: .normal)
            } else {
                enterButton.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
                enterButton.setTitleColor(UIColor(red: 156/255, green: 164/255, blue: 171/255, alpha: 1.0), for: .normal)
            }
        }
        
        return true
    }
    
    private static func createCustomTextField(placeholder: String) -> CustomTextField {
        let field = CustomTextField()
        field.placeholder = placeholder
        return field
    }
}
