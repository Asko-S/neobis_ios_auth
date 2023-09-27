//  RegistrationViewController.swift
//  neobis_ios_auth
//  Created by Askar Soronbekov

import Foundation
import UIKit
import SnapKit

class RegistrationViewController : UIViewController, RegistrationViewModelDelegate {

    let mainView = RegistrationScreenView()
    var userViewModel: UserViewModelProtocol!

    init(userViewModel: UserViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.userViewModel = userViewModel
        self.userViewModel.registrationDelegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        title = "Регистрация"

        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton

        mainView.enterButton.addTarget(self, action: #selector(enterPressed), for: .touchUpInside)
    }

    @objc func enterPressed() {
        guard let email = mainView.loginField.text else {
            // Show error message to user
            print("Email is empty.")
            return
        }

        userViewModel.registerUser(email: email)
        
        if mainView.enterButton.currentTitleColor == .white{
            let vc = InfoViewController()
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

    // MARK: - RegistrationViewModelDelegate Methods

    func didRegister(user: EmailRegistration) {
        // Handle successful registration here.
        print("Successfully registered user with email: \(user.email)")
    }

    func didFail(with error: Error) {
        // Handle failure in registration here.
        print("Error in registration: \(error.localizedDescription)")
    }
}
