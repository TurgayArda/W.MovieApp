//
//  MovieVideoService.swift
//  MovieApp
//
//  Created by ArdaSisli on 6.08.2022.
//

import Foundation
import Alamofire

protocol MovieVideoServiceProtocol {
    func fetchAllData(
        path: (Int),
        onSuccess: @escaping ([Video]) -> Void,
        onError: @escaping (String) -> Void
         )
}

class MovieVideoService: MovieVideoServiceProtocol {
    func fetchAllData(path: (Int),
                      onSuccess: @escaping ([Video]) -> Void,
                      onError: @escaping (String) -> Void
         ) {
        
        AF.request(MovieNetworkConstant.MovieVideoNetwork.movieVideoURL(id: path), method: .get).responseDecodable(of: MovieVideoResult.self) { video in
            guard let data = video.value else {
                return onError("Error")
            }
            guard let video = data.results else { return }
            let value = video
            onSuccess(value)
        }
    }
}
