//
//  NetworkManager.swift
//  StudyTCA
//
//  Created by KANO on 2023/10/04.
//

import Foundation
import Alamofire
import Combine
import ComposableArchitecture

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    enum APIError: Error {
        case requestFailed
        case invalidResponse
        case decodingError
    }
    
    
    
    func fetchData<T: Decodable>(from url:URL, _ type:T.Type) async throws -> Result<T, AFError> {
        
        return await AF.request(url).serializingDecodable(type).result
    }
    
    func fetchData<T: Decodable>(from url: URL) -> AnyPublisher<T, Error> {
        
    
        
        return Future<T, Error> { promise in
            
           
            
            
            AF.request(url).responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    promise(.success(data))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
