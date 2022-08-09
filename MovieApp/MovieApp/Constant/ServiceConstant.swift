//
//  ServiceConstant.swift
//  MovieApp
//
//  Created by ArdaSisli on 4.08.2022.
//

import Foundation


final class MovieNetworkConstant {
    
// https://api.themoviedb.org/3/movie/popular?api_key=f09395f99e2e0bc1292fc2a23beeacc3

enum MovieListNetwork: String {
    case path_url = "https://api.themoviedb.org/3/"
    case type_url = "movie/popular"
    case key_url = "?api_key=f09395f99e2e0bc1292fc2a23beeacc3"
    
    static func movieListURL() -> String {
        return "\(path_url.rawValue)\(type_url.rawValue)\(key_url.rawValue)"
        }
    }
    
// https://api.themoviedb.org/3/search/movie?api_key=f09395f99e2e0bc1292fc2a23beeacc3&query=avengers
    
   
    
    enum SearchMovieNetwork: String {
        case path_url = "https://api.themoviedb.org/3/"
        case type_url = "search/movie"
        case key_url = "?api_key=f09395f99e2e0bc1292fc2a23beeacc3"
        case query_url = "&query="
        
        static func searchMovieURL(path: String) -> String {
            return "\(path_url.rawValue)\(type_url.rawValue)\(key_url.rawValue)\(query_url.rawValue)\(path)"
            }
        }
    
// https://api.themoviedb.org/3/search/tv?api_key=f09395f99e2e0bc1292fc2a23beeacc3&query=ar

    
    enum SearchTVNetwork: String {
        case path_url = "https://api.themoviedb.org/3/"
        case type_url = "search/tv"
        case key_url = "?api_key=f09395f99e2e0bc1292fc2a23beeacc3"
        case query_url = "&query="
        
        static func searchTVURL(path: String) -> String {
            return "\(path_url.rawValue)\(type_url.rawValue)\(key_url.rawValue)\(query_url.rawValue)\(path)"
            }
        }
    
// https://api.themoviedb.org/3/search/person?api_key=f09395f99e2e0bc1292fc2a23beeacc3&query=Chris
    
    enum SearchPersonNetwork: String {
        case path_url = "https://api.themoviedb.org/3/"
        case type_url = "search/person"
        case key_url = "?api_key=f09395f99e2e0bc1292fc2a23beeacc3"
        case query_url = "&query="
        
        static func searchPersonURL(path: String) -> String {
            return "\(path_url.rawValue)\(type_url.rawValue)\(key_url.rawValue)\(query_url.rawValue)\(path)"
            }
        }
    
// https://api.themoviedb.org/3/genre/movie/list?api_key=f09395f99e2e0bc1292fc2a23beeacc3
    
    enum MovieGenretNetwork: String {
        case path_url = "https://api.themoviedb.org/3/"
        case type_url = "genre/movie/list"
        case key_url = "?api_key=f09395f99e2e0bc1292fc2a23beeacc3"
        
        static func movieGenreURL() -> String {
            return "\(path_url.rawValue)\(type_url.rawValue)\(key_url.rawValue)"
            }
        }
    
    
// https://api.themoviedb.org/3/movie/616037?api_key=f09395f99e2e0bc1292fc2a23beeacc3
    
    enum MovieDetailNetwork: String {
        case path_url = "https://api.themoviedb.org/3/"
        case type_url = "movie/"
        case key_url = "?api_key=f09395f99e2e0bc1292fc2a23beeacc3"
        
        static func movieDetailURL(id: Int) -> String {
            return "\(path_url.rawValue)\(type_url.rawValue)\(id)\(key_url.rawValue)"
            }
    }
    
// https://api.themoviedb.org/3/movie/616037/credits?api_key=f09395f99e2e0bc1292fc2a23beeacc3
    
    enum MovieCastNetwork: String {
        case path_url = "https://api.themoviedb.org/3/"
        case type_url = "movie/"
        case credits_url = "/credits"
        case key_url = "?api_key=f09395f99e2e0bc1292fc2a23beeacc3"
        
        static func movieCastURL(id: Int) -> String {
            return "\(path_url.rawValue)\(type_url.rawValue)\(id)\(credits_url.rawValue)\(key_url.rawValue)"
            }
    }
    
    // https://api.themoviedb.org/3/movie/361743/videos?api_key=f09395f99e2e0bc1292fc2a23beeacc3
    
    enum MovieVideoNetwork: String {
        case path_url = "https://api.themoviedb.org/3/"
        case type_url = "movie/"
        case videos_url = "/videos"
        case key_url = "?api_key=f09395f99e2e0bc1292fc2a23beeacc3"
        
        static func movieVideoURL(id: Int) -> String {
            return "\(path_url.rawValue)\(type_url.rawValue)\(id)\(videos_url.rawValue)\(key_url.rawValue)"
            }
    }
    
// https://api.themoviedb.org/3/person/74568?api_key=f09395f99e2e0bc1292fc2a23beeacc3
    
    enum MoviePersonNetwork: String {
        case path_url = "https://api.themoviedb.org/3/"
        case type_url = "person/"
        case key_url = "?api_key=f09395f99e2e0bc1292fc2a23beeacc3"
        
        static func moviePersonURL(id: Int) -> String {
            return "\(path_url.rawValue)\(type_url.rawValue)\(id)\(key_url.rawValue)"
            }
    }
}
