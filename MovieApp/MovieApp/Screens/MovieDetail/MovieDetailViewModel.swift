//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by ArdaSisli on 4.08.2022.
//

import Foundation
import UIKit

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    var view: MovieDetailViewControllerProtocol?
    var value: Any?
    var httpClient: HttpClientProtocol?
    var detail: MovieDetailResult?
    var castData: [Cast] = []
    var videoData: [Video] = []
    var detailURL: URL?
    var castURL: URL?
    var videoURL: URL?
    var tvDetail: TVDetailResult?
    
    
    init(view: MovieDetailViewControllerProtocol, value: Any, httpClient: HttpClientProtocol) {
        self.value = value
        self.view = view
        self.httpClient = httpClient
    }
}

//MARK: -  loadVideo()

extension MovieDetailViewModel {
    func url() {
        if let movieData = value as? Movie {
            guard let movieID = movieData.id else { return }
            guard let castURL = URL(string:MovieNetworkConstant.MovieCastNetwork.movieCastURL(id: movieID)) else { return }
            guard let videoURL = URL(string:MovieNetworkConstant.MovieVideoNetwork.movieVideoURL(id: movieID)) else { return }
            guard let detailURL = URL(string: MovieNetworkConstant.MovieDetailNetwork.movieDetailURL(id: movieID)) else { return }
            self.detailURL = detailURL
            self.castURL = castURL
            self.videoURL = videoURL
        }
        else if let tvData = value as? TV {
            guard let tvID = tvData.id else { return }
            guard let castURL = URL(string:MovieNetworkConstant.CastTVNetwork.castTVURL(id: tvID) ) else { return }
            guard let videoURL = URL(string:MovieNetworkConstant.VideoTVNetwork.videoTVURL(id: tvID)) else { return }
            guard let detailURL = URL(string:MovieNetworkConstant.DetailTVNetwork.detailTVURL(id: tvID)) else { return }
            self.detailURL = detailURL
            self.castURL = castURL
            self.videoURL = videoURL
        }else{
            if let personData = value as? KnownFor {
                guard let personID = personData.id else { return }
                guard let castURL = URL(string:MovieNetworkConstant.MovieCastNetwork.movieCastURL(id: personID)) else { return }
                guard let videoURL = URL(string:MovieNetworkConstant.MovieVideoNetwork.movieVideoURL(id: personID)) else { return }
                guard let detailURL = URL(string: MovieNetworkConstant.MovieDetailNetwork.movieDetailURL(id: personID)) else { return }
                self.detailURL = detailURL
                self.castURL = castURL
                self.videoURL = videoURL
            }
        }
    }
}

extension MovieDetailViewModel {
    func fetch<T:Codable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        httpClient?.fetch(url: url, completion: completion)
    }
}

extension MovieDetailViewModel {
    func loadVideo() {
        url()
        guard let url =  videoURL else { return }
        httpClient?.fetch(url: url,
                          completion: { [view] (result: Result<MovieVideoResult, Error>) in
            switch result {
            case .success(let video):
                guard let videoDataTwo = video.results else { return }
                self.videoData = videoDataTwo
                view?.videohandleOutPut(.videoSelect(self.videoData))
            case .failure(let error):
                view?.videohandleOutPut(.videoError(error.localizedDescription))
            }
        })
    }
}

//MARK: -  loadCast()

extension MovieDetailViewModel {    
    func loadCast() {
        url()
        guard let url =  castURL else { return }
        httpClient?.fetch(url: url,
                          completion: { [view] (result: Result<MovieCastResult, Error>) in
            switch result {
            case .success(let cast):
                guard let castDataTwo = cast.cast else { return }
                self.castData = castDataTwo
                view?.casthandleOutPut(.castSelect(self.castData))
            case .failure(let error):
                view?.casthandleOutPut(.castError(error.localizedDescription))
            }
        })
    }
}

//MARK: -  loadDetail()

extension MovieDetailViewModel {
    func loadDetail() {
        url()
        guard let url =  detailURL else { return }
        if let tvData = value as? TV {
            httpClient?.fetch(url: url,
                              completion: { [view] (result: Result<TVDetailResult, Error>) in
                switch result {
                case .success(let tvDetail):
                    self.tvDetail = tvDetail
                    guard let detailTwo = self.tvDetail else { return }
                    guard let title = detailTwo.name else { return }
                    view?.tvDetailhandleOutPut(.select(detailTwo))
                    view?.tvDetailhandleOutPut(.title(title))
                case .failure(let error):
                    view?.tvDetailhandleOutPut(.error(error.localizedDescription))
                }
            })
        }else{
            httpClient?.fetch(url: url,
                              completion: { [view] (result: Result<MovieDetailResult, Error>) in
                switch result {
                case .success(let movieDetail):
                    self.detail = movieDetail
                    guard let detailTwo = self.detail else { return }
                    guard let title = detailTwo.title else { return }
                    view?.handleOutPut(.select(detailTwo))
                    view?.handleOutPut(.title(title))
                case .failure(let error):
                    view?.handleOutPut(.error(error.localizedDescription))
                }
            })
        }
    }
}

extension MovieDetailViewModel {
    func getVideo() -> String {
        var keyTwo: String = ""
        
        if videoData.count == 0 {
            return "jj6v5ky5u00"
        }
        if let key = videoData[0].key {
            keyTwo = key
        }
        return keyTwo
    }
    
    func getCastList() -> String {
        var castList: String = ""
        
        for i in 0..<castData.count {
            if let name = castData[i].name {
                if i == castData.count - 1 {
                    castList += "\(name)"
                }else{
                    castList += "\(name), "
                }
            }else{
                castList += "\(MovieDetailConstant.PropertyLabel.unknown.rawValue)"
            }
        }
        
        return "\(MovieDetailConstant.PropertyLabel.cast.rawValue): \([castList])"
    }
    
    func getTVDetailName() -> String {
        guard let name = tvDetail?.name else {
            return MovieDetailConstant.PropertyLabel.unknown.rawValue
        }
        
        return "\(MovieDetailConstant.PropertyLabel.name.rawValue): \(name)"
    }
    
    func getTVRating() -> String {
        guard let rating = tvDetail?.voteAverage else {
            return MovieDetailConstant.PropertyLabel.unknown.rawValue
        }
        
        return "\(MovieDetailConstant.PropertyLabel.rating.rawValue): \(rating)"
    }
    
    func getTVOverview() -> String {
        guard let overview = tvDetail?.overview else {
            return MovieDetailConstant.PropertyLabel.unknown.rawValue
        }
        
        return overview
    }
    
    func getMovieDetailName() -> String {
        guard let name = detail?.originalTitle else {
            return MovieDetailConstant.PropertyLabel.unknown.rawValue
        }
        
        return "\(MovieDetailConstant.PropertyLabel.name.rawValue): \(name)"
    }
    
    func getRating() -> String {
        guard let rating = detail?.voteAverage else {
            return MovieDetailConstant.PropertyLabel.unknown.rawValue
        }
        
        return "\(MovieDetailConstant.PropertyLabel.rating.rawValue): \(rating)"
    }
    
    func getOverview() -> String {
        guard let overview = detail?.overview else {
            return MovieDetailConstant.PropertyLabel.unknown.rawValue
        }
        
        return overview
    }
}

