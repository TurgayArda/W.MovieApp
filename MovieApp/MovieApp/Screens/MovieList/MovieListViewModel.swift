//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by ArdaSisli on 4.08.2022.
//

import Foundation

final class MovieListViewModel: MovieListViewModelProtocol {
    var delegate: MovieListViewModelDelegate?
    var service: MovieListServiceProtocol?
    var searchMovieService: SearchMovieServiceProtocol?
    var searchTVService: SearchTVServiceProtocol?
    var searchPersonService: SearchPersonServiceProtocol?
    
    init(service: MovieListServiceProtocol, searchMovieService: SearchMovieServiceProtocol, searchTVService: SearchTVServiceProtocol, searchPersonService: SearchPersonServiceProtocol) {
        self.service = service
        self.searchMovieService = searchMovieService
        self.searchTVService = searchTVService
        self.searchPersonService = searchPersonService
        
    }
}

//MARK: - searchMovieLoad(path: String)

extension MovieListViewModel {
    func searchMovieLoad(path: String) {
        searchMovieService?.fetchAllData(path: path, onSuccess: { [delegate] movie in
            delegate?.searchMovieHandleOutPut(.searchMovie(movie))
        }, onError: { [delegate] error in
            delegate?.searchMovieHandleOutPut(.showError(error))
        })
    }
}
    
//MARK: - searchTVLoad(path: String)

extension MovieListViewModel {
    func searchTVLoad(path: String) {
        searchTVService?.fetchAllData(path: path, onSuccess: { [delegate] tv in
            delegate?.searchTVHandleOutPut(.searchTV(tv))
        }, onError: { [delegate] error in
            delegate?.searchTVHandleOutPut(.showError(error))
        })
    }
}
    
//MARK: - searchPersonLoad(path: String)

extension MovieListViewModel {
    func searchPersonLoad(path: String) {
        searchPersonService?.fetchAllData(path: path, onSuccess: { [delegate] person in
            delegate?.searchPersonHandleOutPut(.searchPerson(person))
        }, onError: { [delegate] error in
            delegate?.searchPersonHandleOutPut(.showError(error))
        })
    }
}

//MARK: - load()

extension MovieListViewModel {
    func load() {
        delegate?.handleOutPut(.isLoading(true))
        service?.fetchAllData(success: { [delegate] data in
            delegate?.handleOutPut(.showMovieList(data))
            delegate?.handleOutPut(.isLoading(false))
        }, fail: { [delegate] error in
            delegate?.handleOutPut(.showError(error))
            delegate?.handleOutPut(.isLoading(false))
        })
    }
}
