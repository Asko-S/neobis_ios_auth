//
//  CreatePasswordViewController.swift
//  neobis_ios_auth
//
//  Created by Askar Soronbekov
//

import Foundation
import UIKit
import SnapKit

class CreatePasswordViewController : UIViewController, RegisterConfirmViewModelDelegate {
    func didConfirmRegistration(user: Register) {
        print()
    }
    
    var name: String
    var last_name: String
    var birthday: String
    var email: String
    
    let mainView = CreatePasswordView()
    let infoView = InfoView()
    var userViewModel : UserViewModelProtocol!
    
    init(userViewModel: UserViewModelProtocol, name: String = "", last_name: String = "", birthday: String = "",  email: String = "") {
        self.name = name
        self.last_name = last_name
        self.birthday = birthday
        self.email = email
        super.init(nibName: nil, bundle: nil)
        self.userViewModel = userViewModel
        self.userViewModel.registerConfirmDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        title = "Создать пароль"
        
        
        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
        mainView.enterButton.addTarget(self, action: #selector(enterPressed), for: .touchUpInside)
    }
    
    @objc func enterPressed() {
        if mainView.enterButton.currentTitleColor == .white{
            guard let password = mainView.newPassword.text, let password2 = mainView.repeatPassword.text else {
                // Show error message to user
                print("Error")
                return
            }
            userViewModel.registerConfirmUser(email: email, name: name, last_name: last_name, birthday: birthday, password: password, password2: password2)
        }
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupView(){
        view.addSubview(mainView)
        
        mainView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func didConfirmForgotPassword(user: ForgotPasswordConfirm) {
        print("Password added")
    }
    
    func didFail(with error: Error) {
        print("Error in setting password")
    }
}
