//
//  HomeRepoitory.swift
//  Photos_Challenge
//
//  Created by hany karam on 5/17/22.
//

import RxSwift

protocol HomeRepository{
    func featchImages(page:Int)-> Observable<ImagesModel>
}
