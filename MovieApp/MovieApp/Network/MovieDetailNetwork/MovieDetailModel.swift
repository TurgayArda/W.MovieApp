//
//  MovieDetailModel.swift
//  MovieApp
//
//  Created by ArdaSisli on 5.08.2022.
//

import Foundation

    // MARK: - MovieDetailResult
    
    struct MovieDetailResult: Codable {
        let adult: Bool?
        let backdropPath: String?
        let budget: Int?
        let genres: [Genre]?
        let homepage: String?
        let id: Int?
        let imdbID, originalLanguage, originalTitle, overview: String?
        let popularity: Double?
        let posterPath: String?
        let productionCompanies: [ProductionCompany]?
        let releaseDate: String?
        let revenue, runtime: Int?
        let spokenLanguages: [SpokenLanguage]?
        let status, tagline, title: String?
        let video: Bool?
        let voteAverage: Double?
        let voteCount: Int?

        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case budget, genres, homepage, id
            case imdbID = "imdb_id"
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case productionCompanies = "production_companies"
            case releaseDate = "release_date"
            case revenue, runtime
            case spokenLanguages = "spoken_languages"
            case status, tagline, title, video
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }

    // MARK: - Genre
    
    struct Genre: Codable {
        let id: Int?
        let name: String?
    }

    // MARK: - ProductionCompany
    
    struct ProductionCompany: Codable {
        let id: Int?
        let logoPath: String?
        let name, originCountry: String?

        enum CodingKeys: String, CodingKey {
            case id
            case logoPath = "logo_path"
            case name
            case originCountry = "origin_country"
        }
    }

    // MARK: - SpokenLanguage
    
    struct SpokenLanguage: Codable {
        let englishName, iso639_1, name: String?

        enum CodingKeys: String, CodingKey {
            case englishName = "english_name"
            case iso639_1 = "iso_639_1"
            case name
        }
    }
