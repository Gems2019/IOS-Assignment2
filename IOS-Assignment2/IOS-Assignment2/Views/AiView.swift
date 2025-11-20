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
            ZStack {
                // Background Image
                Image("BG")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text("StockWise AI")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                        .padding(.top, 30)

                    VStack(spacing: 15) {
                        TextField("Enter stock symbol (e.g. AAPL)", text: $symbol)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.allCharacters)

                        Button(action: { fetchSummary() }) {
                            Text("Get AI Summary")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                        .background(Color(red: 1.0, green: 0.84, blue: 0.0))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .disabled(symbol.isEmpty || isLoading)
                        .opacity((symbol.isEmpty || isLoading) ? 0.6 : 1.0)
                    }
                    .padding(20)
                    .background(Color.black.opacity(0.8), in: RoundedRectangle(cornerRadius: 15))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color(red: 1.0, green: 0.84, blue: 0.0), lineWidth: 2)
                    )
                    .padding(.horizontal, 30)

                    if isLoading {
                        ProgressView("Fetching...")
                            .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                            .tint(Color(red: 1.0, green: 0.84, blue: 0.0))
                            .padding()
                    }

                    if !errorMsg.isEmpty {
                        Text(errorMsg)
                            .foregroundColor(.red)
                            .padding(.horizontal)
                    }

                    ScrollView {
                        Text(summary.isEmpty ? "Enter a stock symbol to begin." : summary)
                            .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                            .padding(20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.black.opacity(0.8), in: RoundedRectangle(cornerRadius: 15))
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color(red: 1.0, green: 0.84, blue: 0.0), lineWidth: 1)
                            )
                    }
                    .padding(.horizontal, 30)

                    Spacer()
                }
                .padding(.top, 10)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("AI Assistant")
                        .font(.headline)
                        .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))
                }
            }
        }
    }

    func fetchSummary() {
        let apiBaseURL = "https://stockwise-api-dev-czyqpwdtyduyq.azurewebsites.net"
        guard let url = URL(string: "\(apiBaseURL)/api/stock/summary?symbol=\(symbol)") else {
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
