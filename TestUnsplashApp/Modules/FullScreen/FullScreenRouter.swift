//
//  FullScreenRouter.swift
//  TestUnsplashApp
//
//  Created by Yarik Mykhalko on 11.03.2023.
//

import UIKit

class FullScreenRouter: PresenterToRouterFullScreenProtocol {

    weak var viewController: FullScreenViewController?
    
    static func createModule(unsplashPhoto: Photo) -> UIViewController {
        let viewController = FullScreenViewController()
        let presenter: FullScreenPresenterProtocol & InteractorToPresenterFullScreenProtocol = FullScreenPresenter()
        viewController.presenter = presenter
        viewController.presenter?.router = FullScreenRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = FullScreenInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        viewController.presenter?.unsplashPhoto = unsplashPhoto
        return viewController
    }
    
}
