//
//  MoviePersonConstant.swift
//  MovieApp
//
//  Created by ArdaSisli on 7.08.2022.
//

import Foundation

final class MoviePersonConstant {
    enum MovieDetailIMDBUrl: String {
        case basic_url =  "https://www.imdb.com/name/"
        case path_url =  "/?ref_=nv_sr_srsg_0"
        
        static func pathIMDB(id: String) -> String {
            return "\(basic_url.rawValue)\(id)\(path_url.rawValue)"
        }
    }
    
    enum IMDBButtonTitle: String {
        case titleIMDB = "IMDb Address"
    }
    
    enum PropertyLabel: String {
        case name = "Person Name"
        case gender = "Gender"
        case birthday = "Birthday"
        case description = "Description"
        case unknown = "Unknown"
        case male = "Male"
        case female = "Female"
    }
    
    enum profileImage: String {
        case basic_url =   "https://image.tmdb.org/t/p/"
        case path_url =  "original"
        
        static func pathImage(path: String) -> String {
            return "\(basic_url.rawValue)\(path_url.rawValue)\(path)"
        }
    }
}
