//
//  LoginView.swift
//  IOS-Assignment2
//
//  Created by Gem on 2025-11-09.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
    NavigationView {
        ZStack {
            // Background Image
            Image("BG")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            if verticalSizeClass == .regular {
                // Portrait mode - vertical layout
                VStack(spacing: 30) {
                    Spacer()

                    // Logo
                    Image("StockLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                        .shadow(color: Color(red: 1.0, green: 0.84, blue: 0.0).opacity(0.3), radius: 10)

                    Text("StockWise")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))

                    // Login Form Card
                    VStack(spacing: 20) {
                        if !viewModel.errMsg.isEmpty {
                            Text(viewModel.errMsg)
                                .foregroundColor(.red)
                        }

                        TextField("Email", text: $viewModel.email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                        
                        SecureField("Password", text: $viewModel.password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        Button("Log In") {viewModel.login()}
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 1.0, green: 0.84, blue: 0.0))
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .cornerRadius(10)
                    }
                    .padding(30)
                    .background(Color.black.opacity(0.8), in: RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(red: 1.0, green: 0.84, blue: 0.0), lineWidth: 2)
                    )
                    .padding(.horizontal, 30)

                    // Create Account
                    VStack(spacing: 5) {
                        Text("New user?")
                            .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                        NavigationLink("Create an account") {
                            RegisterView()
                        }
                        .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                        .fontWeight(.bold)
                    }
                    .padding(.bottom, 50)

                    Spacer()
                }
            } else {
                // Landscape mode - horizontal layout
                HStack(spacing: 40) {
                    // Logo on the left side
                    VStack {
                        Image("StockLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .shadow(color: Color(red: 1.0, green: 0.84, blue: 0.0).opacity(0.3), radius: 10)
                        
                        Text("StockWise")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                    }
                    .frame(width: 200)
                    
                    // Form on the right side
                    VStack(spacing: 15) {
                        if !viewModel.errMsg.isEmpty {
                            Text(viewModel.errMsg)
                                .foregroundColor(.red)
                        }

                        TextField("Email", text: $viewModel.email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                        
                        SecureField("Password", text: $viewModel.password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        Button("Log In") {viewModel.login()}
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 1.0, green: 0.84, blue: 0.0))
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .cornerRadius(10)
                        
                        // Create Account
                        HStack {
                            Text("New user?")
                                .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                            NavigationLink("Create an account") {
                                RegisterView()
                            }
                            .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                            .fontWeight(.bold)
                        }
                    }
                    .padding(30)
                    .background(Color.black.opacity(0.8), in: RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(red: 1.0, green: 0.84, blue: 0.0), lineWidth: 2)
                    )
                    .frame(maxWidth: 350)
                }
                .padding()
            }
        }
    }
    }
}


#Preview {
    LoginView()
}

