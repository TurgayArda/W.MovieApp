//
//  MovieDetailService.swift
//  MovieApp
//
//  Created by ArdaSisli on 5.08.2022.
//

import Foundation
import Alamofire

protocol MovieDetailServiceProtocol {
    func fetchAllData(
        path: (Int),
        onSuccess: @escaping (MovieDetailResult) -> Void,
        onError: @escaping (String) -> Void
         )
}

class MovieDetailService: MovieDetailServiceProtocol {
    func fetchAllData(path: (Int),
                      onSuccess: @escaping (MovieDetailResult) -> Void,
                      onError: @escaping (String) -> Void
         ) {
        
        AF.request(MovieNetworkConstant.MovieDetailNetwork.movieDetailURL(id: path), method: .get).responseDecodable(of: MovieDetailResult.self) { game in
            guard let data = game.value else {
                return onError("Error")
            }
            
            onSuccess(data)
        }
    }
}
