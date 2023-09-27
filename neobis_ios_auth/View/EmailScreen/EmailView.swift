//  EmailView.swift
//  neobis_ios_auth
//  Created by Askar Soronbekov

import Foundation
import UIKit
import SnapKit

class EmailView: UIView, UITextFieldDelegate {
    
    // MARK: - UI Elements
    
    private let smileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "smile")
        return imageView
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "Смейся\nи улыбайся\nкаждый день")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
        label.attributedText = attributedText
        label.numberOfLines = 0
        label.textColor = UIColor(red: 93/255, green: 95/255, blue: 249/255, alpha: 1.0)
        label.font = UIFont(name: "GothamPro-Medium", size: 40)
        return label
    }()
    
    let continueButton: UIButton = {
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

    let emailTextField: CustomTextField = {
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
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        emailTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout and Interaction
    
    override func layoutSubviews() {
        backgroundColor = .white
    }
    
    @objc func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }
    
    // MARK: - UI Setup and Constraints
    
    private func setupView() {
        addSubview(messageLabel)
        addSubview(smileImageView)
        addSubview(emailTextField)
        addSubview(continueButton)
    }
    
    private func setupConstraints() {
        messageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height * 116 / 812)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width * 335 / 375)
            make.height.equalTo(UIScreen.main.bounds.height * 144 / 812)
        }
        
        smileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 101 / 812)
            make.trailing.equalToSuperview().inset(UIScreen.main.bounds.width * 20 / 375)
            make.height.equalTo(UIScreen.main.bounds.height * 80 / 812)
            make.width.equalTo(UIScreen.main.bounds.height * 80 / 812)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(UIScreen.main.bounds.height * 60 / 812)
            make.centerX.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 60 / 812)
            make.width.equalTo(UIScreen.main.bounds.width * 335 / 375)
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 440 / 812)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width * 335 / 375)
            make.height.equalTo(UIScreen.main.bounds.height * 65 / 812)
        }
    }
    
    // MARK: - UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if updatedText.contains("@") {
            continueButton.backgroundColor = UIColor(red: 93/255, green: 95/255, blue: 249/255, alpha: 1.0)
            continueButton.setTitleColor(UIColor.white, for: .normal)
        } else {
            continueButton.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
            continueButton.setTitleColor(UIColor(red: 156/255, green: 164/255, blue: 171/255, alpha: 1.0), for: .normal)
        }
        
        return true
    }
}
