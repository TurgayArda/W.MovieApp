//
//  MovieDetailConstant.swift
//  MovieApp
//
//  Created by ArdaSisli on 4.08.2022.
//

import Foundation

final class MovieDetailConstant {
    enum PropertyLabel: String {
        case name = "Movie Name"
        case rating = "Rating"
        case description = "Description"
        case routerPersonButton = "Go To Person"
        case unknown = "Unknown"
        case cast = "Cast"
    }
    
    enum profileImage: String {
        case basic_url =   "https://image.tmdb.org/t/p/"
        case path_url =  "original"
        
        static func pathImage(path: String) -> String {
            return "\(basic_url.rawValue)\(path_url.rawValue)\(path)"
        }
    }
}
