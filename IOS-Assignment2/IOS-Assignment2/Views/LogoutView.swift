//
//  LogoutView.swift
//  IOS-Assignment2
//
//  Created by Gem on 2025-11-09.
//

import SwiftUI

struct LogoutView: View {
  @StateObject var vModel = LogoutViewViewModel()
  var body: some View {
    Button("Logout") {
        vModel.logout()
    }
    .buttonStyle(.borderedProminent)
    .controlSize(.large)
  }
}

#Preview {
  LogoutView()
}
