//
//  MainPresenter.swift
//  APIPhotoSearch
//
//  Created by Наталья Шарапова on 22.06.2022.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    
    func success()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getPhotos(query: String)
    func tapOnThePhoto(photo: String)
    var photos: [Result]? { get set }
}

class MainPresenter: MainViewPresenterProtocol {
    
    // MARK: - Properties
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol
    var router: RouterProtocol?
    var photos: [Result]?
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    // MARK: - Methods
    
    func getPhotos(query: String) {
        photos = []
        networkService.fetchPhotos(query: query) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let photos):
                    self.photos = photos?.results
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func tapOnThePhoto(photo: String) {
        router?.showDetailViewController(photo: photo)
    }
}
