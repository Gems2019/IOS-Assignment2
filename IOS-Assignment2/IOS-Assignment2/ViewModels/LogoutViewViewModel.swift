//
//  LogoutViewViewModel.swift
//  IOS-Assignment2
//
//  Created by Gem on 2025-11-09.
//

import Foundation
import Combine

class LogoutViewViewModel : ObservableObject {
  init() {}
  
  func logout() {
    UserManager.shared.logout()
    // Notify the app to refresh authentication state
    NotificationCenter.default.post(name: NSNotification.Name("UserLoggedOut"), object: nil)
  }
}
