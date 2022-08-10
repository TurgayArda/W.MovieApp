//
//  MovieListCollectionViewCell.swift
//  MovieApp
//
//  Created by ArdaSisli on 5.08.2022.
//


import UIKit
import AlamofireImage
import SnapKit


class MovieListCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Views
    
    private lazy var movieRating: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .black
        contentView.addSubview(label)
        return label
    }()
    
    private lazy var movieimage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.backgroundColor = .white
        image.layer.cornerRadius = 8
        contentView.addSubview(image)
        return image
    }()
    
    private lazy var movieName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .left
        contentView.addSubview(label)
        return label
    }()
    
    var cellViewModel: MovieListCollectionCellViewModelProtocol?
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        return indicator
    }()
    
    enum Identifier: String {
        case path = "Cell"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.backgroundColor = .white
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.cornerRadius = 8
        makeImage()
        makeName()
        makeRating()
    }
    
    func propertyUIMovie(value: Movie) {
        movieRating.text = cellViewModel?.getSearchMovieRating(movie: value)
        movieName.text = cellViewModel?.getSearchMovieName(movie: value)
        
        if let image = value.backdropPath {
            if let url = URL(string: MovieListConstant.profileImage.pathImage(path: image)) {
                movieimage.af.setImage(withURL: url)
            }
        }else{
            movieimage.image = UIImage(named: "NoImage")
        }
    }
    
    func propertyUITV(value: TV) {
        movieRating.text = cellViewModel?.getTVRating(tv: value)
        movieName.text = cellViewModel?.getTVName(tv: value)
        
        if let image = value.backdropPath {
            if let url = URL(string: MovieListConstant.profileImage.pathImage(path: image)) {
                movieimage.af.setImage(withURL: url)
            }
        }else{
            movieimage.image = UIImage(named: "NoImage")
        }
    }
    
    func propertyUIPerson(value: KnownFor) {
        movieRating.text = cellViewModel?.getPersonRating(person: value)
        movieName.text = cellViewModel?.getPersonName(person: value)
        
        if let image = value.backdropPath {
            if let url = URL(string: MovieListConstant.profileImage.pathImage(path: image)) {
                movieimage.af.setImage(withURL: url)
            }
        }else{
            movieimage.image = UIImage(named: "NoImage")
        }
    }
    
    
    func saveModel(value: Movie) {
        movieRating.text = cellViewModel?.getMovieRating(movie: value)
        movieName.text = cellViewModel?.getMovieName(movie: value)
        
        if let image = value.backdropPath {
            if let url = URL(string: MovieListConstant.profileImage.pathImage(path: image)) {
                movieimage.af.setImage(withURL: url)
            }
        }else{
            movieimage.image = UIImage(named: "NoImage")
        }
    }
    
    func searchSaveModel(value: Any) {
        if let movieData = value as? Movie {
            propertyUIMovie(value: movieData)
        }
        else if let tvData = value as? TV {
            propertyUITV(value: tvData)
        }else{
            if let personData = value as? KnownFor {
                propertyUIPerson(value: personData)
            }
        }
    }
}

//MARK: - Constraints

extension MovieListCollectionViewCell {
    private func makeImage() {
        movieimage.snp.makeConstraints { make in
            make
                .left
                .equalTo(contentView)
                .offset(8)
            make
                .centerY
                .equalTo(contentView.snp.centerY)
            make
                .height
                .equalTo(contentView.frame.size.height / 1.4)
            make
                .width
                .equalTo(contentView.frame.size.width / 2.8)
        }
    }
    
    private func makeName() {
        movieName.snp.makeConstraints { make in
            make
                .centerY
                .equalTo(contentView.snp.centerY)
                .offset(-(contentView.frame.size.height / 2.8) + 8)
            make
                .left
                .equalTo(movieimage.snp.right)
                .offset(16)
            make
                .right
                .equalTo(contentView.snp.right)
                .offset(-16)
        }
    }
    
    private func makeRating() {
        movieRating.snp.makeConstraints { make in
            make
                .top
                .equalTo(movieName.snp.bottom)
                .offset(8)
            make
                .left
                .equalTo(movieimage.snp.right)
                .offset(16)
        }
    }
}
