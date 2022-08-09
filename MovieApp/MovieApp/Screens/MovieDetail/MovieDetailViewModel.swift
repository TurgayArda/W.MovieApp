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
    var id: Int?
    var service: MovieDetailServiceProtocol?
    var castService: MovieCastServiceProtocol?
    var videoService: MovieVideoServiceProtocol?
    var detail: MovieDetailResult?
    var castData: [Cast] = []
    var videoData: [Video] = []
    
    init(view: MovieDetailViewControllerProtocol, id: Int,  service: MovieDetailServiceProtocol, castService: MovieCastServiceProtocol, videoService: MovieVideoServiceProtocol) {
        self.id = id
        self.view = view
        self.service = service
        self.castService = castService
        self.videoService = videoService
    }
}

//MARK: -  loadVideo()

extension MovieDetailViewModel {
    func loadVideo() {
        guard let movieID = id else { return }
        videoService?.fetchAllData(path: movieID, onSuccess: { [view] video in
            self.videoData = video
            view?.videohandleOutPut(.videoSelect(self.videoData))
        }, onError: { [view] error in
            view?.videohandleOutPut(.videoError(error))
        })
    }
}

//MARK: -  loadCast()

extension MovieDetailViewModel {    
    func loadCast() {
        guard let movieID = id else { return }
        castService?.fetchAllData(path: movieID, onSuccess: { [view] cast in
            self.castData = cast
            view?.casthandleOutPut(.castSelect(self.castData))
        }, onError: { [view] error in
            view?.casthandleOutPut(.castError(error))
        })
    }
}

//MARK: -  loadDetail()

extension MovieDetailViewModel {
    func loadDetail() {
        guard let movieID = id else { return }
        service?.fetchAllData(path: movieID,
                              onSuccess: { [view] movieDetail in
            self.detail = movieDetail
            view?.handleOutPut(.select(movieDetail))
            guard let title = movieDetail.originalTitle else { return }
            view?.handleOutPut(.title(title))
        }, onError: { [view] error in
            view?.handleOutPut(.error(error))
        })
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
                castList += "\(name), "
            }else{
                castList += "\(MovieDetailConstant.PropertyLabel.unknown.rawValue)"
            }
        }
        return "\(MovieDetailConstant.PropertyLabel.cast.rawValue): \([castList])"
    }
    
    func getMovieDetailName() -> String {
        guard let name = detail?.originalTitle else {
            return "unknow"
        }
        
        return name
    }
    
    func getRating() -> String {
        guard let rating = detail?.voteAverage else {
            return "unknow"
        }
        
        return "\(rating)"
    }
    
    func getOverview() -> String {
        guard let overview = detail?.overview else {
            return "unknow"
        }
        
        return overview
    }
    
    func getImage(movieImage: UIImageView) -> UIImageView {      
        guard let backdropPath = detail?.backdropPath else {
            movieImage.image = UIImage(named: "NoImage")
            return movieImage
        }
        if let url = URL(string: MovieDetailConstant.profileImage.pathImage(path: backdropPath)) {
            movieImage.af.setImage(withURL: url)
        }
        return   movieImage
    }
}

