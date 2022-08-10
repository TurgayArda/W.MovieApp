//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by ArdaSisli on 4.08.2022.
//

import Foundation

final class MovieListViewModel: MovieListViewModelProtocol {
    var delegate: MovieListViewModelDelegate?
    var httpClient: HttpClientProtocol?
    var movieData: [Movie] = []
    var tvData: [TV] = []
    var personData: [PersonResult] = []
    
    
    init(httpClient: HttpClientProtocol) {
        self.httpClient = httpClient
    }
}

//MARK: - searchMovieLoad(path: String)

extension MovieListViewModel {
    func searchMovieLoad(path: String) {
        guard let url = URL(string: MovieNetworkConstant.SearchMovieNetwork.searchMovieURL(path: path)) else { return }
        httpClient?.fetch(url: url,
                          completion: { [delegate] (result: Result<MovieResult, Error>) in
            switch result {
            case .success(let movie):
                guard let movieDataTwo =  movie.results else { return }
                self.movieData = movieDataTwo
                delegate?.searchMovieHandleOutPut(.searchMovie(self.movieData))
            case .failure(let error):
                delegate?.searchMovieHandleOutPut(.showError(error.localizedDescription))
            }
        })
    }
}

//MARK: - searchTVLoad(path: String)

extension MovieListViewModel {
    func searchTVLoad(path: String) {
        guard let url = URL(string: MovieNetworkConstant.SearchTVNetwork.searchTVURL(path: path)) else { return }
        httpClient?.fetch(url: url,
                          completion: { [delegate] (result: Result<SearchTVResult, Error>) in
            switch result {
            case .success(let tv):
                guard let tvDataTwo =  tv.results else { return }
                self.tvData = tvDataTwo
                delegate?.searchTVHandleOutPut(.searchTV(self.tvData))
            case .failure(let error):
                delegate?.searchTVHandleOutPut(.showError(error.localizedDescription))
            }
        })
    }
}

//MARK: - searchPersonLoad(path: String)

extension MovieListViewModel {
    func searchPersonLoad(path: String) {
        guard let url = URL(string: MovieNetworkConstant.SearchPersonNetwork.searchPersonURL(path: path)) else { return }
        httpClient?.fetch(url: url,
                          completion: { [delegate] (result: Result<SearchPersonResult, Error>) in
            switch result {
            case .success(let person):
                guard let personDataTwo =  person.results else { return }
                self.personData = personDataTwo
                delegate?.searchPersonHandleOutPut(.searchPerson(self.personData))
            case .failure(let error):
                delegate?.searchPersonHandleOutPut(.showError(error.localizedDescription))
            }
        })
    }
}

//MARK: - load()

extension MovieListViewModel {
    func load() {
        delegate?.handleOutPut(.isLoading(true))
        guard let url = URL(string: MovieNetworkConstant.MovieListNetwork.movieListURL()) else { return }
        httpClient?.fetch(url: url,
                          completion: { [delegate] (result: Result<MovieResult, Error>) in
            switch result {
            case .success(let movie):
                guard let movieDataTwo =  movie.results else { return }
                self.movieData = movieDataTwo
                delegate?.handleOutPut(.showMovieList(self.movieData))
                delegate?.handleOutPut(.isLoading(false))
            case .failure(let error):
                delegate?.handleOutPut(.isLoading(false))
                delegate?.handleOutPut(.showError(error.localizedDescription))
            }
        })
    }
}
