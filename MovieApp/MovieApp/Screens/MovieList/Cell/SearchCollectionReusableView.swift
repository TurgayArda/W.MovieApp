//
//  SearchCollectionReusableView.swift
//  MovieApp
//
//  Created by ArdaSisli on 9.08.2022.
//

import UIKit

class SearchCollectionReusableView: UICollectionReusableView {
    static let identifier = "CollectionViewHeaderView"
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.alpha = 1
        return label
    }()
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(titleLabel)

            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
