//
//  IPService.swift
//  Geo
//
//  Created by Meri Stakovska on 2024-10-29.
//
import Foundation

class IPService {
    private let accessKey = fetchValueFromPlist(key: "api_key") ?? "default"
    private let baseURL = "https://apiip.net/api/check"
    
    func checkIP(ip: String, completion: @escaping (IPCheckResponse?, Error?) -> Void) {
        // Prepare the URL with the provided IP and access key
        guard let url = URL(string: "\(baseURL)?ip=\(ip)&accessKey=\(accessKey)") else {
            print("Invalid URL")
            return
        }
        
        // Create the URLSession data task
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle the error
            if let error = error {
                completion(nil, error)
                return
            }
            
            // Ensure there is data
            guard let data = data else {
                let noDataError = NSError(domain: "IPService", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(nil, noDataError)
                return
            }
            
            // Parse the JSON response
            do {
                let ipCheckResponse = try JSONDecoder().decode(IPCheckResponse.self, from: data)
                completion(ipCheckResponse, nil)
            } catch {
                completion(nil, error)
            }
        }
        
        // Start the task
        task.resume()
    }
}
