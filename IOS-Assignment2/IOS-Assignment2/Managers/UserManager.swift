//
//  UserManager.swift
//  IOS-Assignment2
//
//  Created by Gem on 2025-11-09.
//

import Foundation

class UserManager {
    static let shared = UserManager()
    
    private let usersKey = "registered_users"
    private let currentUserKey = "current_user_id"
    
    private init() {}
    
    // MARK: - User Registration
    func registerUser(firstName: String, lastName: String, email: String, password: String) -> Result<User, Error> {
        // Check if user already exists
        if getUserByEmail(email) != nil {
            return .failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "User with this email already exists"]))
        }
        
        let userId = UUID().uuidString
        let currentTime = Date().timeIntervalSince1970
        let newUser = User(
            id: userId,
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,  // Note: In production, hash this!
            accountCreationDate: currentTime,
            lastLoginDate: currentTime
        )
        
        // Save user to storage
        var users = getAllUsers()
        users.append(newUser)
        saveUsers(users)
        
        // Auto-login after registration
        setCurrentUser(userId)
        
        return .success(newUser)
    }
    
    // MARK: - User Login
    func login(email: String, password: String) -> Result<User, Error> {
        guard let user = getUserByEmail(email) else {
            return .failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not found"]))
        }
        
        guard user.password == password else {
            return .failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid password"]))
        }
        
        // Update last login date
        updateLastLoginDate(for: user.id)
        
        setCurrentUser(user.id)
        return .success(user)
    }
    
    // MARK: - User Logout
    func logout() {
        UserDefaults.standard.removeObject(forKey: currentUserKey)
    }
    
    // MARK: - Get Current User
    func getCurrentUser() -> User? {
        guard let userId = UserDefaults.standard.string(forKey: currentUserKey) else {
            return nil
        }
        return getUserById(userId)
    }
    
    func isUserLoggedIn() -> Bool {
        return getCurrentUser() != nil
    }
    
    // MARK: - Private Helper Methods
    private func getAllUsers() -> [User] {
        guard let data = UserDefaults.standard.data(forKey: usersKey) else {
            return []
        }
        
        do {
            let users = try JSONDecoder().decode([User].self, from: data)
            return users
        } catch {
            print("Error decoding users: \(error)")
            return []
        }
    }
    
    private func saveUsers(_ users: [User]) {
        do {
            let data = try JSONEncoder().encode(users)
            UserDefaults.standard.set(data, forKey: usersKey)
        } catch {
            print("Error encoding users: \(error)")
        }
    }
    
    private func getUserByEmail(_ email: String) -> User? {
        return getAllUsers().first { $0.email.lowercased() == email.lowercased() }
    }
    
    private func getUserById(_ id: String) -> User? {
        return getAllUsers().first { $0.id == id }
    }
    
    private func setCurrentUser(_ userId: String) {
        UserDefaults.standard.set(userId, forKey: currentUserKey)
    }
    
    private func updateLastLoginDate(for userId: String) {
        var users = getAllUsers()
        if let index = users.firstIndex(where: { $0.id == userId }) {
            var user = users[index]
            user.lastLoginDate = Date().timeIntervalSince1970
            users[index] = user
            saveUsers(users)
        }
    }
}
