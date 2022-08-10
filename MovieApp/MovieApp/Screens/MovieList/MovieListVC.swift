//
//  MovieListVC.swift
//  MovieApp
//
//  Created by ArdaSisli on 4.08.2022.
//

import UIKit
import SnapKit

class MovieListVC: UIViewController {
    
    //MARK: - Views
    
    private var searchBar: UISearchController = {
        let search = UISearchController()
        search.searchBar.placeholder = MovieListConstant.searchBar.placeholder.rawValue
        search.searchBar.showsCancelButton = true
        return search
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray6
        collectionView.register(
            MovieListCollectionViewCell.self,
            forCellWithReuseIdentifier: MovieListCollectionViewCell.Identifier.path.rawValue
        )
        collectionView.register(SearchCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SearchCollectionReusableView.identifier
        )
        return collectionView
    }()
    
    private lazy var indicatorRequest: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .red
        return indicator
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = MovieListConstant.PropertyLabel.empty.rawValue
        return label
    }()
    
    //MARK: - Properties
    
    private var movieProvider = MovieListProvider()
    private var movieData: [Movie] = []
    private var searchMovieData: [Movie] = []
    private var searchTVData: [TV] = []
    private var searchPersonData: [KnownFor] = []
    private var movieError: String = ""
    private var searchMovieError: String = ""
    private var searchTVError: String = ""
    private var searchPersonError: String = ""
    private var isSearch = false
    private var sectionList = [String : [Any]]()
    private let sectionHeader = ["Movie", "TV", "Person"]
    
    var movieListViewModel: MovieListViewModelProtocol?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDelegate()
        movieListViewModel?.load()
        configure()
    }
    
    //MARK: - Private Func
    
    private func initDelegate() {
        searchBar.searchBar.delegate = self
        movieListViewModel?.delegate = self
        movieProvider.delegate = self
        collectionView.delegate = movieProvider
        collectionView.dataSource = movieProvider
    }
    
    private func configure() {
        navigationItem.searchController = searchBar
        view.backgroundColor = .systemGray6
        
        view.addSubview(collectionView)
        view.addSubview(indicatorRequest)
        configureConstraints()
      
    }
    
    private func configureConstraints() {
        makeIndcator()
        movieCollection()
    }
}

//MARK: UISearchBarDelegate

extension MovieListVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        movieProvider.remove()
        isSearch = true
        
        movieListViewModel?.searchMovieLoad(path: text)
        movieListViewModel?.searchTVLoad(path: text)
        movieListViewModel?.searchPersonLoad(path: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        movieProvider.remove()
        isSearch = false
        movieProvider.isSearch(to: false)
        movieProvider.load(value: movieData)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

//MARK: MovieListProviderDelegate

extension MovieListVC: MovieListProviderDelegate {
    func selected(at select: Any) {
        let viewController = MovieDetailBuilder.make(value: select)
        viewController.modalPresentationStyle = .fullScreen
        self.show(viewController, sender: nil)
    }
    
    func getWidth() -> CGFloat {
        return view.frame.size.width
    }
}

//MARK: MovieListViewModelDelegate

extension MovieListVC: MovieListViewModelDelegate {
    func searchMovieHandleOutPut(_ output: SearchMovieViewModelOutPut) {
        switch output {
        case .searchMovie(let movie):
            self.searchMovieData = movie
            var movieArray: [Movie] = []
            movieArray.append(contentsOf: movie)
            
            sectionList["Movie"] = movieArray
            
        case .showError(let error):
            self.searchMovieError = error
        }
    }
    
    func searchTVHandleOutPut(_ output: SearchTViewModelOutPut) {
        switch output {
        case .searchTV(let tv):
            self.searchTVData = tv
            var tvArray: [TV] = []
            tvArray.append(contentsOf: tv)
            
            sectionList["TV"] = tvArray
            
        case .showError(let error):
            self.searchTVError = error
        }
    }
    
    func searchPersonHandleOutPut(_ output: SearchPersonViewModelOutPut) {
        switch output {
        case .searchPerson(let person):
            for i in person {
                if let knownFor = i.knownFor {
                    searchPersonData.append(contentsOf: knownFor)
                }
            }
            sectionList["Person"] = searchPersonData
            
            movieProvider.isSearch(to: true)
            movieProvider.loadSearch(value: sectionList)
            movieProvider.loadTitle(title: sectionHeader)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        case .showError(let error):
            self.searchPersonError = error
        }
    }
    
    func handleOutPut(_ output: MovieListViewModelOutPut) {
        switch output {
        case .showMovieList(let movie):
            self.movieData = movie
            movieProvider.load(value: movieData)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            collectionView.isHidden = false
        case .showError(let error):
            self.movieError = error
            view.addSubview(emptyLabel)
            makeEmptyLabel()
            collectionView.isHidden = true
        case .isLoading(let loading):
            loading ? indicatorRequest.startAnimating() : indicatorRequest.stopAnimating()
        }
    }
}

//MARK: Constraints

extension MovieListVC {
    private func movieCollection() {
        collectionView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func makeIndcator() {
        indicatorRequest.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
    }
    
    private func  makeEmptyLabel() {
        emptyLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
    }
}
