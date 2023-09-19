//
//  UserViewModel.swift
//  neobis_ios_auth
//
//  Created by Askar Soronbekov 
//

//import Foundation
//import UIKit
//import SnapKit
//
//protocol RegistrationViewModelDelegate: AnyObject {
//    func didRegister(user: RegisterBegin)
//    func didFail(with error: Error)
//}
//
//protocol LoginViewModelDelegate: AnyObject {
//    func didLogin(user: TokenObtainPair)
//    func didFail(with error: Error)
//}
//
//protocol ForgotPasswordViewModelDelegate: AnyObject {
//    func didForgotPassword(user: ForgotPassword)
//    func didFail(with error: Error)
//}
//
//protocol ConfirmPasswordViewModelDelegate: AnyObject {
//    func didConfirmForgotPassword(user: ForgotPasswordConfirm)
//    func didFail(with error: Error)
//}
//
//protocol RegisterConfirmViewModelDelegate: AnyObject {
//    func didConfirmRegistration(user: Register)
//    func didFail(with error: Error)
//}
//
//protocol UserViewModelProtocol: AnyObject {
//    var registrationDelegate: RegistrationViewModelDelegate? { get set }
//    var loginDelegate: LoginViewModelDelegate? { get set }
//    var forgotPasswordDelegate: ForgotPasswordViewModelDelegate? { get set }
//    var confirmPasswordDelegate: ConfirmPasswordViewModelDelegate? { get set }
//    var registerConfirmDelegate: RegisterConfirmViewModelDelegate? { get set }
//
//    func registerUser(email: String)
//    func loginUser(email: String, password: String)
//    func forgotPassword(email: String)
//    func confirmForgotPassword(newPassword: String, password2: String, activationCode: String)
//    func registerConfirmUser(email: String, name: String, last_name: String, birthday: String, password: String, password2: String)
//}
//
//class UserViewModel: UserViewModelProtocol {
//
//
//    weak var registrationDelegate: RegistrationViewModelDelegate?
//    weak var loginDelegate: LoginViewModelDelegate?
//    weak var forgotPasswordDelegate: ForgotPasswordViewModelDelegate?
//    weak var confirmPasswordDelegate: ConfirmPasswordViewModelDelegate?
//    weak var registerConfirmDelegate: RegisterConfirmViewModelDelegate?
//
//    let apiService = APIService()
//
//    init(registrationDelegate: RegistrationViewModelDelegate? = nil,
//         loginDelegate: LoginViewModelDelegate? = nil,
//         forgotPasswordDelegate: ForgotPasswordViewModelDelegate? = nil,
//         confirmPasswordDelegate: ConfirmPasswordViewModelDelegate? = nil) {
//        self.registrationDelegate = registrationDelegate
//        self.loginDelegate = loginDelegate
//        self.confirmPasswordDelegate = confirmPasswordDelegate
//        self.forgotPasswordDelegate = forgotPasswordDelegate
//    }
//
//    func registerUser(email: String) {
//        let parameters: [String: Any] = ["email": email]
//
//        apiService.post(endpoint: "register-email", parameters: parameters) { [weak self] (result) in
//            switch result {
//            case .success(let data):
//                let decoder = JSONDecoder()
//                do {
//                    let response = try decoder.decode(RegisterBegin.self, from: data)
//                    DispatchQueue.main.async {
//                        self?.registrationDelegate?.didRegister(user: response)
//                    }
//                } catch {
//                    DispatchQueue.main.async {
//                        self?.registrationDelegate?.didFail(with: error)
//                    }
//                }
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    self?.registrationDelegate?.didFail(with: error)
//                }
//            }
//        }
//    }
//
//    func registerConfirmUser(email: String, name: String, last_name: String, birthday: String, password: String, password2: String) {
//        let parameters: [String: Any] = ["email": email, "name": name, "last_name": last_name, "birthday": birthday, "password": password, "password2": password2]
//
//        apiService.post(endpoint: "register-profile", parameters: parameters) { [weak self] (result) in
//            switch result {
//            case .success(let data):
//                let decoder = JSONDecoder()
//                do {
//                    let response = try decoder.decode(Register.self, from: data)
//                    DispatchQueue.main.async {
//                        self?.registerConfirmDelegate?.didConfirmRegistration(user: response)
//                    }
//                } catch {
//                    DispatchQueue.main.async {
//                        self?.registerConfirmDelegate?.didFail(with: error)
//                    }
//                }
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    self?.registerConfirmDelegate?.didFail(with: error)
//                }
//            }
//        }
//    }
//
//    func loginUser(email: String, password: String) {
//        let parameters: [String: Any] = ["email": email, "password": password]
//
//        apiService.post(endpoint: "login", parameters: parameters) { [weak self] (result) in
//            switch result {
//            case .success(let data):
//                let decoder = JSONDecoder()
//                do {
//                    let response = try decoder.decode(TokenObtainPair.self, from: data)
//                    DispatchQueue.main.async {
//                        self?.loginDelegate?.didLogin(user: response)
//                    }
//                } catch {
//                    DispatchQueue.main.async {
//                        self?.loginDelegate?.didFail(with: error)
//                    }
//                }
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    self?.loginDelegate?.didFail(with: error)
//                }
//            }
//        }
//    }
//
//    func forgotPassword(email: String) {
//        let parameters: [String: Any] = ["email": email]
//
//        apiService.post(endpoint: "password-reset-email", parameters: parameters) { [weak self] (result) in
//            switch result {
//            case .success(let data):
//                let decoder = JSONDecoder()
//                do {
//                    let response = try decoder.decode(ForgotPassword.self, from: data)
//                    DispatchQueue.main.async {
//                        self?.forgotPasswordDelegate?.didForgotPassword(user: response)
//                    }
//                } catch {
//                    DispatchQueue.main.async {
//                        self?.forgotPasswordDelegate?.didFail(with: error)
//                    }
//                }
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    self?.forgotPasswordDelegate?.didFail(with: error)
//                }
//            }
//        }
//    }
//
//    func confirmForgotPassword(newPassword: String, password2: String, activationCode: String) {
//        let parameters: [String: Any] = ["new_password": newPassword, "new_password_confirm": password2, "activation_code": activationCode]
//
//        apiService.post(endpoint: "password-reset-complete", parameters: parameters) { [weak self] (result) in
//            switch result {
//            case .success(let data):
//                let decoder = JSONDecoder()
//                do {
//                    let response = try decoder.decode(PasswordChangeResponse.self, from: data)
//                    print("Decoded message: \(response.msg)")
//                    DispatchQueue.main.async {
//                        // You might want to handle the success message differently here
//                    }
//                } catch {
//                    print("Decoding error: \(error)")
//                    DispatchQueue.main.async {
//                        self?.confirmPasswordDelegate?.didFail(with: error)
//                    }
//                }
//            case .failure(let error):
//                print("API call error: \(error)")
//                DispatchQueue.main.async {
//                    self?.confirmPasswordDelegate?.didFail(with: error)
//                }
//            }
//        }
//    }
//}

