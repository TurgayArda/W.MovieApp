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
    var httpClient: HttpClientProtocol?
    var personData: Person?
    
    init( personID: Int, httpClient: HttpClientProtocol) {
        self.personID = personID
        self.httpClient = httpClient
    }
}

extension MoviePersonViewModel {
    func loadPerson() {
        guard let id = personID else { return }
        guard let url = URL(string: MovieNetworkConstant.MoviePersonNetwork.moviePersonURL(id: id)) else { return }
        httpClient?.fetch(url: url,
                          completion: { [delegate] (result: Result<Person, Error>) in
            switch result {
            case .success(let person):
                self.personData = person
                guard let personDataTwo = self.personData else { return }
                delegate?.handleOutPut(.selectPerson(personDataTwo))
            case .failure(let error):
                delegate?.handleOutPut(.errorPerson(error.localizedDescription))
                
            }
        })
    }
}

extension MoviePersonViewModel {
    func getProperty() -> String {
        switch personData?.gender {
        case 1:
            return "\(MoviePersonConstant.PropertyLabel.gender.rawValue): \(MoviePersonConstant.PropertyLabel.female.rawValue)"
        case 2:
            return"\(MoviePersonConstant.PropertyLabel.gender.rawValue): \(MoviePersonConstant.PropertyLabel.male.rawValue)" 
        default:
            return MoviePersonConstant.PropertyLabel.unknown.rawValue
        }
    }
    
    func getPersonName() -> String {
        guard let name = personData?.name else {
            return MoviePersonConstant.PropertyLabel.unknown.rawValue
        }
        
        return "\(MoviePersonConstant.PropertyLabel.name.rawValue): \(name)"
    }
    
    func getBirthday() -> String {
        guard let birthday = personData?.birthday else {
            return MoviePersonConstant.PropertyLabel.unknown.rawValue
        }
        
        return "\(MoviePersonConstant.PropertyLabel.birthday.rawValue): \(birthday)"
    }
    
    func getBiography() -> String {
        guard let biography = personData?.biography else {
            return MoviePersonConstant.PropertyLabel.unknown.rawValue
        }
        
        return biography
    }
}
