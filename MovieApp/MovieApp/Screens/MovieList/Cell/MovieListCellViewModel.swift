//
//  MovieListCellViewModel.swift
//  MovieApp
//
//  Created by ArdaSisli on 10.08.2022.
//

import Foundation

protocol MovieListCollectionCellViewModelProtocol {
    func getMovieName(movie: Movie) -> String
    func getMovieRating(movie: Movie) -> String
    func getSearchMovieRating(movie: Movie) -> String
    func getSearchMovieName(movie: Movie) -> String
    func getTVName(tv: TV) -> String
    func getTVRating(tv: TV) -> String
    func getPersonName(person: KnownFor) -> String
    func getPersonRating(person: KnownFor) -> String
}

class MovieListCollectionCellViewModel: MovieListCollectionCellViewModelProtocol {
    func getMovieName(movie: Movie) -> String {
        guard let name = movie.title else {
            return MovieListConstant.PropertyLabel.unknown.rawValue
        }
        
        return name
    }
    
    func getMovieRating(movie: Movie) -> String {
        guard let rating = movie.voteAverage else {
            return MovieListConstant.PropertyLabel.unknown.rawValue
        }
        
        return "\(MovieListConstant.PropertyLabel.rating.rawValue): \(rating)"
    }
}

extension MovieListCollectionCellViewModel {
    func getTVName(tv: TV) -> String {
        guard let name = tv.name else {
            return MovieListConstant.PropertyLabel.unknown.rawValue
        }
        
        return name
    }
    
    func getTVRating(tv: TV) -> String {
        guard let rating = tv.voteAverage else {
            return MovieListConstant.PropertyLabel.unknown.rawValue
        }
        
        return "\(MovieListConstant.PropertyLabel.rating.rawValue): \(rating)"
    }
}

extension MovieListCollectionCellViewModel {
    func getPersonName(person: KnownFor) -> String {
        guard let name = person.title else {
            return MovieListConstant.PropertyLabel.unknown.rawValue
        }
        
        return name
    }
    
    func getPersonRating(person: KnownFor) -> String {
        guard let rating = person.voteAverage else {
            return MovieListConstant.PropertyLabel.unknown.rawValue
        }
        
        return "\(MovieListConstant.PropertyLabel.rating.rawValue): \(rating)"
    }
}

extension MovieListCollectionCellViewModel {
    func getSearchMovieRating(movie: Movie) -> String {
        guard let rating = movie.voteAverage else {
            return MovieListConstant.PropertyLabel.unknown.rawValue
        }
        
        return "\(MovieListConstant.PropertyLabel.rating.rawValue): \(rating)"
    }
    
    func getSearchMovieName(movie: Movie) -> String {
        guard let name = movie.title else {
            return MovieListConstant.PropertyLabel.unknown.rawValue
        }
        
        return name
    }
}

 
