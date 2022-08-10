//
//  Service.swift
//  MovieApp
//
//  Created by ArdaSisli on 10.08.2022.
//

import Foundation
import Alamofire

enum HttpError: Error {
    case badURL, badResponse, errorDecodingData, invalidURL
}

protocol HttpClientProtocol {
    func fetch<T: Codable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
}

class HttpClient: HttpClientProtocol {
    func fetch<T: Codable>(url: URL,
                           completion: @escaping (Result<T, Error>) -> Void) {

        AF.request(url, method: .get).responseDecodable(of: T.self) { movie in
            guard let data = movie.value else {
                return completion(.failure(HttpError.errorDecodingData))
            }
            completion(.success(data))
        }
    }
}

