//
//  FullScreenContract.swift
//  TestUnsplashApp
//
//  Created by Yarik Mykhalko on 11.03.2023.
//

import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewFullScreenProtocol: AnyObject {
    func configureFullScreen()
}

// MARK: View Input (View -> Presenter)
protocol FullScreenPresenterProtocol: AnyObject {
    
    var view: PresenterToViewFullScreenProtocol? { get set }
    var interactor: PresenterToInteractorFullScreenProtocol? { get set }
    var router: PresenterToRouterFullScreenProtocol? { get set }
    var unsplashPhoto: Photo! { get set }
    
    func viewDidLoad()
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorFullScreenProtocol: AnyObject {
    var presenter: InteractorToPresenterFullScreenProtocol? { get set }
    func loadViews()
}


/// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterFullScreenProtocol: AnyObject {
    func loadViews()
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterFullScreenProtocol: AnyObject {
    static func createModule(unsplashPhoto: Photo) -> UIViewController
}
