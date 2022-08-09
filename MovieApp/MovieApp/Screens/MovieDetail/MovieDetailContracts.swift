//
//  MovieDetailContracts.swift
//  MovieApp
//
//  Created by ArdaSisli on 4.08.2022.
//

import Foundation

//MARK: - ViewModel

protocol MovieDetailViewModelProtocol {
    var view: MovieDetailViewControllerProtocol? { get }
    func loadDetail()
    func loadCast()
    func loadVideo()
}

//MARK: ViewController

protocol MovieDetailViewControllerProtocol {
    func handleOutPut(_ output: MovieListProviderOutPut)
    func casthandleOutPut(_ output: MovieCastProviderOutPut)
    func videohandleOutPut(_ output: MovieVideoProviderOutPut)
}

