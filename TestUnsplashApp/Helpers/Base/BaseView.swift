//
//  BaseView.swift
//  TestUnsplashApp
//
//  Created by Yarik Mykhalko on 09.03.2023.
//

import UIKit
import SnapKit

public class BaseView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
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
