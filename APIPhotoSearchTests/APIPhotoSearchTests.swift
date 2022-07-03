//
//  APIPhotoSearchTests.swift
//  APIPhotoSearchTests
//
//  Created by Наталья Шарапова on 30.06.2022.
//

import XCTest
@testable import APIPhotoSearch

class MockView: MainViewProtocol {
    
    func success() {}
    func failure(error: Error) {}
}

class MockNetworkService: NetworkServiceProtocol {
    
    var photos: APIResponse!
    init() {}
    
    convenience init(photos: APIResponse?) {
        self.init()
        self.photos = photos
    }
    
    func fetchPhotos(query: String, completion: @escaping (Swift.Result<APIResponse?, Error>) -> Void) {
        if let photos = photos {
            completion(.success(photos))
        } else {
            let error = NSError(domain: "", code: 1, userInfo: nil)
            completion(.failure(error))
        }
    }
    class MainPresenterTest: XCTestCase {
        
        var view: MockView!
        var presenter: MainPresenter!
        var networkService: NetworkServiceProtocol!
        var router: RouterProtocol!
        
        override func tearDownWithError() throws {
            view = nil
            networkService = nil
            presenter = nil
        }
        
        override func setUp() {
            let navigationController = UINavigationController()
            let builder = ModuleBuilder()
            router = Router(navigationController: navigationController, builder: builder)
        }
        
        func testGetSuccessPhotos() throws {
            
            let photos = APIResponse(results: [Result(urls: URLs(regular:               "https://i.pinimg.com/originals/83/1a/7c/831a7cf39e76484168b529d4486f97db.jpg")),
                                               Result(urls: URLs(regular: "https://img-fotki.yandex.ru/get/222565/127908635.1a0f/0_1cb5d3_14e9d061_orig.jpg"))])
            view = MockView()
            networkService = MockNetworkService(photos: photos)
            presenter = MainPresenter(view: view, networkService: networkService, router: router)
            
            var catchPhotos: APIResponse?
            
            networkService.fetchPhotos(query: "nature") { result in
                switch result {
                case .success(let photos):
                    catchPhotos = photos
                case .failure(let error):
                    print(error)
                }
            }
            
            XCTAssertNotEqual(catchPhotos?.results?.count, 0)
            XCTAssertEqual(catchPhotos?.results?.count, photos.results?.count)
        }
        
        func testGetFailurePhotos() throws {
            
            let photos = APIResponse(results: [Result(urls: URLs(regular:               "https://i.pinimg.com/originals/83/1a/7c/831a7cf39e76484168b529d4486f97db.jpg")),
                                               Result(urls: URLs(regular: "https://img-fotki.yandex.ru/get/222565/127908635.1a0f/0_1cb5d3_14e9d061_orig.jpg"))])
            view = MockView()
            networkService = MockNetworkService()
            presenter = MainPresenter(view: view, networkService: networkService, router: router)
            
            var catchError: Error?
            
            networkService.fetchPhotos(query: "nature") { result in
                switch result {
                case .success(let photos):
                    break
                case .failure(let error):
                    catchError = error
                }
            }
            
            XCTAssertNotNil(catchError)
        }
    }
}

