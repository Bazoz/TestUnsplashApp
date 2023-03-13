//
//  HomeViewControllerUI.swift
//  TestUnsplashApp
//
//  Created by Yarik Mykhalko on 09.03.2023.
//  Copyright (c) 2023. All rights reserved.
//

import UIKit

private protocol HomeViewControllerInstaller: ViewInstaller {
    var collectionView: UICollectionView! { get set }
    var searchBar: UISearchBar! { get set }
}

extension HomeViewControllerInstaller {
    
    func initSubviews() {
        collectionView = {
            let layout = WaterfallLayout()
            let tableView =  UICollectionView(frame: .zero, collectionViewLayout: layout)
            tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
            return tableView
        }()
        
        searchBar = {
           let view = UISearchBar()
            view.placeholder = "Search..."
            return view
        }()
    }
    
    func embedSubviews() {
        mainView.addSubview(collectionView)
        mainView.addSubview(searchBar)
    }
    
    func addSubviewsConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(mainView.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        collectionView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
        }
    }
}

class HomeViewControllerUI: BaseViewController, HomeViewControllerInstaller {
    
    var mainView: UIView { view }
    var collectionView: UICollectionView!
    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }

}
