//
//  MovieDetailContracts.swift
//  MovieApp
//
//  Created by ArdaSisli on 4.08.2022.
//

import Foundation
import UIKit

//MARK: - ViewModel

protocol MovieDetailViewModelProtocol {
    var view: MovieDetailViewControllerProtocol? { get }
    func loadDetail()
    func loadCast()
    func loadVideo()
    func getVideo() -> String
    func getCastList() -> String
    func getMovieDetailName() -> String
    func getRating() -> String
    func getOverview() -> String
    func getTVDetailName() -> String
    func getTVRating() -> String
    func getTVOverview() -> String 
}

//MARK: ViewController

protocol MovieDetailViewControllerProtocol {
    func handleOutPut(_ output: MovieListProviderOutPut)
    func casthandleOutPut(_ output: MovieCastProviderOutPut)
    func videohandleOutPut(_ output: MovieVideoProviderOutPut)
    func tvDetailhandleOutPut(_ output: TVDetailProviderOutPut)
}

