//
//  IPModel.swift
//  Geo
//
//  Created by Meri Stakovska on 2024-10-29.
//

import Foundation

struct IPCheckResponse: Codable {
    let ip: String
    let city: String
    let countryName: String
    let countryCode: String
}
