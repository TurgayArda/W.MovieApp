//
//  MovieGenreService.swift
//  MovieApp
//
//  Created by ArdaSisli on 7.08.2022.
//

import Foundation
import Alamofire

protocol MovieGenreServiceProtocol {
    func fetchAllData(success: @escaping ([Genres]) -> Void,
                      fail: @escaping (String) -> Void
    )
}

class MovieGenreService: MovieGenreServiceProtocol {
    public func fetchAllData(success: @escaping ([Genres]) -> Void,
                             fail: @escaping (String) -> Void
    ) {
        
        AF.request(MovieNetworkConstant.MovieGenretNetwork.movieGenreURL(), method: .get).responseDecodable(of: GenreResult.self) { (genre) in
            guard let data = genre.value else {
                return fail("Search result failed")
            }
            guard let genreData = data.genres else { return }
            let value = genreData
         success(value)
        }
    }
}
