//  InfoViewController.swift
//  neobis_ios_auth
//  Created by Askar Soronbekov 

import Foundation
import UIKit
import SnapKit

class InfoViewController: UIViewController {

    let mainView = InfoView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        title = "Регистрация"

        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(goBackButtonPressed))
        navigationItem.leftBarButtonItem = backButton
        mainView.enterButton.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)
    }

    @objc func enterButtonPressed() {
        let userViewModel = AuthViewModel()
        let vc = CreatePasswordViewController(userViewModel: userViewModel)

        vc.first_name = mainView.nameField.text ?? ""
        vc.last_name = mainView.secondNameField.text ?? ""
        vc.date_of_birth = mainView.dateField.text ?? ""
        vc.email = mainView.mailField.text ?? ""

        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func goBackButtonPressed() {
        navigationController?.popViewController(animated: true)
    }

    func setupView() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func didConfirmRegistration(user: ProfileRegistration) {
        print("Registration success")
    }

    func didFail(with error: Error) {
        print("Error in registration: \(error.localizedDescription)")
    }
}
