//
//  AiView.swift
//  IOS-Assignment2
//
//  Created by JaskunwarH on 2025-11-09.
//

import SwiftUI

struct AiView: View {
    @State private var symbol = ""
    @State private var summary = ""
    @State private var isLoading = false
    @State private var errorMsg = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("StockWise AI")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.pink)

                TextField("Enter stock symbol (e.g. AAPL)", text: $symbol)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.allCharacters)
                    .padding(.horizontal)

                Button(action: { fetchSummary() }) {
                    Text("Get AI Summary")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .tint(.pink)
                .padding(.horizontal)
                .disabled(symbol.isEmpty || isLoading)

                if isLoading {
                    ProgressView("Fetching...")
                        .padding()
                }

                if !errorMsg.isEmpty {
                    Text(errorMsg)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }

                ScrollView {
                    Text(summary.isEmpty ? "Enter a stock symbol to begin." : summary)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("AI Assistant")
        }
    }

    func fetchSummary() {
        // ⚠️ Replace this IP with YOUR local IP address from ⚠️
        // Run this in your terminal 'ipconfig getifaddr en0'
        // And the IP address you get is what you use to replace 192.168.1.79 below
        guard let url = URL(string: "http://192.168.1.79:5250/api/stock/summary?symbol=\(symbol)") else {
            errorMsg = "Invalid URL"
            return
        }

        isLoading = true
        errorMsg = ""
        summary = ""

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
            }

            if let error = error {
                DispatchQueue.main.async {
                    errorMsg = "Error: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    errorMsg = "No data received."
                }
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let aiSummary = json["aiSummary"] as? String {
                    DispatchQueue.main.async {
                        summary = aiSummary
                    }
                } else {
                    DispatchQueue.main.async {
                        errorMsg = "Unexpected response format."
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    errorMsg = "JSON error: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

#Preview {
    AiView()
}
