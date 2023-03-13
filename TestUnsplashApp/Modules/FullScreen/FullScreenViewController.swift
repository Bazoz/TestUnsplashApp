//
//  FullScreenViewController.swift
//  TestUnsplashApp
//
//  Created by Yarik Mykhalko on 11.03.2023.
//

import UIKit
import SDWebImage

class FullScreenViewController: FullScreenViewControllerUI {

    var presenter: FullScreenPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension FullScreenViewController: PresenterToViewFullScreenProtocol {
  
    func configureFullScreen() {
        
        view.backgroundColor = .white
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonTapped))
        navigationItem.rightBarButtonItem = closeButton

        guard let imageURL = URL(string: presenter.unsplashPhoto.urls.regular) else { return }
        imageView.sd_setImage(with: imageURL,
                              placeholderImage: nil,
                              options: [], context: nil)
    }
}
