//
//  MoviePersonContracts.swift
//  MovieApp
//
//  Created by ArdaSisli on 7.08.2022.
//

import Foundation

//MARK: - ViewModel

protocol MoviePersonViewModelProtocol {
    var delegate: MoviePersonViewModelDelegate? { get set}
    func loadPerson()
    func getPersonName() -> String
    func getProperty() -> String
    func getBirthday() -> String
    func getBiography() -> String
}

enum MoviePersonOutPut {
    case selectPerson(Person)
    case errorPerson(String)
}

protocol MoviePersonViewModelDelegate {
    func handleOutPut(_ output: MoviePersonOutPut)
}

