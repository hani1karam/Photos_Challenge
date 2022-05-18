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
    var dataManager: DatabaseManagerProtocol
    init(networkManager: DataProviderProtocol = APIClient(),dataManager: DatabaseManagerProtocol = DatabaseManager()) {
        self.networkManager = networkManager
        self.dataManager = dataManager
    }
    func featchImages() -> Observable<ImagesModel> {
        if Reachability.isConnectedToNetwork(){
            let placesRequest = SimpleGetRequest(url: "https://www.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=50&text=Color&page=1&per_page=20&api_key=d17378e37e555ebef55ab86c4180e8dc",parameters: nil, method: .get)
            return Observable.create{[weak self] (observer) -> Disposable in
                self?.networkManager.sentRequest(request: placesRequest, mapResponseOnType: ImagesModel.self, successHandler: { [weak self] (result)  in
                    observer.onNext((result))
                    let data = result.photos.map{($0.photo).map{($0)}}
                    let image = data?.flatMap({$0})
                    if (self?.dataManager.fetchListList() != nil){
                        self?.dataManager.addItem(item: ItemModel(id: getAllIds(image), image: allImages(image)))
                    }
                })
                { (error) in
                    print(error)
                    observer.onError(error)
                }
                return Disposables.create()
            }
        }
        else{
            return Observable.create{[weak self] (observer) -> Disposable in
                return Disposables.create()
            }
        }
    }
}
