//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by ArdaSisli on 4.08.2022.
//

import Foundation

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    var view: MovieDetailViewControllerProtocol?
    var id: Int?
    var service: MovieDetailServiceProtocol?
    var castService: MovieCastServiceProtocol?
    var videoService: MovieVideoServiceProtocol?
    
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
            view?.videohandleOutPut(.videoSelect(video))
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
            view?.casthandleOutPut(.castSelect(cast))
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
                              onSuccess: { [view] movie in
            view?.handleOutPut(.select(movie))
            guard let title = movie.originalTitle else { return }
            view?.handleOutPut(.title(title))
        }, onError: { [view] error in
            view?.handleOutPut(.error(error))
        })
    }
}
