//
//  MoviePersonBuilder.swift
//  MovieApp
//
//  Created by ArdaSisli on 7.08.2022.
//

import Foundation

final class MoviePersonBuilder {
    static func make(personID: Int) -> MoviePersonVC {
        let view = MoviePersonVC()
        let viewModel = MoviePersonViewModel(personID: personID, personService: MoviePersonService())
        view.personVievModel = viewModel
        return view
    }
}
