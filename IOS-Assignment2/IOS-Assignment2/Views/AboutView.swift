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
            Image("BackgroundImage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(
                    LinearGradient(
                        colors: [.red.opacity(0.4), .clear],
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )

            // Frosted Glass Card
            VStack(spacing: 20) {
                Text("Team Members")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .shadow(radius: 3)

                VStack(spacing: 10) {
                    Text("Jaskunwar Hunjan - ")
                    Text("Gem Sha - A01345766")
                    Text("Alzen Landayan - " )
                }
                .font(.body)
                .foregroundColor(.black.opacity(2.9))
            }
            .padding(.vertical, 40)
            .padding(.horizontal, 30)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 25, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .stroke(Color.white.opacity(9.3), lineWidth: 1)
            )
    
        }
    }
}

#Preview {
    AboutView()
}
