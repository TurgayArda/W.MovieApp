//
//  MovieService.swift
//  MovieApp
//
//  Created by ArdaSisli on 4.08.2022.
//

import Foundation
import Alamofire

protocol MovieListServiceProtocol {
    func fetchAllData(success: @escaping ([Movie]) -> Void,
                      fail: @escaping (String) -> Void
    )
}

class MovieListService: MovieListServiceProtocol {
    func fetchAllData(success: @escaping ([Movie]) -> Void,
                             fail: @escaping (String) -> Void
    ) {
        
        AF.request(MovieNetworkConstant.MovieListNetwork.movieListURL(), method: .get).responseDecodable(of: MovieResult.self) { (movie) in
            guard let data = movie.value else {
                return fail("Search result failed")
            }
            guard let movieData = data.results else { return }
            let value = movieData
         success(value)
        }
    }
}
