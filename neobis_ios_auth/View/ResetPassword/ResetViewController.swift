//
//  ResetViewController.swift
//  neobis_ios_auth
//
//  Created by Askar Soronbekov 
//

import Foundation
import UIKit
import SnapKit

class ResetViewController : UIViewController, ConfirmPasswordViewModelDelegate {
    
    let mainView = ResetView()
    var userViewModel : UserViewModelProtocol!
    
    init(userViewModel: UserViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.userViewModel = userViewModel
        self.userViewModel.confirmPasswordDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        title = "Сброс пароля"
        
        
        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
        mainView.enterButton.addTarget(self, action: #selector(enterPressed), for: .touchUpInside)
    }
    
    @objc func enterPressed() {
        if mainView.enterButton.currentTitleColor == .white{
            guard let passwordNew = mainView.newPassword.text, let password2 = mainView.repeatPassword.text, let actCode = mainView.authCode.text else {
                // Show error message to user
                print("Wrong auth code")
                return
            }
            userViewModel.confirmForgotPassword(newPassword: passwordNew, password2: password2 ,activationCode: actCode)
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
        print("Password changed")
    }
    
    func didFail(with error: Error) {
        print("Error in changing password")
    }
}

