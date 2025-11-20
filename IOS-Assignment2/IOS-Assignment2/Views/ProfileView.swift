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
            ZStack {
                // Background Image
                Image("BG")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                if let user = viewModel.user {
                    ScrollView {
                        VStack(spacing: 30) {
                            // Avatar
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                                .frame(width: 100, height: 100)
                                .padding()
                            
                            // Info Card
                            VStack(alignment: .leading, spacing: 15) {
                                HStack {
                                    Text("First Name: ").bold()
                                        .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                                    Text(user.firstName)
                                        .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0).opacity(0.8))
                                }
                                
                                HStack {
                                    Text("Last Name: ").bold()
                                        .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                                    Text(user.lastName)
                                        .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0).opacity(0.8))
                                }
                                
                                HStack {
                                    Text("Email: ").bold()
                                        .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                                    Text(user.email)
                                        .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0).opacity(0.8))
                                }
                                
                                HStack {
                                    Text("Account Created: ").bold()
                                        .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                                    Text("\(Date(timeIntervalSince1970: user.accountCreationDate).formatted(date: .abbreviated, time: .shortened))")
                                        .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0).opacity(0.8))
                                }
                                
                                HStack {
                                    Text("Last Login: ").bold()
                                        .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                                    Text("\(Date(timeIntervalSince1970: user.lastLoginDate).formatted(date: .abbreviated, time: .shortened))")
                                        .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0).opacity(0.8))
                                }
                            }
                            .padding(30)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.black.opacity(0.8), in: RoundedRectangle(cornerRadius: 20))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(red: 1.0, green: 0.84, blue: 0.0), lineWidth: 2)
                            )
                            .padding(.horizontal, 30)
                            
                            // Log out Button
                            Button("Logout") {
                                viewModel.logout()
                                // Trigger app to refresh authentication state
                                NotificationCenter.default.post(name: NSNotification.Name("UserLoggedOut"), object: nil)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .cornerRadius(10)
                            .padding(.horizontal, 30)
                            
                            Spacer()
                        }
                        .padding(.top, 30)
                    }
                } else {
                    ProgressView("Loading Profile...")
                        .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                        .tint(Color(red: 1.0, green: 0.84, blue: 0.0))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Profile")
                        .font(.headline)
                        .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                }
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
