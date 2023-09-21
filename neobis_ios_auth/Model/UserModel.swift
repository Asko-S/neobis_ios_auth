//  UserModel.swift
//  neobis_ios_auth
//  Created by Askar Soronbekov

import Foundation

struct TokenObtainPair: Codable {
    let email: String
    let tokens: Tokens
    
        struct Tokens: Codable {
            let refresh: String
            let access: String
    }
}

struct Login: Codable {
    let email: String
    let password: String
}

struct SetNewPassword: Codable {
    let password: String
    let token: String
    let uidb64: String
}

struct PasswordResetEmailSerializers: Codable {
    let email: String
}

struct EmailRegistration: Codable {
    let email: String
}


struct ProfileRegistration: Codable {
    let first_name: String
    let last_name: String
    let date_of_birth: String
    let email: String
    let password: String
    let password_confirm: String
}

struct TokenRefresh: Codable {
    let refresh: String
    let access: String
}

