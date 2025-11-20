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
        .accentColor(Color(red: 1.0, green: 0.84, blue: 0.0))
        .onAppear {
            viewModel.checkAuthStatus()
            // Set tab bar appearance
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.black
            
            // Set item colors
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 0.6)
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 0.6)]
            
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0)
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0)]
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
