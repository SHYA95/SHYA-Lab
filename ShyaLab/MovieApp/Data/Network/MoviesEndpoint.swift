//
//  MoviesEndpoint.swift
//  MovieApp
//
//  Created by Shrouk Yasser on 25/11/2025.
//

import Foundation

enum MoviesEndpoint: TargetType {
    case nowPlaying
    case popular
    case upcoming
    case details(id: Int)
    
    var baseURL: String {
        return Constant.baseURL
    }
    
    var path: String {
        switch self {
        case .nowPlaying: return "/movie/now_playing"
        case .popular: return "/movie/popular"
        case .upcoming: return "/movie/upcoming"
        case .details(let id): return "/movie/\(id)"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: Task {
       switch self {
        case .nowPlaying, .popular, .upcoming:
            return .requestParameters(parameters: ["language": "en-US", "page": 1])
        case .details:
            return .requestParameters(parameters: ["language": "en-US"])
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
