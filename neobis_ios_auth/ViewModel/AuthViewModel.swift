//  AuthViewModel.swift
//  neobis_ios_auth
//  Created by Askar Soronbekov
import Foundation
import UIKit
import SnapKit

// MARK: - Protocols

protocol RegistrationViewModelDelegate: AnyObject {
    func didRegister(user: EmailRegistration)
    func didFail(with error: Error)
}

protocol LoginViewModelDelegate: AnyObject {
    func didLogin(user: TokenObtainPair)
    func didFail(with error: Error)
}

protocol ForgotPasswordViewModelDelegate: AnyObject {
    func didForgotPassword(user: PasswordResetEmailSerializers)
    func didFail(with error: Error)
}

protocol ConfirmPasswordViewModelDelegate: AnyObject {
    func didConfirmForgotPassword(user: SetNewPassword)
    func didFail(with error: Error)
}

protocol RegisterConfirmViewModelDelegate: AnyObject {
    func didConfirmRegistration(user: ProfileRegistration)
    func didFail(with error: Error)
}

protocol AuthViewModelProtocol: AnyObject {
    var registrationDelegate: RegistrationViewModelDelegate? { get set }
    var loginDelegate: LoginViewModelDelegate? { get set }
    var forgotPasswordDelegate: ForgotPasswordViewModelDelegate? { get set }
    var confirmPasswordDelegate: ConfirmPasswordViewModelDelegate? { get set }
    var registerConfirmDelegate: RegisterConfirmViewModelDelegate? { get set }
    
    func registerEmail(email: String)
    func loginUser(email: String, password: String)
    func resetPassword(email: String)
    func completePasswordReset(password: String, token: String, uidb64: String)
    func registerConfirmUser(first_name: String, last_name: String, date_of_birth: String, email: String, password: String, password_confirm: String)
    
}

// MARK: - UserViewModel Class

class AuthViewModel: AuthViewModelProtocol {
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
    
    // MARK: - Registration email of user
    
    func registerEmail(email: String) {
        let parameters: [String: Any] = ["email": email]
        
        apiService.post(endpoint: "register-email", parameters: parameters) { [weak self] (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(EmailRegistration.self, from: data)
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
    
    // MARK: - Registration Confirmation, parsing other data of user
    
    func registerConfirmUser(first_name: String, last_name: String, date_of_birth: String, email: String, password: String, password_confirm: String) {
        let parameters: [String: Any] = ["first_name": first_name, "last_name": last_name, "date_of_birth": date_of_birth, "email": email, "password": password, "password_confirm": password_confirm]
        
        apiService.put(endpoint: "register-profile", parameters: parameters) { [weak self] (result) in
            switch result {
            case .success(let data):
                print(date_of_birth + "\n" + email)
                let dataString = String(data: data, encoding: .utf8)
                print("Data received: \(dataString ?? "nil")")
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(ProfileRegistration.self, from: data)
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
    
    // MARK: - Login
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
    
    // MARK: - Forgot Password, email sending to reset password
    
    func resetPassword(email: String) {
        let parameters: [String: Any] = ["email": email]

        apiService.post(endpoint: "password-reset-email", parameters: parameters) { [weak self] (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(PasswordResetEmailSerializers.self, from: data)
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
    
    // MARK: - Complete Password Reset
    
    func completePasswordReset(password: String, token: String, uidb64: String) {
        let parameters: [String: Any] = ["password": password, "token": token, "uidb64": uidb64]

        apiService.patch(endpoint: "password-reset-complete", parameters: parameters) { [weak self] (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(SetNewPassword.self, from: data)
                    DispatchQueue.main.async {
                        self?.confirmPasswordDelegate?.didConfirmForgotPassword(user: response)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self?.confirmPasswordDelegate?.didFail(with: error)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.confirmPasswordDelegate?.didFail(with: error)
                }
            }
        }
    }

}
