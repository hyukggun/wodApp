//
//  Configuration.swift
//  wodApp
//
//  Created by 최최광현 on 2023/08/23.
//

import Foundation

enum Configuration {
    static var ProjectURL: String {
        guard let url  = Bundle.main.object(forInfoDictionaryKey: "PROJECT_URL") as? String else {
            fatalError("PROJECT_URL value is missing")
        }
        return url
    }
    
    static var PublicKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "PUBLIC_KEY") as? String else {
            fatalError("PUBLIC_KEY value is missing")
        }
        return key
    }
}
