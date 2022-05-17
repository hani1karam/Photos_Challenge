//
//  HomeDataSource.swift
//  Photos_Challenge
//
//  Created by hany karam on 5/17/22.
//

import RxSwift
import NetworkManager

protocol HomeDataSource {
    func featchImages() -> Observable<ImagesModel>
}
final class HomeDataSourceImpl:HomeDataSource{
    private var networkManager: DataProviderProtocol
    init(networkManager: DataProviderProtocol = APIClient()) {
        self.networkManager = networkManager
    }
    func featchImages() -> Observable<ImagesModel> {
        let placesRequest = SimpleGetRequest(url: "https://www.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=50&text=Color&page=1&per_page=20&api_key=d17378e37e555ebef55ab86c4180e8dc",parameters: nil, method: .get)
        return Observable.create{[weak self] (observer) -> Disposable in
            self?.networkManager.sentRequest(request: placesRequest, mapResponseOnType: ImagesModel.self, successHandler: { [weak self] (result)  in
                observer.onNext((result))
            })
            { (error) in
                print(error)
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
