//
//  AboutView.swift
//  IOS-Assignment2
//
//  Created by Gem on 2025-11-09.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack {
            // Background Image
            Image("BG")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 30) {
                // Logo
                Image("StockLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .shadow(color: Color(red: 1.0, green: 0.84, blue: 0.0).opacity(0.3), radius: 10)

                // Team Members Card
                VStack(spacing: 20) {
                    Text("Team Members")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))

                    VStack(spacing: 10) {
                        Text("Jaskunwar Hunjan - ")
                        Text("Gem Sha - A01345766")
                        Text("Alzen Landayan - A01403978" )
                    }
                    .font(.body)
                    .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                }
                .padding(.vertical, 40)
                .padding(.horizontal, 30)
                .background(Color.black.opacity(0.8), in: RoundedRectangle(cornerRadius: 25, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .stroke(Color(red: 1.0, green: 0.84, blue: 0.0), lineWidth: 2)
                )
            }
        }
    }
}

#Preview {
    AboutView()
}
