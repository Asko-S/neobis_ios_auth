//  UserViewModel.swift
//  neobis_ios_auth
//  Created by Askar Soronbekov
import Foundation
import UIKit
import SnapKit


protocol LoginViewModelDelegate: AnyObject {
    func didLogin(user: TokenObtainPair)
    func didFail(with error: Error)
}

protocol UserViewModelProtocol: AnyObject {
    var loginDelegate: LoginViewModelDelegate? { get set }
    
    //    func registerUser(email: String)
    func loginUser(email: String, password: String)
}
    
    class UserViewModel: UserViewModelProtocol {
        
        weak var loginDelegate: LoginViewModelDelegate?
        
        let apiService = APIService()
        
        init (loginDelegate: LoginViewModelDelegate? = nil) {
            self.loginDelegate = loginDelegate
        }

        func loginUser(email: String, password: String) {
            let parameters: [String: Any] = ["email": email, "password": password]
            
            apiService.post(endpoint: "login", parameters: parameters) { [weak self] (result) in
                switch result {
                case .success(let data):
                    let dataString = String(data: data, encoding: .utf8)
                    print("Data received: \(dataString ?? "nil")")
                    let decoder = JSONDecoder()
                    do {
                        let response = try decoder.decode(TokenObtainPair.self, from: data)
                        DispatchQueue.main.async {
                            self?.loginDelegate?.didLogin(user: response)
                        }
                    } catch {
                        DispatchQueue.main.async {
                            self?.loginDelegate?.didFail(with: error)
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.loginDelegate?.didFail(with: error)
                    }
                }
            }
        }
}
