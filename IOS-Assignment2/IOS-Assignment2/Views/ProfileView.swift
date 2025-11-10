//
//  ProfileView.swift
//  IOS-Assignment2
//
//  Created by Gem on 2025-11-07.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    @State private var shouldRefresh = false
    
    var body: some View {
        NavigationView {
            if let user = viewModel.user {
                VStack {
                    // Avatar
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.blue)
                        .frame(width: 125, height: 125)
                        .padding()
                    
                    // Info: name, email, member since
                    VStack(alignment: .leading) {
                        HStack {
                            Text("First Name: ").bold()
                            Text(user.firstName)
                        }
                        .padding()
                        
                        HStack {
                            Text("Last Name: ").bold()
                            Text(user.lastName)
                        }
                        .padding()
                        
                        HStack {
                            Text("Email: ").bold()
                            Text(user.email)
                        }
                        .padding()
                        
                        HStack {
                            Text("Account Created: ").bold()
                            Text("\(Date(timeIntervalSince1970: user.accountCreationDate).formatted(date: .abbreviated, time: .shortened))")
                        }
                        .padding()
                        
                        HStack {
                            Text("Last Login: ").bold()
                            Text("\(Date(timeIntervalSince1970: user.lastLoginDate).formatted(date: .abbreviated, time: .shortened))")
                        }
                        .padding()
                    }
                    .padding()
                    
                    // Log out
                    Button("Logout") {
                        viewModel.logout()
                        // Trigger app to refresh authentication state
                        NotificationCenter.default.post(name: NSNotification.Name("UserLoggedOut"), object: nil)
                    }
                    .tint(.red)
                    .padding()
                    
                    Spacer()
                }
            } else {
                Text("Loading Profile ...")
            }
        }
        .onAppear() {
            viewModel.fetchUser()
        }
    }
}


#Preview {
    ProfileView()
}
