//
//  NetworkManager.swift
//  NikeTop100
//
//  Created by Augustus Wilson on 6/27/20.
//  Copyright © 2020 Augustus Wilson. All rights reserved.
//

import Foundation

enum CustomError : Error {
    case invalidUrl
    case noConnection
    case badRequest
    case noData
    case unknown
    case serverDown
    case decodeError
    case serverError
    
    var localizedDescription: String {
        var description = "Error Occured"
        switch self {
        case .invalidUrl:
            description = "Error Occured (Code 1)"
        case .noConnection:
            description = "No Internet Connection"
            
        case .badRequest:
            description = "Error Occured (Code 3)"
            
        case .noData:
            description = "Error Occured (Code 4) "
            
        case .unknown:
            description = "Error Occured (Code 5)"
            
        case .serverDown:
            description = "Error Occured (Code 6)"
            
        case .decodeError:
            description = "Error Occured (Code 7)"
            
        case .serverError:
            description = "Error Occured (Code 8)"
        }
        return description;
    }
}

protocol HTTPClient {
    func get(url:String, queryParameters:[String:String]?, completion: @escaping ((Result<Data,CustomError>)->Void));
}

class URLSessionNetworkClient : HTTPClient {
    
    private var urlSession : URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func get(url:String, queryParameters:[String:String]?, completion: @escaping ((Result<Data,CustomError>)->Void))  {
        guard let url = URL(string: url)  else {
            return completion(.failure(.invalidUrl));
        }
        let dataTask = urlSession.dataTask(with: url) { [weak self ](data, response, error) in
            self?.processResponse(response, data,error,completion: completion);
        }
        
        dataTask.resume();
    }
    
    private func processResponse(_ response: URLResponse?,
                                 _ data: Data?,
                                 _ error : Error?,
                                 completion:  @escaping ((Result<Data, CustomError>) -> Void)) {
        if let _ = error {
            return completion(.failure(.serverError))
        }
        else if let httpResponse = response as? HTTPURLResponse {
            switch(httpResponse.statusCode) {
            case 200:
                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(.noData))
                }
                break;
            case 400:
                completion(.failure(.badRequest))
            case 503:
                completion(.failure(.serverDown))
            default :
                completion(.failure(.unknown));
            }
        }
    }
    
}

