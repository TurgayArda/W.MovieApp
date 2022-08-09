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
    var person: Person?
    
    init( personID: Int, personService: MoviePersonServiceProtocol) {
        self.personID = personID
        self.personService = personService
    }
}

extension MoviePersonViewModel {
    func loadPerson() {
        guard let id = personID else { return }
        personService?.fetchAllData(path: id, onSuccess: { [delegate] person in
            self.person = person
            delegate?.handleOutPut(.selectPerson(person))
        }, onError: { [delegate] error in
            delegate?.handleOutPut(.errorPerson(error))
        })
    }
}

extension MoviePersonViewModel {
    func getProperty() -> String {
        switch person?.gender {
        case 1:
            return "Female"
        case 2:
            return "Male"
        default:
            return "unknow"
        }
    }
    
    func getPersonName() -> String {
        guard let name = person?.name else {
            return "unknow"
        }
        
        return name
    }
    
    func getBirthday() -> String {
        guard let birthday = person?.birthday else {
            return "unknow"
        }
        
        return birthday
    }
    
    func getBiography() -> String {
        guard let biography = person?.biography else {
            return "unknow"
        }
        
        return biography
    }
}
