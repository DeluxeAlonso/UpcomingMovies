//
//  APIClient.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

protocol APIClient {

    var session: URLSession { get }

    func fetch<T: Decodable>(with request: URLRequest,
                             decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void)

}

extension APIClient {

    typealias JSONTaskCompletionHandler = (Result<Decodable, APIError>) -> Void

    private func decodingTask<T: Decodable>(with request: URLRequest,
                                            decodingType: T.Type,
                                            completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, _ in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed))
                return
            }
            guard 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(APIError(response: httpResponse)))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let genericModel = try decoder.decode(decodingType, from: data)
                completion(.success(genericModel))
            } catch {
                completion(.failure(.requestFailed))
            }
        }
        return task
    }

    func fetch<T: Decodable>(with request: URLRequest,
                             decode: @escaping (Decodable) -> T?,
                             completion: @escaping (Result<T, APIError>) -> Void) {
        let task = decodingTask(with: request, decodingType: T.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let value = decode(json) {
                        completion(.success(value))
                    } else {
                        completion(.failure(.requestFailed))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }

}
