//
//  MovieCastService.swift
//  MovieApp
//
//  Created by ArdaSisli on 6.08.2022.
//

import Foundation
import Alamofire

protocol MovieCastServiceProtocol {
    func fetchAllData(
        path: (Int),
        onSuccess: @escaping ([Cast]) -> Void,
        onError: @escaping (String) -> Void
         )
}

class MovieCastService: MovieCastServiceProtocol {
    func fetchAllData(path: (Int),
                      onSuccess: @escaping ([Cast]) -> Void,
                      onError: @escaping (String) -> Void
         ) {
        
        AF.request(MovieNetworkConstant.MovieCastNetwork.movieCastURL(id: path), method: .get).responseDecodable(of: MovieCastResult.self) { cast in
            guard let data = cast.value else {
                return onError("Error")
            }
            guard let castData = data.cast else { return }
            onSuccess(castData)
        }
    }
}
