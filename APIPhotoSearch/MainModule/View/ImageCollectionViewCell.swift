//
//  ImageCollectionViewCell.swift
//  APIPhotoSearch
//
//  Created by Наталья Шарапова on 07.03.2022.
//

import UIKit
import SDWebImage

class ImageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "ImageCollectionViewCell"
    
    private let imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Viewcontroller methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    // MARK: - Methods
    
    func configure(photo: String) {
        guard let url = URL(string: photo) else { return }
        imageView.sd_setImage(with: url, completed: nil)
    }
}

