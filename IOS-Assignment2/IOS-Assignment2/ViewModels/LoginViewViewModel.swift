//
//  LoginViewViewModel.swift
//  IOS-Assignment2
//
//  Created by Gem on 2025-11-09.
//

import Foundation
import Combine

class LoginViewViewModel: ObservableObject {
   
   @Published var email = ""
   @Published var password = ""
   @Published var errMsg = ""
   
   init() {
      // Default initializer; no additional setup needed.
   }
   
   func login() {
       guard validate() else {
          return
       }
       
       // Login user with local storage
       let result = UserManager.shared.login(email: email, password: password)
       
       switch result {
       case .success(_):
           // Login successful
           errMsg = ""
           // Notify the app that user has logged in
           NotificationCenter.default.post(name: NSNotification.Name("UserLoggedIn"), object: nil)
       case .failure(let error):
           errMsg = error.localizedDescription
       }
   }
    
    private func validate() -> Bool {
      errMsg = ""
      
      guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
            !password.trimmingCharacters(in: .whitespaces).isEmpty
      else {
         errMsg = "Please fill in email and password fields."
         return false
      }
      
      // email@foo.com
      guard email.contains("@") && email.contains(".") else {
         errMsg = "Please enter a valid email address."
         return false
      }
      return true
    }

}
