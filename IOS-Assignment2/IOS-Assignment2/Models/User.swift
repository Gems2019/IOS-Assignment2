//
//  User.swift
//  IOS-Assignment2
//
//  Created by Gem on 2025-11-09.
//

import Foundation

struct User: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let password: String  // In production, this should be hashed!
    let accountCreationDate: TimeInterval
    var lastLoginDate: TimeInterval
    
    // Computed property for full name
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}

extension User {
    func asDictionary() -> [String: Any] {
        return [
            "id": id,
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "password": password,
            "accountCreationDate": accountCreationDate,
            "lastLoginDate": lastLoginDate
        ]
    }
}
