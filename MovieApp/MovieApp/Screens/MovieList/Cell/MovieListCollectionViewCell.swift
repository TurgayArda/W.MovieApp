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
        if let rating = value.voteAverage {
            movieRating.text = "\(MovieListConstant.PropertyLabel.rating.rawValue): \(rating)"
        }
    
        if let name = value.title {
            movieName.text = name
        }
        if let image = value.backdropPath {
            if let url = URL(string: MovieListConstant.profileImage.pathImage(path: image)) {
                    movieimage.af.setImage(withURL: url)
            }
        }else{
            movieimage.image = UIImage(named: "NoImage")
        }
    }
    
    func propertyUITV(value: TV) {
        if let rating = value.voteAverage {
            movieRating.text = "\(MovieListConstant.PropertyLabel.rating.rawValue): \(rating)"
        }
    
        if let name = value.name {
            movieName.text = name
        }
        if let image = value.backdropPath {
            if let url = URL(string: MovieListConstant.profileImage.pathImage(path: image)) {
                    movieimage.af.setImage(withURL: url)
            }
        }else{
            movieimage.image = UIImage(named: "NoImage")
        }
    }
    
    func propertyUIPerson(value: KnownFor) {
        if let rating = value.voteAverage {
            movieRating.text = "\(MovieListConstant.PropertyLabel.rating.rawValue): \(rating)"
        }

        if let name = value.title {
            movieName.text = name
        }
        if let image = value.backdropPath {
            if let url = URL(string: MovieListConstant.profileImage.pathImage(path: image)) {
                    movieimage.af.setImage(withURL: url)
            }
        }else{
            movieimage.image = UIImage(named: "NoImage")
        }
    }
    
    
    func saveModel(value: Movie) {
       
        if let rating = value.voteAverage {
            movieRating.text = "\(MovieListConstant.PropertyLabel.rating.rawValue): \(rating)"
        }else{
            movieRating.text = "\(MovieListConstant.PropertyLabel.rating.rawValue): \(MovieListConstant.PropertyLabel.unknown.rawValue)"
        }
    
        if let name = value.title {
            movieName.text = name
        }else{
            movieName.text = MovieListConstant.PropertyLabel.name.rawValue
        }
     
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
