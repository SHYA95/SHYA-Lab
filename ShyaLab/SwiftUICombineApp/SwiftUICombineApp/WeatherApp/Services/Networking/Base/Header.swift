//
//  Header.swift
//  SwiftUICombineApp
//
//  Created by Shrouk Yasser on 11/10/2025.
//

import Foundation

struct Header {
    static let shared = Header()
    private init() {}
    
    func createHeader() -> [String: String] {
        let headers: [String: String] = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Cache-Control": "no-cache",
            "Authorization": "\(Constants.API_AUTH_VALUE)",
            "X-Unfold-Goals": "true"
        ]
        return headers
    }
}
