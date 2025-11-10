//
//  ProfileViewViewModel.swift
//  IOS-Assignment2
//
//  Created by Gem on 2025-11-09.
//

import Combine

class ProfileViewViewModel: ObservableObject {
    @Published var user: User? = nil
   
   init() {}
   
    func fetchUser() {
        // Fetch current user from local storage
        user = UserManager.shared.getCurrentUser()
    }
    
    func logout() {
        UserManager.shared.logout()
        user = nil
    }
}

