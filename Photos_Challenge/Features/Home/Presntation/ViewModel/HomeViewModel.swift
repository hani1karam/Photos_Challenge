//
//  HomeViewModel.swift
//  Photos_Challenge
//
//  Created by hany karam on 5/17/22.
//

import RxSwift
class HomeViewModel{
    let homeUseCase: HomeUseCase
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    func featchPhotos() -> Observable<ImagesModel>{
        return homeUseCase.featchImages()
    }
}
