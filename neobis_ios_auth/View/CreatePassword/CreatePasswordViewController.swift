//  CreatePasswordViewController.swift
//  neobis_ios_auth
//  Created by Askar Soronbekov

import Foundation
import UIKit
import SnapKit

class CreatePasswordViewController : UIViewController, RegisterConfirmViewModelDelegate {
    func didConfirmRegistration(user: ProfileRegistration) {
        print()
    }
    
    var first_name: String
    var last_name: String
    var date_of_birth: String
    var email: String
    
    let mainView = CreatePasswordView()
    let infoView = InfoView()
    var userViewModel : UserViewModelProtocol!
    
    init(userViewModel: UserViewModelProtocol, first_name: String = "", last_name: String = "", date_of_birth: String = "",  email: String = "") {
        self.first_name = first_name
        self.last_name = last_name
        self.date_of_birth = date_of_birth
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
            guard let password = mainView.newPassword.text, let password_confirm = mainView.repeatPassword.text else {
                // Show error message to user
                print("Error")
                return
            }
            userViewModel.registerConfirmUser(first_name: first_name, last_name: last_name, date_of_birth: date_of_birth, email: email, password: password, password_confirm: password_confirm)
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
    
    func didConfirmForgotPassword(user: SetNewPassword) {
        print("Password added")
    }
    
    func didFail(with error: Error) {
        print("Error in setting password")
    }
}
