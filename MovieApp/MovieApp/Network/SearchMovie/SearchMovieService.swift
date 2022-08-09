//
//  SearchMovieService.swift
//  MovieApp
//
//  Created by ArdaSisli on 8.08.2022.
//

import Foundation
import Alamofire

protocol SearchMovieServiceProtocol {
    func fetchAllData(
        path: (String),
        onSuccess: @escaping ([Movie]) -> Void,
        onError: @escaping (String) -> Void
         )
}

class SearchMovieService: SearchMovieServiceProtocol {
    func fetchAllData(path: (String),
                      onSuccess: @escaping ([Movie]) -> Void,
                      onError: @escaping (String) -> Void
         ) {
        AF.request(MovieNetworkConstant.SearchMovieNetwork.searchMovieURL(path: path), method: .get).responseDecodable(of: MovieResult.self) { searchMovie in
            guard let data = searchMovie.value else {
                return onError("Error")
            }
            guard let movieData = data.results else { return }
            let value = movieData
            onSuccess(value)
        }
    }
}
