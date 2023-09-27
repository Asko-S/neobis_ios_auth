//  ResetViewController.swift
//  neobis_ios_auth
//  Created by Askar Soronbekov

import Foundation
import UIKit
import SnapKit

class ResetViewController : UIViewController, ConfirmPasswordViewModelDelegate {

    let mainView = ResetView()
    var userViewModel : AuthViewModelProtocol!

    init(userViewModel: AuthViewModelProtocol) {
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
            guard let passwordNew = mainView.newPassword.text, let codeToken = mainView.tokenCode.text, let uidb64Code = mainView.authCode.text else {
                // Show error message to user
                print("Wrong auth code")
                return
            }
            userViewModel.completePasswordReset(password: passwordNew, token: codeToken, uidb64: uidb64Code)
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
        print("Password changed")
    }

    func didFail(with error: Error) {
        print("Error in changing password")
    }
}

