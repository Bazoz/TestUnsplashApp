//
//  FullScreenPresenter.swift
//  TestUnsplashApp
//
//  Created by Yarik Mykhalko on 11.03.2023.
//

import UIKit

class FullScreenPresenter: FullScreenPresenterProtocol {
    
    weak var view: PresenterToViewFullScreenProtocol?
    var interactor: PresenterToInteractorFullScreenProtocol?
    var router: PresenterToRouterFullScreenProtocol?
    
    var unsplashPhoto: Photo!
    
    func viewDidLoad() {
        interactor?.loadViews()
    }

}

extension FullScreenPresenter: InteractorToPresenterFullScreenProtocol {
    func loadViews() {
        view?.configureFullScreen()
    }
    
}

