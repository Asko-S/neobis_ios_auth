//  EmailViewController.swift
//  neobis_ios_auth
//  Created by Askar Soronbekov

import Foundation
import UIKit
import SnapKit

class EmailViewController : UIViewController, ForgotPasswordViewModelDelegate {
        
    let mainView = EmailView()
    var userViewModel: UserViewModelProtocol!
    
    init(userViewModel: UserViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.userViewModel = userViewModel
        self.userViewModel.forgotPasswordDelegate = self
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
            guard let email = mainView.loginField.text else {
                // Show error message to user
                print("Email or password is empty.")
                return
            }
            
            userViewModel.forgotPassword(email: email)
            let userViewModel = UserViewModel()
            let vc = ResetViewController(userViewModel: userViewModel)
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }


    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }

    func setupView() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func didForgotPassword(user: ForgotPassword) {
        print("Succesfully sent mail")
    }
    
    func didFail(with error: Error) {
//        print("Failed to send mail")
    }
}

