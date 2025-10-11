//
//  APIClient.swift
//  SwiftUICombineApp
//
//  Created by Shrouk Yasser on 11/10/2025.
//

import Foundation
import Alamofire

class APIClient<T: TargetType> {
    
    /// A generic method to perform requests with requestModels.
    /// - Pa drameters:
    ///   - target: It carries the data of the request you are performing.
    ///   - param: It is the parameters to be sent with the request.
    ///   - completion: That carries a success or failure response.
    ///
    func performRequest<M: Decodable, P: Encodable>(target: T, param: P?, completion: @escaping (Result<M, AppErrorType>) -> Void)  {
        InternetReachability.shared.InternetConnectivity { [weak self] in
            guard let self = self else { return }

            /// Create request properties.
            let url = target.baseURL + target.path
            let method = HTTPMethod(rawValue: target.method.rawValue)
            let headers: HTTPHeaders = [
                Constants.API_AUTH_KEY: Constants.API_AUTH_VALUE]
            let paramters = [Constants.DATE_FROM: Utilities.getcurrentDate(), Constants.DATE_TO: Utilities.getNextYearDate()]

            /// Create AF request.
            AF.request(url, method: method, parameters: paramters, encoder: URLEncodedFormParameterEncoder.default, headers: headers).responseDecodable(of: M.self) { response in
               
                debugPrint(response)

                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(_):
                    if let statusCode = response.response?.statusCode {
                        switch statusCode {
                        case 500...599:
                            completion(.failure(.serverError))
                        default:
                            completion(.failure(.genericError))
                        }
                    } else {
                        completion(.failure(.genericError))
                    }
                }
            }
        } failCompletion: { [weak self] in
            guard let self = self else { return }
            completion(.failure(.internetConnectionError))
        }
    }
}
