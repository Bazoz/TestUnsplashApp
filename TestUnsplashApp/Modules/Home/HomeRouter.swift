//
//  HomeRouter.swift
//  TestUnsplashApp
//
//  Created by Yarik Mykhalko on 09.03.2023.
//  Copyright (c) 2023. All rights reserved.
//

import UIKit

class HomeRouter: PresenterToRouterHomeProtocol {

    weak var viewController: HomeViewController?
    
    static func createModule() -> UIViewController {
        let viewController = HomeViewController()
        let presenter: HomePresenterProtocol & InteractorToPresenterHomeProtocol = HomePresenter()
        viewController.presenter = presenter
        viewController.presenter?.router = HomeRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = HomeInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        viewController.presenter?.interactor?.serviceProtocol = NetworkService()
        return viewController
    }
    
    func openFullScreen(unsplashPhoto: Photo, from source: PresenterToViewHomeProtocol) {
        let viewController = source as! HomeViewController
        let fullScreenVC = FullScreenRouter.createModule(unsplashPhoto: unsplashPhoto)
        let navController = UINavigationController(rootViewController: fullScreenVC)
        viewController.present(navController, animated: true, completion: nil)
    }
}
