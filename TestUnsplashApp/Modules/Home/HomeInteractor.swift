//
//  HomeInteractor.swift
//  TestUnsplashApp
//
//  Created by Yarik Mykhalko on 09.03.2023.
//  Copyright (c) 2023. All rights reserved.
//

import UIKit

class HomeInteractor: PresenterToInteractorHomeProtocol {
    
    weak var presenter: InteractorToPresenterHomeProtocol?
    var serviceProtocol: NetworkServiceProtocol!
    var photos = [Photo]()
    var currentPage = 1
    var isLoading = false
    
    var photosSearch = [Photo]()
    var currentPageSearch = 1
    var isLoadingSearch = false
    
    func loadPhotos() {
        if !isLoading {
            isLoading = true
            Task {
                do {
                    let photo = try await self.serviceProtocol.fetchPhotos(page: 1)
                    self.photos = photo
                    self.currentPage = 2
                    self.isLoading = false
                    self.presenter?.fetchPhotoSuccess(photos: self.photos)
                } catch {
                    self.isLoading = false
                    self.presenter?.fetchPhotoFailure(error: error as? NetworkError ?? NetworkError.requestFailed)
                }
            }
        }
    }
    
    func loadNextPhotos() {
        if !isLoading && currentPage <= 10 {
            isLoading = true
            Task {
                do {
                    let photo = try await self.serviceProtocol.fetchPhotos(page: self.currentPage)
                    self.photos += photo
                    self.currentPage += 1
                    self.isLoading = false
                    self.presenter?.fetchPhotoSuccess(photos: self.photos)
                } catch {
                    self.isLoading = false
                    self.presenter?.fetchPhotoFailure(error: error as? NetworkError ?? NetworkError.requestFailed)
                }
            }
        }
    }
    
    func reloadPhotos() {
        photos.removeAll()
        isLoading = false
        loadPhotos()
    }
    
    func searchPhotos(query: String) {
        if !isLoadingSearch {
            isLoadingSearch = true
            Task {
                do {
                    let photo = try await self.serviceProtocol.searchPhotos(query: query, page: 1)
                    self.photosSearch = photo
                    self.currentPageSearch = 2
                    self.isLoadingSearch = false
                    self.presenter?.fetchSearchPhotoSuccess(photos: self.photosSearch)
                } catch {
                    self.isLoadingSearch = false
                    self.presenter?.fetchPhotoFailure(error: error as? NetworkError ?? NetworkError.requestFailed)
                }
            }
        }
    }
    
    func searchNextPhotos(query: String) {
        if !isLoadingSearch && currentPageSearch <= 10 {
            isLoadingSearch = true
            Task {
                do {
                    let photo = try await self.serviceProtocol.searchPhotos(query: query, page: self.currentPageSearch)
                    self.photosSearch += photo
                    self.currentPageSearch += 1
                    self.isLoadingSearch = false
                    self.presenter?.fetchSearchPhotoSuccess(photos: self.photosSearch)
                } catch {
                    self.isLoadingSearch = false
                    self.presenter?.fetchPhotoFailure(error: error as? NetworkError ?? NetworkError.requestFailed)
                }
            }
        }
    }
    
}
