//  InfoViewController.swift
//  neobis_ios_auth
//  Created by Askar Soronbekov 

import Foundation
import UIKit
import SnapKit

class InfoViewController : UIViewController {
    
    let mainView = InfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        title = "Регистрация"
        
        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
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
    
}

