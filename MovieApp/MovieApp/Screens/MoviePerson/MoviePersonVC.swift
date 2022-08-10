//
//  MoviePersonVC.swift
//  MovieApp
//
//  Created by ArdaSisli on 7.08.2022.
//

import UIKit

class MoviePersonVC: UIViewController {
    
    //MARK: - Views
    
    private var personImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private var personName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = "\(MoviePersonConstant.PropertyLabel.description.rawValue):"
        return label
    }()
    
    private lazy var  personDescription: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private var personGender: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private var personBirthday: UILabel = {
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
        stackView.alignment = .lastBaseline
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var personIMDbButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(MoviePersonConstant.IMDBButtonTitle.titleIMDB.rawValue, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
        return button
    }()
    
    //MARK: - Properties
    
    var personVievModel: MoviePersonViewModelProtocol?
    var personData: Person?
    var personError: String = ""
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personVievModel?.delegate = self
        personVievModel?.loadPerson()
        configure()
        clickPersonDetailButton()
        backBarButton()
    }
    
    //MARK: - Private Func
    
    private func configure() {
        configureProperty()
    }
    
    private func configureProperty() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(personImage)
        stackView.addArrangedSubview(personName)
        stackView.addArrangedSubview(personGender)
        stackView.addArrangedSubview(personBirthday)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(personDescription)
        stackView.addArrangedSubview(personIMDbButton)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        makeScroll()
        makeStack()
        makeIMDbButton()
        makeImage()
    }
    
    private func clickPersonDetailButton() {
        personIMDbButton.addTarget(self, action: #selector(clickIMDBUrl), for: .touchUpInside)
    }
    
    @objc func clickIMDBUrl(){
        guard let urlTwo = personData?.imdbID else { return }
        let url = MoviePersonConstant.MovieDetailIMDBUrl.pathIMDB(id: urlTwo)
        if let url = URL(string: "\(url)") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    func backBarButton() {
        let rightButton = UIBarButtonItem(title: "Home", style: .plain , target: self, action: #selector(goToBack(_:)))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func goToBack(_ navigationItem: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func propertyUI(person: Person) {
        personGender.text = personVievModel?.getProperty()
        personName.text = personVievModel?.getPersonName()
        personBirthday.text = personVievModel?.getBirthday()
        personDescription.text = personVievModel?.getBiography()
        
        if let profilePath = person.profilePath {
            if let url = URL(string: MoviePersonConstant.profileImage.pathImage(path: profilePath)) {
                personImage.af.setImage(withURL: url)
            }
        }else{
            personImage.image = UIImage(named: "NoImage")
        }
    }
}

//MARK: - MoviePersonViewModelDelegate

extension MoviePersonVC: MoviePersonViewModelDelegate {
    func handleOutPut(_ output: MoviePersonOutPut) {
        switch output {
        case .selectPerson(let person):
            self.personData = person
            propertyUI(person: person)
        case .errorPerson(let error):
            self.personError = error
        }
    }
}

//MARK: - Constraints

extension MoviePersonVC {
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
    
    private func makeIMDbButton() {
        personIMDbButton.snp.makeConstraints { make in
            make.height.equalTo(view.frame.size.height / 15)
            make.width.equalTo(view.frame.size.width / 3)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    
    private func makeImage() {
        personImage.snp.makeConstraints { make in
            make.height.equalTo(view.frame.size.height / 3)
            make.width.equalTo(view.frame.size.width / 1.1)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
}
