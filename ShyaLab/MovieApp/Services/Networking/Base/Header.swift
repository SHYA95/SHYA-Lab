//
//  Header.swift
//  SwiftUICombineApp
//
//  Created by Shrouk Yasser on 24/11/2025.
//

import Foundation

struct Header {
    static let shared = Header()
    private init() {}
    
    func getHeaders(additional: [String: String]? = nil) -> [String: String] {
        var headers: [String: String] = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Cache-Control": "no-cache",
            Constants.API_AUTH_KEY: Constants.API_AUTH_VALUE
        ]
        
        if let additional = additional {
            headers.merge(additional) { (_, new) in new }
        }
        
        return headers
    }
}
