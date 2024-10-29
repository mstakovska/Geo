//
//  ContentView.swift
//  Geo
//
//  Created by Meri Stakovska on 2024-10-29.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = IPViewModel()
    @State private var ipToCheck = "67.250.186.196" //Default IP address
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                TextField("Enter IP Address", text: $ipToCheck)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Check IP") {
                    viewModel.fetchIPInfo(for: ipToCheck) // Call the function with user input
                }
                .padding()
                
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage).foregroundColor(.red)
                } else if let ipInfo = viewModel.ipInfo {
                    VStack {
                        Text("IP: \(ipInfo.ip)")
                        Text("Country: \(ipInfo.countryName) (\(ipInfo.countryCode))")
                        Text("City: \(ipInfo.city)")
                        
                    }
                    .padding()
                    Spacer()
                }
            }
            .padding()
            Spacer()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

