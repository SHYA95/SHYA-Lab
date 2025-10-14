//
//  TargetType.swift
//  SwiftUICombineApp
//
//  Created by Shrouk Yasser on 11/10/2025.
//

import Foundation
import Alamofire


enum Task {
    
    /// A request with no additional data.
    case requestPlain

}

protocol TargetType {
    
    /// The target's base `URL`.
    var baseURL: String { get }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    /// The HTTP method used in the request.
    var method: HTTPMethod { get }
    
    /// The type of HTTP task to be performed.
    var task: Task { get }
    
    /// The headers to be used in the request.
    var headers: [String: String] { get }
}
