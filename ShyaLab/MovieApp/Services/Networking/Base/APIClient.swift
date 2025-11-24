//
//  APIClient.swift
//  SwiftUICombineApp
//
//  Created by Shrouk Yasser on 24/11/2025.
//

import Foundation

class APIClient<T: TargetType> {
    
  func performRequest<M: Decodable>(target: T) async throws -> M {
       guard InternetReachability.shared.isInternetAvailable else {
            throw AppErrorType.internetConnectionError
        }
        let request = try RequestBuilder.buildRequest(for: target)
        
        // 3. Execute Request
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            #if DEBUG
            logResponse(data: data)
            #endif
            
            return try validateAndDecode(data: data, response: response)
            
        } catch let error as AppErrorType {
            throw error
        } catch {
            throw AppErrorType.genericError
        }
    }
    
    // MARK: - Private Helpers
    
    private func validateAndDecode<M: Decodable>(data: Data, response: URLResponse) throws -> M {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw AppErrorType.genericError
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return try JSONDecoder().decode(M.self, from: data)
            
        case 500...599:
            throw AppErrorType.serverError
            
        default:
            if let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: data),
               let message = errorModel.message?.value {
                throw AppErrorType.responseError(message)
            }
            throw AppErrorType.genericError
        }
    }
    
    private func logResponse(data: Data) {
        if let responseStr = String(data: data, encoding: .utf8) {
            print("--- API RESPONSE ---")
            print(responseStr)
            print("--------------------")
        }
    }
}
