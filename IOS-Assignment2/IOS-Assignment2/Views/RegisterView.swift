//
//  RegisterView.swift
//  IOS-Assignment2
//
//  Created by Gem on 2025-11-09.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        VStack {
            // Header - full size in portrait, compact in landscape
            if verticalSizeClass == .regular {
                HeaderView(title: "Register", subtitle: "Start checking Your Stock", angle: -15, backColor: .orange)
            } else {
                // Compact header for landscape
                Text("Register")
                    .font(.headline)
                    .padding(.top, 8)
            }

            // Register Form
            Form {
                
                if !viewModel.errMsg.isEmpty {
                  Text(viewModel.errMsg)
                    .foregroundColor(.red)
                }

                TextField("First Name", text: $viewModel.firstName)
                 .textFieldStyle(DefaultTextFieldStyle())
                 .autocorrectionDisabled()
                
                TextField("Last Name", text: $viewModel.lastName)
                 .textFieldStyle(DefaultTextFieldStyle())
                 .autocorrectionDisabled()
              
                TextField("Email Address", text: $viewModel.email)
                 .textFieldStyle(DefaultTextFieldStyle())
                 .autocapitalization(.none)
                 .autocorrectionDisabled()
              
                SecureField("Password", text: $viewModel.password)
                 .textFieldStyle(DefaultTextFieldStyle())
              
              Spacer()
              
              Button("Create Account") {viewModel.register()}
                 .buttonStyle(.borderedProminent)
                 .controlSize(.large)
                 .padding()
            
            }
            .offset(y: verticalSizeClass == .regular ? -50 : 0)

            Spacer()
        }
    }
}

#Preview {
    RegisterView()
}
