//
//  RequestBuilder.swift
//  MovieApp
//
//  Created by Shrouk Yasser on 24/11/2025.
//

import Foundation

class RequestBuilder {
    
    static func buildRequest<T: TargetType>(for target: T) throws -> URLRequest {
        
        // 1. Prepare Base URL
        guard let baseURL = URL(string: target.baseURL) else { throw AppErrorType.invalidURL }
        let fullURL = baseURL.appendingPathComponent(target.path)
        
        // 2. Initialize Request
        var request = URLRequest(url: fullURL)
        request.httpMethod = target.method.rawValue
        request.allHTTPHeaderFields = Header.shared.getHeaders(additional: target.headers)
        
        // 3. Prepare Parameters (Default + Target Specific)
        let parameters = prepareParameters(for: target)
        
        // 4. Encode Parameters based on Method
        if target.method == .get {
            try configureQueryParameters(request: &request, parameters: parameters)
        } else {
            configureBodyParameters(request: &request, parameters: parameters)
        }
        
        return request
    }
    
    // MARK: - Private Helpers
    
    /// Merges default parameters (Dates) with target specific parameters
    private static func prepareParameters(for target: TargetType) -> [String: Any] {
        var parameters: [String: Any] = [
            Constants.DATE_FROM: Utilities.getcurrentDate(),
            Constants.DATE_TO: Utilities.getNextYearDate()
        ]
        
        if case .requestParameters(let specificParams) = target.task {
            parameters.merge(specificParams) { (_, new) in new }
        }
        return parameters
    }
    
    /// Handles GET Request: Adds parameters to the URL
    private static func configureQueryParameters(request: inout URLRequest, parameters: [String: Any]) throws {
        guard let url = request.url,
              var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw AppErrorType.invalidURL
        }
        
        components.queryItems = parameters.map {
            URLQueryItem(name: $0.key, value: "\($0.value)")
        }
        request.url = components.url
    }
    
    /// Handles POST/PUT Request: Adds parameters to the HTTP Body
    private static func configureBodyParameters(request: inout URLRequest, parameters: [String: Any]) {
        request.httpBody = parameters.percentEncoded()
    }
}

// MARK: - Extensions

/// Moves the ugly string formatting logic out of the main class
private extension Dictionary where Key == String, Value == Any {
    func percentEncoded() -> Data? {
        let parameterArray = self.map { key, value in
            let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return "\(escapedKey)=\(escapedValue)"
        }
        return parameterArray.joined(separator: "&").data(using: .utf8)
    }
}
