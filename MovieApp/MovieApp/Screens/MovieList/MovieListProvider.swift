//
//  MovieListProvider.swift
//  MovieApp
//
//  Created by ArdaSisli on 4.08.2022.
//

import UIKit

class MovieListProvider: NSObject {
    
    var delegate: MovieListProviderDelegate?
    var movieData: [Movie] = []
    var searchData = [String : [Any]]()
    var searchHeader: [String] = []
    var isSearch = false
}

extension MovieListProvider: MovieListProviderProtocol {
    func load(value: [Movie]) {
        self.movieData = value
    }
    
    func loadSearch(value: [String : [Any]]) {
        self.searchData = value
    }
    
    func loadTitle(title: [String]) {
        self.searchHeader = title
    }
    
    func isSearch(to search: Bool) {
        self.isSearch = search
    }
    
    func remove() {
        movieData.removeAll()
    }
}

extension MovieListProvider: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if isSearch {
            return searchHeader.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearch {
            guard let searchCount = (searchData[searchHeader[section]]) else { return 0}
            return searchCount.count
        }
        return movieData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.Identifier.path.rawValue, for: indexPath) as? MovieListCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.cellViewModel = MovieListCollectionCellViewModel()
        
        if isSearch {
            guard let data = searchData[searchHeader[indexPath.section]] else { return cell}
            cell.searchSaveModel(value: data[indexPath.row])
        } else {
            cell.saveModel(value: movieData[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: SearchCollectionReusableView.identifier,
                                                                     for: indexPath) as! SearchCollectionReusableView
        if isSearch {
            header.titleLabel.text = searchHeader[indexPath.section]
        }else{
            header.titleLabel.text = ""
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let width = delegate?.getWidth() else { return CGSize(width: 30, height: 30) }
        return CGSize(width: width,
                      height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let colums: CGFloat = 1
        let with = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.minimumLineSpacing = 30
        let width = (with - 20) / colums
        let height = width * 0.40
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isSearch {
            guard let routerSearch = searchData[searchHeader[indexPath.section]] else { return }
            let routerSearchTwo = routerSearch[indexPath.row]
            delegate?.selected(at: routerSearchTwo)
        }else{
            let routerData = movieData[indexPath.row]
            //guard let id = routerData.id else { return }
            delegate?.selected(at: routerData)
        }
    }
}
