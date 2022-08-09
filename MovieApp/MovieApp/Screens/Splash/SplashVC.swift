//
//  SplashVC.swift
//  MovieApp
//
//  Created by ArdaSisli on 4.08.2022.
//

import UIKit

class SplashVC: UIViewController {
    
    //MARK: Views

    private lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 8
        image.image = UIImage(named: "Wellbees")
        image.alpha = 0.9
        return image
    }()
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        animation()
      
    }
    
    //MARK: - Private Func
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(logoImage)
        makeLogo()
    }
    
    private func animation() {
        UIView.animate(withDuration: 2, animations: {
            self.logoImage.alpha = 1
        }, completion: { _ in
            let viewController = UINavigationController(rootViewController: MovieListBuilder.make())
            viewController.modalPresentationStyle = .fullScreen
            self.show(viewController, sender: nil)
        })
    }
}

    extension SplashVC {
        func makeLogo() {
            logoImage.snp.makeConstraints { make in
                make.centerX.equalTo(view.snp.centerX)
                make.centerY.equalTo(view.snp.centerY)
                make.height.equalTo(view.frame.size.height / 6)
                make.width.equalTo(view.frame.size.width / 3)
            }
        }
    }
