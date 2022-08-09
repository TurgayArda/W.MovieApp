//
//  MoviePersonViewModel.swift
//  MovieApp
//
//  Created by ArdaSisli on 7.08.2022.
//

import Foundation

final class MoviePersonViewModel: MoviePersonViewModelProtocol {
    var delegate: MoviePersonViewModelDelegate?
    var personID: Int?
    var personService: MoviePersonServiceProtocol?
    
    init( personID: Int, personService: MoviePersonServiceProtocol) {
        self.personID = personID
        self.personService = personService
    }
}

extension MoviePersonViewModel {
    func loadPerson() {
        guard let id = personID else { return }
        personService?.fetchAllData(path: id, onSuccess: { [delegate] person in
            delegate?.handleOutPut(.selectPerson(person))
        }, onError: { [delegate] error in
            delegate?.handleOutPut(.errorPerson(error))
        })
    }
}
