//
//  FullScreenInteractor.swift
//  TestUnsplashApp
//
//  Created by Yarik Mykhalko on 11.03.2023.
//

import UIKit

class FullScreenInteractor: PresenterToInteractorFullScreenProtocol {
    
    weak var presenter: InteractorToPresenterFullScreenProtocol?
    
    func loadViews() {
        presenter?.loadViews()
    }
}
