//
//  MovieDetailBuilder.swift
//  MovieApp
//
//  Created by ArdaSisli on 4.08.2022.
//

import Foundation

final class MovieDetailBuilder {
    static func make(id: Int) -> MovieDetailVC {
        let view = MovieDetailVC()
        view.movieDetailViewModel = MovieDetailViewModel(view: view, id: id, service: MovieDetailService(), castService: MovieCastService(), videoService: MovieVideoService())
        return view
    }
}
