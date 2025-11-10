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
        if verticalSizeClass == .regular {
            // Portrait mode - vertical layout
            VStack {
                // Header
                HeaderView(title: "StockX", subtitle: "Log in", angle: 15, backColor: .pink)

                // Login Form
                Form {
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
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                }

                // Create Account
                VStack {
                    Text("New user?")
                    NavigationLink("Create an account") {
                        RegisterView()
                    }
                }
                .padding(.bottom, 50)

                Spacer()
            }
        } else {
            // Landscape mode - horizontal layout
            HStack(spacing: 20) {
                // Header on the left side
                HeaderView(title: "Todo List", subtitle: "Remember", angle: 15, backColor: .pink)
                    .frame(width: 200)
                
                // Form on the right side
                VStack {
                    if !viewModel.errMsg.isEmpty {
                        Text(viewModel.errMsg)
                            .foregroundColor(.red)
                    }

                    TextField("Email", text: $viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .padding(.horizontal)
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    Button("Log In") {viewModel.login()}
                        .buttonStyle(.borderedProminent)
                        .controlSize(.regular)
                        .padding(.top, 10)
                    
                    // Create Account
                    HStack {
                        Text("New user?")
                        NavigationLink("Create an account") {
                            RegisterView()
                        }
                    }
                    .padding(.top, 10)
                }
                .padding()
            }
            .padding()
        }
    }
    }
}


#Preview {
    LoginView()
}

