//
//  MovieListContracts.swift
//  MovieApp
//
//  Created by ArdaSisli on 4.08.2022.
//

import UIKit

//MARK: - ViewModel
protocol MovieListViewModelProtocol {
    var delegate: MovieListViewModelDelegate? { get set }
    func load()
    func searchMovieLoad(path: String)
    func searchTVLoad(path: String)
    func searchPersonLoad(path: String)
}

enum MovieListViewModelOutPut {
    case showMovieList([Movie])
    case showError(String)
    case isLoading(Bool)
}

enum SearchMovieViewModelOutPut {
    case searchMovie([Movie])
    case showError(String)
}

enum SearchTViewModelOutPut {
    case searchTV([TV])
    case showError(String)
}

enum SearchPersonViewModelOutPut {
    case searchPerson([PersonResult])
    case showError(String)
}

protocol MovieListViewModelDelegate {
    func handleOutPut(_ output: MovieListViewModelOutPut)
    func searchMovieHandleOutPut(_ output: SearchMovieViewModelOutPut)
    func searchTVHandleOutPut(_ output: SearchTViewModelOutPut)
    func searchPersonHandleOutPut(_ output: SearchPersonViewModelOutPut)
}

//MARK: - Provider
protocol MovieListProviderProtocol {
    var delegate: MovieListProviderDelegate? { get set }
    func load(value: [Movie])
    func loadSearch(value:  [String : [Any]])
    func loadTitle(title: [String])
    func isSearch(to search: Bool)
}

enum MovieListProviderOutPut {
    case select(MovieDetailResult)
    case title(String)
    case error(String)
}

enum TVDetailProviderOutPut {
    case select(TVDetailResult)
    case title(String)
    case error(String)
}

enum MovieCastProviderOutPut {
    case castSelect([Cast])
    case castError(String)
}

enum MovieVideoProviderOutPut {
    case videoSelect([Video])
    case videoError(String)
}


protocol MovieListProviderDelegate {
    func selected(at select: Any)
    func getWidth() -> CGFloat
}


