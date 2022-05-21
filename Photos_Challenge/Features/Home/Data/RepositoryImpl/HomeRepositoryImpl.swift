//
//  HomeRepositoryImpl.swift
//  Photos_Challenge
//
//  Created by hany karam on 5/17/22.
//
import RxSwift
class HomeRepositoryImpl:HomeRepository{
    private var homeDataSource: HomeDataSource
    init(homeDataSource: HomeDataSource){
        self.homeDataSource = homeDataSource
    }
    
    func featchImages(page:Int) -> Observable<ImagesModel> {
        return homeDataSource.featchImages(page: page)
    }
}
