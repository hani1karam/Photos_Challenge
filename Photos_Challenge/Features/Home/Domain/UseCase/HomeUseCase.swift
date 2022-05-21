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
    
    private let maxPage = 5
    
    init(homeRepository: HomeRepository){
        self.homeRepository = homeRepository
    }
    func featchImages(page:Int) -> Observable<ImagesModel>{
        return homeRepository.featchImages(page:page)
    }
}
