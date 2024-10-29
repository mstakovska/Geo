//
//  PlistReader.swift
//  Geo
//
//  Created by Meri Stakovska on 2024-10-29.
//
import Foundation

func fetchValueFromPlist(key: String) -> String? {
    if let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
       let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
        return dict[key] as? String
    }
    return nil
}
