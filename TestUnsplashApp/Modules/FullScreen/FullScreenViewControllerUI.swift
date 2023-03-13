//
//  FullScreenViewControllerUI.swift
//  TestUnsplashApp
//
//  Created by Yarik Mykhalko on 11.03.2023.
//

import UIKit

private protocol FullScreenViewControllerInstaller: ViewInstaller {
    var imageView: UIImageView! { get set }
}

extension FullScreenViewControllerInstaller {
    
    func initSubviews() {
        imageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFit
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    }
    
    func embedSubviews() {
        mainView.addSubview(imageView)
    }
    
    func addSubviewsConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

class FullScreenViewControllerUI: BaseViewController, FullScreenViewControllerInstaller {
    
    var mainView: UIView { view }
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }

}
