//
//  Resources.swift
//  SwiftUICombineApp
//
//  Created by Shrouk Yasser on 11/10/2025.
//

import Foundation


/// That contains any constant.
///
enum Constant {
    
    /// BaseURL for requests.
    //
    
      static let baseURL = "https://api.football-data.org/v2/"
 
}



/// Status for download data.
///
enum DownloadStatus<Success, Failure> where Failure: Error {
    case progress(progress: Progress)
    case success(url: URL?)
    case failure(_ : Failure)
    
}



/// Any model to be converted to domain should conform to the same protocol.
///
protocol DomainConvertible {
    associatedtype DomainType

    /// Used to convert any model to a corresponding domain model
    ///
    func toDomain() -> DomainType
}



/// Any model to be converted to dictionary to send it as body in request.
///
protocol DictionaryConvertible {
    func toDictionary()-> [String: Any]
}
