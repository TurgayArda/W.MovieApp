//
//  MovieGenreModel.swift
//  MovieApp
//
//  Created by ArdaSisli on 7.08.2022.
//

import Foundation

// MARK: - MovieResult

struct GenreResult: Codable {
    let genres: [Genres]?
}

// MARK: - Genre

struct Genres: Codable {
    let id: Int?
    let name: String?
}


