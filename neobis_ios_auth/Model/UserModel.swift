//  UserModel.swift
//  neobis_ios_auth
//  Created by Askar Soronbekov

import Foundation

struct ForgotPassword: Codable {
    let email: String
}

struct ForgotPasswordConfirm: Codable {
    let new_password: String
    let new_password_confirm: String
    let activation_code: String
    
    enum CodingKeys: String, CodingKey {
        case new_password = "new_password"
        case new_password_confirm = "new_password_confirm"
        case activation_code = "activation_code"
    }
}

struct PasswordChangeResponse: Decodable {
    let msg: String
}

struct TokenObtainPair: Codable {
    let refresh: String
    let access: String
}

struct TokenRefresh: Codable {
    let refresh: String
    let access: String
}

struct RegisterBegin: Codable {
    let email: String
}

struct Register: Codable {
    let email: String
    let name: String
    let last_name: String
    let birthday: String
    let password: String
    let password2: String
}

