// UserModel.swift
// neobis_ios_auth
// Created by Askar Soronbekov

import Foundation

// MARK: - Token Obtain Pair

struct TokenObtainPair: Codable {
    let email: String
    let tokens: Tokens
    
    // Nested struct to represent tokens
    struct Tokens: Codable {
        let refresh: String
        let access: String
    }
}

// MARK: - Login

struct Login: Codable {
    let email: String
    let password: String
}

// MARK: - Set New Password

struct SetNewPassword: Codable {
    let password: String
    let token: String
    let uidb64: String
}

// MARK: - Password Reset Email

struct PasswordResetEmailSerializers: Codable {
    let email: String
}

// MARK: - Email Registration

struct EmailRegistration: Codable {
    let email: String
}

// MARK: - Profile Registration

struct ProfileRegistration: Codable {
    let first_name: String
    let last_name: String
    let date_of_birth: String
    let email: String
    let password: String
    let password_confirm: String
}

// MARK: - Token Refresh

struct TokenRefresh: Codable {
    let refresh: String
    let access: String
}