import Foundation
import UIKit
import SnapKit

protocol RegistrationViewModelDelegate: AnyObject {
    func didRegister(user: RegisterBegin)
    func didFail(with error: Error)
}

protocol LoginViewModelDelegate: AnyObject {
    func didLogin(user: TokenObtainPair)
    func didFail(with error: Error)
}

protocol ForgotPasswordViewModelDelegate: AnyObject {
    func didForgotPassword(user: ForgotPassword)
    func didFail(with error: Error)
}

protocol ConfirmPasswordViewModelDelegate: AnyObject {
    func didConfirmForgotPassword(user: ForgotPasswordConfirm)
    func didFail(with error: Error)
}

protocol RegisterConfirmViewModelDelegate: AnyObject {
    func didConfirmRegistration(user: Register)
    func didFail(with error: Error)
}

protocol UserViewModelProtocol: AnyObject {
    var registrationDelegate: RegistrationViewModelDelegate? { get set }
    var loginDelegate: LoginViewModelDelegate? { get set }
    var forgotPasswordDelegate: ForgotPasswordViewModelDelegate? { get set }
    var confirmPasswordDelegate: ConfirmPasswordViewModelDelegate? { get set }
    var registerConfirmDelegate: RegisterConfirmViewModelDelegate? { get set }

    func registerUser(email: String)
    func loginUser(email: String, password: String)
    func forgotPassword(email: String)
    func confirmForgotPassword(newPassword: String, password2: String, activationCode: String)
    func registerConfirmUser(email: String, name: String, last_name: String, birthday: String, password: String, password2: String)
}

