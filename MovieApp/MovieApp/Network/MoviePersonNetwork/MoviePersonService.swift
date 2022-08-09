//
//  MoviePersonService.swift
//  MovieApp
//
//  Created by ArdaSisli on 7.08.2022.
//

import Foundation
import Alamofire

protocol MoviePersonServiceProtocol {
    func fetchAllData(
        path: (Int),
        onSuccess: @escaping (Person) -> Void,
        onError: @escaping (String) -> Void
         )
}

class MoviePersonService: MoviePersonServiceProtocol {
    func fetchAllData(path: (Int),
                      onSuccess: @escaping (Person) -> Void,
                      onError: @escaping (String) -> Void
         ) {
        
        AF.request(MovieNetworkConstant.MoviePersonNetwork.moviePersonURL(id: path), method: .get).responseDecodable(of: Person.self) { person in
            guard let data = person.value else {
                return onError("Error")
            }
            onSuccess(data)
        }
    }
}
