//
//  ContentView.swift
//  IOS-Assignment2
//
//  Created by Gem on 2025-11-07.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject var viewModel = ContentViewViewModel()

    var body: some View {
        if viewModel.isSignedIn {
            // User is logged in - show main app
            mainAppView
        } else {
            // User is not logged in - show login view
            LoginView()
        }
    }
    
    @ViewBuilder
    var mainAppView: some View {
        TabView {
            AiView()
                .tabItem {
                    Image(systemName: "apple.intelligence")
                    Text("AI")
                }
                .tag(1)
            
            AboutView()
                .tabItem {
                    Image(systemName: "pencil.circle")
                    Text("About")
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
                .tag(3)
            
        }
        .onAppear {
            viewModel.checkAuthStatus()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
