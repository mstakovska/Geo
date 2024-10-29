//
//  IPViewModel.swift
//  Geo
//
//  Created by Meri Stakovska on 2024-10-29.
//

import Foundation

class IPViewModel: ObservableObject {
    @Published var ipInfo: IPCheckResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let ipService = IPService() // Declare ipService as a property
    
    // Fetch IP info with ipToCheck as a parameter
    func fetchIPInfo(for ipToCheck: String) {
        isLoading = true // Set loading state
        
        ipService.checkIP(ip: ipToCheck) { [weak self] response, error in
            DispatchQueue.main.async {
                self?.isLoading = false // End loading state
                
                // Handle error if present
                if let error = error {
                    self?.errorMessage = "Error: \(error.localizedDescription)"
                    print(self?.errorMessage ?? "")
                    return
                }
                
                // Handle response if present
                if let response = response {
                    self?.ipInfo = response // Store the response
                    print("IP: \(response.ip)")
                    print("Country: \(response.countryName) (\(response.countryCode))")
                    print("City: \(response.city)")
                }
            }
        }
    }
}


