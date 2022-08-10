//
//  MovieDetailBuilder.swift
//  MovieApp
//
//  Created by ArdaSisli on 4.08.2022.
//

import Foundation

final class MovieDetailBuilder {
    static func make(value: Any) -> MovieDetailVC {
        let view = MovieDetailVC()
        view.movieDetailViewModel = MovieDetailViewModel(view: view, value: value, httpClient: HttpClient())
        return view
    }
}
