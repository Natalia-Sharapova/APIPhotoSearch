//
//  MainViewController.swift
//  APIPhotoSearch
//
//  Created by Наталья Шарапова on 07.03.2022.
//

import UIKit
import CHTCollectionViewWaterfallLayout

class MainViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: - Properties
    
    var presenter: MainViewPresenterProtocol!
    
    private var collectionView: UICollectionView = {
        
        let layout = CHTCollectionViewWaterfallLayout()
        layout.itemRenderDirection = .leftToRight
        layout.columnCount = 2
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    let searchBar = UISearchBar()
    
    // MARK: - Viewcontroller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(searchBar)
        view.backgroundColor = .systemBackground
        searchBar.searchTextField.textColor = .white
        searchBar.delegate = self
        searchBar.barTintColor = .white
        searchBar.searchBarStyle = .minimal
        
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .systemBackground
        navigationController?.navigationBar.backgroundColor = .systemBackground
        searchBar.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        searchBar.frame = CGRect(x: 10, y: view.safeAreaInsets.top, width: view.frame.size.width - 20, height: 50)
        collectionView.frame = CGRect(x: 0, y: view.safeAreaInsets.top + 55, width: view.frame.size.width, height: view.frame.size.height - 55)
    }
    
    // MARK: - Methods
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if let query = searchBar.text {
            presenter.getPhotos(query: query)
        }
    }
}

// MARK: - Extensions

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        guard let photo = presenter.photos?[indexPath.row].urls?.regular  else { return UICollectionViewCell() }
        cell.configure(photo: photo)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width / 2, height: CGFloat.random(in: 200...400))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let photo = presenter.photos?[indexPath.row].urls?.regular else { return }
        presenter.tapOnThePhoto(photo: photo)
    }
}
extension MainViewController: MainViewProtocol {
    
    func success() {
        self.collectionView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
