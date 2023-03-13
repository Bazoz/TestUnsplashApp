//
//  BaseCollectionViewCell.swift
//  TestUnsplashApp
//
//  Created by Yarik Mykhalko on 09.03.2023.
//

import UIKit
import SnapKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        initSubviews()
        embedSubviews()
        addSubviewsConstraints()
    }
    
    func initSubviews() {
         
    }
    
    func embedSubviews() {
         
    }
    
    func addSubviewsConstraints() {
         
    }
}
