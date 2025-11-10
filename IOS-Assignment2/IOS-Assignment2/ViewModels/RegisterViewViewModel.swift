//
//  RegisterViewViewModel.swift
//  IOS-Assignment2
//
//  Created by Gem on 2025-11-09.
//
import Foundation
import Combine

class RegisterViewViewModel: ObservableObject {
   @Published var firstName = ""
   @Published var lastName = ""
   @Published var email = ""
   @Published var password = ""
   @Published var errMsg = ""
   
   init() {
      
   }
   
   func register() {
       guard validate() else {
          return
       }
       
       // Register user with local storage
       let result = UserManager.shared.registerUser(firstName: firstName, lastName: lastName, email: email, password: password)
       
       switch result {
       case .success(_):
           // Registration successful, user is auto-logged in
           errMsg = ""
           // Notify the app that user has logged in
           NotificationCenter.default.post(name: NSNotification.Name("UserLoggedIn"), object: nil)
       case .failure(let error):
           errMsg = error.localizedDescription
       }
   }

   
    private func validate() -> Bool {
      errMsg = ""
      
      guard !firstName.trimmingCharacters(in: .whitespaces).isEmpty,
            !lastName.trimmingCharacters(in: .whitespaces).isEmpty,
            !email.trimmingCharacters(in: .whitespaces).isEmpty,
            !password.trimmingCharacters(in: .whitespaces).isEmpty
      else {
         errMsg = "Please fill in all fields."
         return false
      }
      
      // email@foo.com
      guard email.contains("@") && email.contains(".") else {
         errMsg = "Please enter a valid email address."
         return false
      }
      
      guard password.count >= 6 else {
         errMsg = "Password must be at least 6 characters long."
         return false
      }
      
      return true
    }

}

