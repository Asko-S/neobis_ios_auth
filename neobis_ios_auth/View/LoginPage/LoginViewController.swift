//
//  LoginViewController.swift
//  neobis_ios_auth
//  Created by Askar Soronbekov

import Foundation
import UIKit
import SnapKit

class LoginViewController : UIViewController, LoginViewModelDelegate {
    let mainView = LoginScreenView()
    var userViewModel: UserViewModelProtocol!
    
    init(userViewModel: UserViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.userViewModel = userViewModel
        self.userViewModel.loginDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        mainView.enterButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        //        mainView.resetPasswordButton.addTarget(self, action: #selector(resetPasswordPressed), for: .touchUpInside)
    }
    
    @objc func loginPressed() {
        guard let email = mainView.loginField.text, let password = mainView.passwordField.text else {
            // Show error message to user
            print("Email or password is empty.")
            return
        }
        
        userViewModel.loginUser(email: email, password: password)
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
    
//    @objc func resetPasswordPressed() {
//        let userViewModel = UserViewModel()
//        let vc = EmailViewController(userViewModel: userViewModel)
//        navigationController?.pushViewController(vc, animated: true)
//    }
    
    func setupView(){
        view.addSubview(mainView)
        mainView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    // LoginViewModelDelegate methods
    func didLogin(user: TokenObtainPair) {
        print("Successfully logged in as \(user)")
    }
    
    func didFail(with error: Error) {
        print("Failed to login: \(error)")
    }
}
