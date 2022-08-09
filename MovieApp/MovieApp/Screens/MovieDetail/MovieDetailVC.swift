//
//  MovieDetailVC.swift
//  MovieApp
//
//  Created by ArdaSisli on 4.08.2022.
//

import UIKit
import AlamofireImage
import YouTubeiOSPlayerHelper

class MovieDetailVC: UIViewController {
    
    //MARK: - Views
    
    private var youtubePlayer: YTPlayerView = {
        let player = YTPlayerView()
        
        return player
    }()
    
    private var movieImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private var movieName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = "\(MovieDetailConstant.PropertyLabel.description.rawValue):"
        return label
    }()
    
    private lazy var movieDescription: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private var movieRating: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private var movieCastLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = .white
        scroll.contentSize = CGSize(width: 0 , height: view.frame.height)
        return scroll
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .lastBaseline //ararstir firist, last
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var routerPersonButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("\(MovieDetailConstant.PropertyLabel.routerPersonButton.rawValue)", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
        return button
    }()
    
    //MARK: - Properties
    
    var movieDetailViewModel: MovieDetailViewModelProtocol?
    var errorMessage: String = ""
    var errorCastMessage: String = ""
    var movieDetail: MovieDetailResult?
    var movieCast: [Cast] = []
    var movieCastList: String = ""
    var errorVideoMessage: String = ""
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieDetailViewModel?.loadDetail()
        movieDetailViewModel?.loadCast()
        movieDetailViewModel?.loadVideo()
        configure()
        routerButton()
    }
    
    //MARK: - Private Func
    
    private func routerButton() {
        routerPersonButton.addTarget(self, action: #selector(router(_:)), for: .touchUpInside)
    }
    
    @objc func router(_ routerPersonButton: UIButton) {
        guard let id = movieCast[0].id else { return }
        let personID = id
        let viewController = MoviePersonBuilder.make(personID: personID)
        viewController.modalPresentationStyle = .fullScreen
        self.show(viewController, sender: nil)
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(movieImage)
        stackView.addArrangedSubview(movieName)
        stackView.addArrangedSubview(movieRating)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(movieDescription)
        stackView.addArrangedSubview(movieCastLabel)
        stackView.addArrangedSubview(youtubePlayer)
        stackView.addArrangedSubview(routerPersonButton)
        makeScroll()
        makeStack()
        makeRouterButton()
        makePlayer()
        makeImage()
        
    }
    
    private func propertyUIVideo(movieVideo: [Video]) {
        if movieVideo.count == 0 {
            youtubePlayer.load(withVideoId: "jj6v5ky5u00")
        }else{
            if let key = movieVideo[0].key {
                let videoKey = key
                youtubePlayer.load(withVideoId: videoKey)
            }
        }
    }
    
    private func propertyUICast(movieCast: [Cast]) {
        for i in 0..<movieCast.count {
            if let name = movieCast[i].name {
                movieCastList += "\(name), "
            }else{
                movieCastList += "\(MovieDetailConstant.PropertyLabel.unknown.rawValue)"
            }
        }
        movieCastLabel.text = "\(MovieDetailConstant.PropertyLabel.cast.rawValue): \([movieCastList])"
    }
    
    
    private func propertyUIDetail(movieDetail: MovieDetailResult) {
        if let name = movieDetail.originalTitle  {
            movieName.text =  "\(MovieDetailConstant.PropertyLabel.name.rawValue): \(name)"
        }else{
            movieName.text =  "\(MovieDetailConstant.PropertyLabel.name.rawValue): \(MovieDetailConstant.PropertyLabel.unknown.rawValue)"
        }
        
        if let rating = movieDetail.voteAverage {
            movieRating.text = "\(MovieDetailConstant.PropertyLabel.rating.rawValue): \(rating)"
        }else{
            movieRating.text = "\(MovieDetailConstant.PropertyLabel.rating.rawValue): \(MovieDetailConstant.PropertyLabel.unknown.rawValue)"
        }
        
        if let overview = movieDetail.overview {
            movieDescription.text = overview
        }else{
            movieDescription.text = "\(MovieDetailConstant.PropertyLabel.unknown.rawValue)"
        }
        
        if let image = movieDetail.backdropPath {
            if let url = URL(string: MovieDetailConstant.profileImage.pathImage(path: image)) {
                movieImage.af.setImage(withURL: url)
            }
        }else{
            movieImage.image = UIImage(named: "NoImage")
        }
    }
}

//MARK: - MovieDetailViewControllerProtocol

extension MovieDetailVC: MovieDetailViewControllerProtocol {
    func handleOutPut(_ output: MovieListProviderOutPut) {
        switch output {
        case .select(let movieDetailResult):
            propertyUIDetail(movieDetail: movieDetailResult)
        case .title(let title):
            self.title = title
        case .error(let error):
            self.errorMessage = error
        }
    }
    
    func casthandleOutPut(_ output: MovieCastProviderOutPut) {
        switch output {
        case .castSelect(let cast):
            self.movieCast = cast
            propertyUICast(movieCast: cast)
        case .castError(let error):
            self.errorCastMessage = error
        }
    }
    
    func videohandleOutPut(_ output: MovieVideoProviderOutPut) {
        switch output {
        case .videoSelect(let video):
            propertyUIVideo(movieVideo: video)
        case .videoError(let error):
            self.errorVideoMessage = error
        }
    }
}

//MARK: - Constraints

extension MovieDetailVC {
    private func makeScroll() {
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view)
            make.right.equalTo(-8)
            make.left.equalTo(8)
            make.width.equalTo(view.frame.size.width)
        }
    }
    private func makeStack() {
        stackView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
        }
    }
   
    private func makeRouterButton() {
        routerPersonButton.snp.makeConstraints { make in
            make.height.equalTo(view.frame.size.height / 15)
            make.width.equalTo(view.frame.size.width / 3)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
   
    private func makePlayer() {
        youtubePlayer.snp.makeConstraints { make in
            make.height.equalTo(view.frame.size.height / 3)
            make.width.equalTo(view.frame.size.width / 1.1)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    
    private func makeImage() {
        movieImage.snp.makeConstraints { make in
            make.height.equalTo(view.frame.size.height / 3)
            make.width.equalTo(view.frame.size.width / 1.1)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
}
