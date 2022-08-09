//
//  MovieListConstant.swift
//  MovieApp
//
//  Created by ArdaSisli on 4.08.2022.
//

import Foundation

final class MovieListConstant {
    enum PropertyLabel: String {
        case name = "Movie Name: Unknown"
        case empty = "Not Movie"
        case rating = "Rating"
        case unknown = "Unknown"
    }
    
    enum searchBar: String {
        case placeholder = "Search"
    }
    
    enum profileImage: String {
        case basic_url =   "https://image.tmdb.org/t/p/"
        case path_url =  "original"
        
        static func pathImage(path: String) -> String {
            return "\(basic_url.rawValue)\(path_url.rawValue)\(path)"
        }
    }
}
