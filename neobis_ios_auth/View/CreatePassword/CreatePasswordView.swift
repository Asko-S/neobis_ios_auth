// CreatePasswordView.swift
// neobis_ios_auth
// Created by Askar Soronbekov

import UIKit
import SnapKit

class CreatePasswordView: UIView, UITextFieldDelegate {
    // MARK: - Properties
    
    let newPassword: CustomTextField = {
        let field = createCustomTextField(placeholder: "Придумайте пароль")
        field.isSecureTextEntry = true
        field.rightView = createVisibilityButton(action: #selector(toggleNewPasswordVisibility))
        return field
    }()
    
    let repeatPassword: CustomTextField = {
        let field = createCustomTextField(placeholder: "Повторите пароль")
        field.isSecureTextEntry = true
        field.rightView = createVisibilityButton(action: #selector(toggleRepeatPasswordVisibility))
        return field
    }()
    
    let enterButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.setTitle("Далее", for: .normal)
        button.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
        button.setTitleColor(UIColor(red: 156/255, green: 164/255, blue: 171/255, alpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        button.contentVerticalAlignment = .center
        return button
    }()
    
    let passwordRequirementsLabels: [UILabel] = {
        let labelsText = ["•Заглавная буква", "•Цифры", "•Специальные символы", "•Совпадение пароля"]
        return labelsText.map { createPasswordRequirementsLabel(text: $0) }
    }()
    
    // MARK: - Initialization
    
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
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        backgroundColor = .white
        setupView()
        setupConstraints()
    }
    
    // MARK: - Button Actions
    
    @objc func toggleNewPasswordVisibility(_ sender: UIButton) {
        togglePasswordVisibility(sender, textField: newPassword)
    }
    
    @objc func toggleRepeatPasswordVisibility(_ sender: UIButton) {
        togglePasswordVisibility(sender, textField: repeatPassword)
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        updatePasswordRequirementsLabels()
        updateButtonColor()
    }
    
    // MARK: - UI Setup
    
    private func setupView() {
        addSubview(newPassword)
        addSubview(repeatPassword)
        addSubview(enterButton)
        passwordRequirementsLabels.forEach { addSubview($0) }
    }
    
    private func setupConstraints() {
        let textFieldHeight = UIScreen.main.bounds.height * 60 / 812
        let textFieldWidth = UIScreen.main.bounds.width * 335 / 375
        
        newPassword.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 128 / 812)
            make.centerX.equalToSuperview()
            make.height.equalTo(textFieldHeight)
            make.width.equalTo(textFieldWidth)
        }
        
        repeatPassword.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 212 / 812)
            make.centerX.equalToSuperview()
            make.height.equalTo(textFieldHeight)
            make.width.equalTo(textFieldWidth)
        }
        
        enterButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 440 / 812)
            make.centerX.equalToSuperview()
            make.width.equalTo(textFieldWidth)
            make.height.equalTo(UIScreen.main.bounds.height * 65 / 812)
        }
        
        var previousLabel: UILabel?
        for label in passwordRequirementsLabels {
            label.snp.makeConstraints { make in
                make.leading.equalTo(repeatPassword.snp.leading)
                if let previous = previousLabel {
                    make.top.equalTo(previous.snp.bottom).offset(UIScreen.main.bounds.height * 27 / 812)
                } else {
                    make.top.equalTo(repeatPassword.snp.bottom).offset(UIScreen.main.bounds.height * 28 / 812)
                }
            }
            previousLabel = label
        }
    }
    
    // MARK: - Helper Methods
    
    private func togglePasswordVisibility(_ sender: UIButton, textField: UITextField) {
        sender.isSelected = !sender.isSelected
        textField.isSecureTextEntry = !textField.isSecureTextEntry
    }
    
    private func updatePasswordRequirementsLabels() {
        let resultString = newPassword.text ?? ""
        let requirementsMet = [
            resultString.rangeOfCharacter(from: .uppercaseLetters) != nil,
            resultString.rangeOfCharacter(from: .decimalDigits) != nil,
            resultString.rangeOfCharacter(from: .symbols.union(.punctuationCharacters)) != nil,
            newPassword.text == repeatPassword.text
        ]
        
        for (index, label) in passwordRequirementsLabels.enumerated() {
            label.textColor = requirementsMet[index] ? UIColor(red: 93/255, green: 95/255, blue: 249/255, alpha: 1.0) : UIColor(red: 0.758, green: 0.758, blue: 0.758, alpha: 1)
        }
    }
    
    private func updateButtonColor() {
        let allRequirementsMet = passwordRequirementsLabels.allSatisfy { $0.textColor == UIColor(red: 93/255, green: 95/255, blue: 249/255, alpha: 1.0) }
        
        if allRequirementsMet {
            enterButton.backgroundColor = UIColor(red: 93/255, green: 95/255, blue: 249/255, alpha: 1.0)
            enterButton.setTitleColor(.white, for: .normal)
        } else {
            enterButton.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
            enterButton.setTitleColor(UIColor(red: 156/255, green: 164/255, blue: 171/255, alpha: 1.0), for: .normal)
        }
    }
    
    // MARK: - Helper Functions
    
    private static func createCustomTextField(placeholder: String) -> CustomTextField {
        let field = CustomTextField()
        field.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
        field.placeholder = placeholder
        field.isSecureTextEntry = true
        
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        field.leftView = leftView
        field.leftViewMode = .always
        field.layer.cornerRadius = 8
        field.returnKeyType = .search
        
        return field
    }
    
    private static func createVisibilityButton(action: Selector) -> UIButton {
        let button = UIButton(type: .custom)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.setImage(UIImage(named: "eye"), for: .normal)
        button.setImage(UIImage(named: "eye-disable"), for: .selected)
        button.frame = CGRect(x: 0, y: 5, width: 25, height: 25)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    private static func createPasswordRequirementsLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        label.textColor = UIColor(red: 0.758, green: 0.758, blue: 0.758, alpha: 1)
        return label
    }
}
