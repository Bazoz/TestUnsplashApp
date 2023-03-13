//
//  HomePresenter.swift
//  TestUnsplashApp
//
//  Created by Yarik Mykhalko on 09.03.2023.
//  Copyright (c) 2023. All rights reserved.
//

import UIKit
import DeepDiff

class HomePresenter: HomePresenterProtocol {

    weak var view: PresenterToViewHomeProtocol?
    var interactor: PresenterToInteractorHomeProtocol?
    var router: PresenterToRouterHomeProtocol?
    
    var photos = [Photo]()
    var photosSearch = [Photo]()
    var searchQuery = ""
    
    var isSearch = false
    
    func viewDidLoad() {
        interactor?.loadPhotos()
    }
    
    func reloadData() {
        photos.removeAll()
        interactor?.loadPhotos()
    }
    
    func loadNextPhotos() {
        if isSearch {
            interactor?.searchNextPhotos(query: searchQuery)
        } else {
            interactor?.loadNextPhotos()
        }
        
    }
    
    func didSelecRow(index: Int) {
        if isSearch {
            let photo = photosSearch[index]
            router?.openFullScreen(unsplashPhoto: photo, from: view!)
        } else {
            let photo = photos[index]
            router?.openFullScreen(unsplashPhoto: photo, from: view!)
        }
    }
    
    func getPhotoForRow(index: Int) -> Photo {
        if isSearch {
            return photosSearch[index]
        } else {
            return photos[index]
        }
    }
    
    func getPotosCount() -> Int{
        if isSearch {
            return photosSearch.count
        } else {
            return photos.count
        }
    }
    
    func updateFeeds(changes: [Change<Photo>], newItems: [Photo]) {
        self.photos = newItems
        isSearch = false
        view?.apply(changes: changes, isSearch: false)
    }
    
    func searchPhotos(query: String) {
        searchQuery = query
        interactor?.searchPhotos(query: query)
    }
    func removePhotosSearch() {
        isSearch = false
        photosSearch.removeAll()
        view?.onFetchPhotoSuccess()
    }
    func updateSearchFeeds(changes: [Change<Photo>], newItems: [Photo]) {
        self.photosSearch = newItems
        isSearch = true
        view?.apply(changes: changes, isSearch: true)
    }
}

extension HomePresenter: InteractorToPresenterHomeProtocol {
    func fetchPhotoSuccess(photos: [Photo]) {
        let newItems = (self.photos + photos).filterDuplicates()
        let changes = diff(old: self.photos, new: newItems)
        self.updateFeeds(changes: changes, newItems: photos)
    }
    
    func fetchPhotoFailure(error: NetworkError) {
        switch error {
        case .invalidData:
            self.view?.onFetchPhotoFailure(error: "responceError")
        case .invalidURL:
            self.view?.onFetchPhotoFailure(error: "parseError")
        case .requestFailed:
            self.view?.onFetchPhotoFailure(error: "urlNotValid")
        }
    }
    
    func fetchSearchPhotoSuccess(photos: [Photo]) {
        let changes = diff(old: self.photosSearch, new: photos)
        self.updateSearchFeeds(changes: changes, newItems: photos)
    }
    
    func removePhoto(index: Int) {
        if isSearch {
            var photoMass = photosSearch
            photoMass.remove(at: index)
            let changes = diff(old: self.photosSearch, new: photoMass)
            self.updateSearchFeeds(changes: changes, newItems: photoMass)
        }
    }
    
}