class UserViewModel: UserViewModelProtocol {
    weak var registrationDelegate: RegistrationViewModelDelegate?
    weak var loginDelegate: LoginViewModelDelegate?
    weak var forgotPasswordDelegate: ForgotPasswordViewModelDelegate?
    weak var confirmPasswordDelegate: ConfirmPasswordViewModelDelegate?
    weak var registerConfirmDelegate: RegisterConfirmViewModelDelegate?
    
    let apiService = APIService()
    
    init(registrationDelegate: RegistrationViewModelDelegate? = nil,
         loginDelegate: LoginViewModelDelegate? = nil,
         forgotPasswordDelegate: ForgotPasswordViewModelDelegate? = nil,
         confirmPasswordDelegate: ConfirmPasswordViewModelDelegate? = nil) {
        self.registrationDelegate = registrationDelegate
        self.loginDelegate = loginDelegate
        self.confirmPasswordDelegate = confirmPasswordDelegate
        self.forgotPasswordDelegate = forgotPasswordDelegate
    }
    
    func registerUser(email: String) {
        let parameters: [String: Any] = ["email": email]
        
        apiService.post(endpoint: "register-email/", parameters: parameters) { [weak self] (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(RegisterBegin.self, from: data)
                    DispatchQueue.main.async {
                        self?.registrationDelegate?.didRegister(user: response)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self?.registrationDelegate?.didFail(with: error)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.registrationDelegate?.didFail(with: error)
                }
            }
        }
    }
    
    func registerConfirmUser(email: String, name: String, last_name: String, birthday: String, password: String, password2: String) {
        let parameters: [String: Any] = ["email": email, "name": name, "last_name": last_name, "birthday": birthday, "password": password, "password2": password2]
        
        apiService.post(endpoint: "register-profile/", parameters: parameters) { [weak self] (result) in
            switch result {
            case .success(let data):
                print(birthday + "\n" + email)
                let dataString = String(data: data, encoding: .utf8)
                print("Data received: \(dataString ?? "nil")")
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(Register.self, from: data)
                    DispatchQueue.main.async {
                        self?.registerConfirmDelegate?.didConfirmRegistration(user: response)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self?.registerConfirmDelegate?.didFail(with: error)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.registerConfirmDelegate?.didFail(with: error)
                }
            }
        }
    }
    
    func loginUser(email: String, password: String) {
        let parameters: [String: Any] = ["email": email, "password": password]
        
        apiService.post(endpoint: "login/", parameters: parameters) { [weak self] (result) in
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
    
    func forgotPassword(email: String) {
        let parameters: [String: Any] = ["email": email]
        
        apiService.post(endpoint: "password-reset-email/", parameters: parameters) { [weak self] (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(ForgotPassword.self, from: data)
                    DispatchQueue.main.async {
                        self?.forgotPasswordDelegate?.didForgotPassword(user: response)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self?.forgotPasswordDelegate?.didFail(with: error)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.forgotPasswordDelegate?.didFail(with: error)
                }
            }
        }
    }
    
    func confirmForgotPassword(newPassword: String, password2: String, activationCode: String) {
        let parameters: [String: Any] = ["new_password": newPassword, "new_password_confirm": password2, "activation_code": activationCode]
        
        apiService.post(endpoint: "password-reset-confirm/\(activationCode)/", parameters: parameters) { [weak self] (result) in
            switch result {
            case .success(let data):
                print(newPassword + password2)
                let dataString = String(data: data, encoding: .utf8)
                print("Data received: \(dataString ?? "nil")")
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(PasswordChangeResponse.self, from: data)
                    print("Decoded message: \(response.msg)")
                    DispatchQueue.main.async {
                        // You might want to handle the success message differently here
                        // Since we're not using the ForgotPasswordConfirm struct anymore
                    }
                } catch {
                    print("Decoding error: \(error)")
                    DispatchQueue.main.async {
                        self?.confirmPasswordDelegate?.didFail(with: error)
                    }
                }
            case .failure(let error):
                print("API call error: \(error)")
                DispatchQueue.main.async {
                    self?.confirmPasswordDelegate?.didFail(with: error)
                }
            }
        }
    }
}
