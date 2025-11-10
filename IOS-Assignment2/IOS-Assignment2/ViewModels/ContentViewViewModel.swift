//
//  ContentViewViewModel.swift
//  IOS-Assignment2
//
//  Created by Gem on 2025-11-09.
//

import Foundation
import Combine

class ContentViewViewModel: ObservableObject {
    @Published var currentUserId: String = ""
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Check if user is logged in
        checkAuthStatus()
        
        // Listen for login notifications
        NotificationCenter.default.publisher(for: NSNotification.Name("UserLoggedIn"))
            .sink { [weak self] (notification: Notification) in
                self?.checkAuthStatus()
            }
            .store(in: &cancellables)
        
        // Listen for logout notifications
        NotificationCenter.default.publisher(for: NSNotification.Name("UserLoggedOut"))
            .sink { [weak self] (notification: Notification) in
                self?.checkAuthStatus()
            }
            .store(in: &cancellables)
    }
    
    public var isSignedIn: Bool {
        return UserManager.shared.isUserLoggedIn()
    }
    
    func checkAuthStatus() {
        if let user = UserManager.shared.getCurrentUser() {
            self.currentUserId = user.id
        } else {
            self.currentUserId = ""
        }
    }
}
