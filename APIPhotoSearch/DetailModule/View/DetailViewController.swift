//
//  DetailViewController.swift
//  APIPhotoSearch
//
//  Created by Наталья Шарапова on 24.06.2022.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: DetailViewPresenterProtocol!
    
    private var imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = false
        return imageView
    }()
    
    // MARK: - Viewcontroller methods
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setConstrains()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        view.backgroundColor = .systemBackground
        presenter.setPhoto()
    }
    
    // MARK: - Methods
    
    func setConstrains() {
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 55).isActive = true
    }
}
// MARK: - Extensions

extension DetailViewController: DetailViewProtocol {
    
    func showPhoto(photo: String) {
        guard let url = URL(string: photo) else { return }
        imageView.sd_setImage(with: url, completed: nil)
    }
}
