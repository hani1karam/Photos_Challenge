//
//  HomeUseCase.swift
//  Photos_Challenge
//
//  Created by hany karam on 5/17/22.
//

import Foundation
import RxSwift
class HomeUseCase{
    private let homeRepository: HomeRepository
    init(homeRepository: HomeRepository){
        self.homeRepository = homeRepository
    }
    func featchImages() -> Observable<ImagesModel>{
        return homeRepository.featchImages()
        
    }
}
