//
//  HomeContract.swift
//  TestUnsplashApp
//
//  Created by Yarik Mykhalko on 09.03.2023.
//

import UIKit
import DeepDiff

// MARK: View Output (Presenter -> View)
protocol PresenterToViewHomeProtocol: AnyObject {
    func onFetchPhotoSuccess()
    func onFetchPhotoFailure(error: String)
    func apply(changes: [Change<Photo>], isSearch: Bool)
}

// MARK: View Input (View -> Presenter)
protocol HomePresenterProtocol: AnyObject {
    
    var view: PresenterToViewHomeProtocol? { get set }
    var interactor: PresenterToInteractorHomeProtocol? { get set }
    var router: PresenterToRouterHomeProtocol? { get set }
    var isSearch: Bool { get set }
    
    func viewDidLoad()
    func reloadData()
    func loadNextPhotos()
    func getPhotoForRow(index: Int) -> Photo
    func getPotosCount() -> Int
    func didSelecRow(index: Int)
    func searchPhotos(query: String)
    func removePhotosSearch()
    func removePhoto(index: Int)
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorHomeProtocol: AnyObject {
    var presenter: InteractorToPresenterHomeProtocol? { get set }
    var serviceProtocol: NetworkServiceProtocol! { get set }
    func loadPhotos()
    func loadNextPhotos()
    func reloadPhotos()
    func searchPhotos(query: String)
    func searchNextPhotos(query: String)
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterHomeProtocol: AnyObject {
    func fetchPhotoSuccess(photos: [Photo])
    func fetchSearchPhotoSuccess(photos: [Photo])
    func fetchPhotoFailure(error: NetworkError)
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterHomeProtocol: AnyObject {
    static func createModule() -> UIViewController
    func openFullScreen(unsplashPhoto: Photo, from source: PresenterToViewHomeProtocol)
}


protocol DeepDiffPhotoDelegate: AnyObject {
    func apply(changes: [Change<Photo>], newItems: [Photo])
}
