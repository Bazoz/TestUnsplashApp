//
//  PhotosCell.swift
//  TestUnsplashApp
//
//  Created by Yarik Mykhalko on 09.03.2023.
//

import UIKit
import SDWebImage

class PhotosCell: BaseCollectionViewCell {
    
    static let reuseId = "PhotosCell"
    var photoImageView: UIImageView!
    
    var unsplashPhoto: Photo! {
        didSet {
            configureImage(unsplashPhoto: unsplashPhoto)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    override func initSubviews() {
        photoImageView = {
           let imageView = UIImageView()
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 8
           return imageView
       }()
    }
    
    override func embedSubviews() {
        addSubview(photoImageView)
    }
    
    override func addSubviewsConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func configureImage(unsplashPhoto: Photo) {
        let photoUrl = unsplashPhoto.urls.small
        guard let url = URL(string: photoUrl) else { return }
        photoImageView.sd_setImage(with: url,
                                        placeholderImage: nil,
                                        options: [], context: nil)
    }
    
}
