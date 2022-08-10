//
//  MovieListBuilder.swift
//  MovieApp
//
//  Created by ArdaSisli on 4.08.2022.
//

import Foundation

final class MovieListBuilder {
    static func make() -> MovieListVC {
        let view = MovieListVC()
        view.movieListViewModel = MovieListViewModel(httpClient: HttpClient())
        return view
    }
}
