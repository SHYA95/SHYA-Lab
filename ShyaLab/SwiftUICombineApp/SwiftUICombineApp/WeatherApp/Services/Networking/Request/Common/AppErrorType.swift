//
//  AppErrorType.swift
//  SwiftUICombineApp
//
//  Created by Shrouk Yasser on 11/10/2025.
//

import Foundation


/// Networking error types.
///
enum AppErrorType: Error {
    
    case genericError
    case internetConnectionError
    case serverError
    case invalidURL
    case responseError(String)
    
    var title: String {
        switch self {
        case .genericError, .invalidURL, .responseError:
            return  "Something went wrong"
        case .serverError:
            return "Server Error!"
        case .internetConnectionError:
            return  "Internet is failure!"
        }
    }
    
    var message: String {
        switch self {
        case .genericError, .invalidURL, .serverError:
            return  "Please try again.."
        case .internetConnectionError:
            return  "Please check your network connection."
        case .responseError(let message):
            return message
        }
    }
}



/// Response errors.
///
struct ErrorModel: Error, Codable {
    let message: Message?
}

enum Message: Codable {
    case string(String)
    case stringArray([String])
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        
        throw DecodingError.typeMismatch(Message.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Message"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        }
    }
    
    var value: String? {
        switch self {
        case .string(let string):
            return string
        case .stringArray(let array):
            return array.first
        }
    }
}


enum ErrorResponse: Codable {
    case str(String)
    case arr([String])
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let v = try? container.decode(String.self) {
            self = .str(v)
            return
        }
        
        
        if let v = try? container.decode([String].self) {
            self = .arr(v)
            return
        }
        
        throw DecodingError.typeMismatch( ErrorResponse.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Type is not matched", underlyingError: nil))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .str(let value):
            try container.encode(value)
        case .arr(let values):
            try container.encode(values)
        }
    }
    
    var value: String {
        switch self {
        case .str(let val):
            return val
        case .arr(let errors):
            return errors.first ?? ""
        }
    }
}

