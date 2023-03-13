//
//  HomeViewController.swift
//  TestUnsplashApp
//
//  Created by Yarik Mykhalko on 09.03.2023.
//  Copyright (c) 2023. All rights reserved.
//

import UIKit
import DeepDiff

class HomeViewController: HomeViewControllerUI, UIGestureRecognizerDelegate {

    var presenter: HomePresenterProtocol!
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    private func setupCollectionView(isSearch: Bool = false) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotosCell.self, forCellWithReuseIdentifier: PhotosCell.reuseId)
        
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.contentInsetAdjustmentBehavior = .automatic
        
        if let waterfallLayout = collectionView.collectionViewLayout as? WaterfallLayout {
            waterfallLayout.delegate = self
            waterfallLayout.isOneOfColumns = isSearch
        }
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.hideKeyboardOnSwipeDown))
        swipeDown.delegate = self
        swipeDown.direction =  UISwipeGestureRecognizer.Direction.down
        self.collectionView.addGestureRecognizer(swipeDown)
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.hideKeyboardOnSwipeDown))
        swipeUp.delegate = self
        swipeUp.direction =  UISwipeGestureRecognizer.Direction.up
        self.collectionView.addGestureRecognizer(swipeUp)
       
    }
 
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func hideKeyboardOnSwipeDown() {
        view.endEditing(true)
    }
}

extension HomeViewController: PresenterToViewHomeProtocol {
    
    func onFetchPhotoSuccess() {
        DispatchQueue.main.async {
            self.setupCollectionView(isSearch: false)
            self.collectionView.reloadData()
            self.tapToScrollUp()
        }
    }
    
    @objc func tapToScrollUp() {
        let indexPath = IndexPath(item: 0, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
        
    }
    func apply(changes: [Change<Photo>], isSearch: Bool = false) {
        DispatchQueue.main.async {
            self.searchBar.delegate = self
            self.setupCollectionView(isSearch: isSearch)
            self.collectionView.reload(changes: changes, updateData: {})
        }
    }
    
    func onFetchPhotoFailure(error: String) {
        print(error)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getPotosCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCell.reuseId, for: indexPath) as! PhotosCell
        let unsplashPhoto = presenter.getPhotoForRow(index: indexPath.row)
        cell.unsplashPhoto = unsplashPhoto
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(deleteCell(_:)))
            swipeGesture.direction = .left
            cell.addGestureRecognizer(swipeGesture)
        
        return cell
    }
    
    @objc func deleteCell(_ sender: UISwipeGestureRecognizer) {
        if presenter.isSearch {
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let removeAction = UIAlertAction(title: "Remove", style: .default) { _ in
                guard let cell = sender.view as? PhotosCell else {
                    return
                }
                guard let indexPath = self.collectionView.indexPath(for: cell) else {
                    return
                }
                self.presenter.removePhoto(index: indexPath.row)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(removeAction)
            alertController.addAction(cancelAction)
            alertController.modalPresentationStyle = .popover
            alertController.overrideUserInterfaceStyle = .dark
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelecRow(index: indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if (offsetY > contentHeight - scrollView.frame.height * 2) {
            self.presenter.loadNextPhotos()
        }
    }

}

extension HomeViewController: UISearchBarDelegate {
      func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
          hideKeyboardOnSwipeDown()
      }
      
      func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
          if searchText.count > 3 {
              presenter.searchPhotos(query: searchText)
          } else {
              presenter.removePhotosSearch()
          }
      }
}

extension HomeViewController: WaterfallLayoutDelegate {
    func waterfallLayout(_ layout: WaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let unsplashPhoto = presenter.getPhotoForRow(index: indexPath.row)
        return CGSize(width: unsplashPhoto.width, height: unsplashPhoto.height)
    }
}
