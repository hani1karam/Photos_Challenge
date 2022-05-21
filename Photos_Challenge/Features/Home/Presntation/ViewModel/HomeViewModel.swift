//
//  HomeViewModel.swift
//  Photos_Challenge
//
//  Created by hany karam on 5/17/22.
//

import RxSwift
import RxCocoa

class HomeViewModel {
    let homeUseCase: HomeUseCase
    
    let fetchMoreDatas = PublishSubject<Void>()
    let refreshControlAction = PublishSubject<Void>()
    let refreshControlCompelted = PublishSubject<Void>()
    let isLoadingSpinnerAvaliable = PublishSubject<Bool>()
    var itemSelected = PublishSubject<Photo>()
    let items = BehaviorRelay<[Photo]>(value: [])
    
    private let disposeBag = DisposeBag()
    private var pageCounter = 1
    private var maxValue = 1
    private var isPaginationRequestStillResume = false
    private var isRefreshRequstStillResume = false
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
        fetch()
    }
    
    func fetch() {
        self.fetchDummyData(page: self.pageCounter,
                            isRefreshControl: false)
    }
    
    private func fetchDummyData(page: Int, isRefreshControl: Bool) {
        if isPaginationRequestStillResume || isRefreshRequstStillResume { return }
        self.isRefreshRequstStillResume = isRefreshControl
        
        if pageCounter > maxValue  {
            isPaginationRequestStillResume = false
            return
        }
        
        isPaginationRequestStillResume = true
        isLoadingSpinnerAvaliable.onNext(true)
        
        if pageCounter == 1  || isRefreshControl {
            isLoadingSpinnerAvaliable.onNext(false)
        }
        
        homeUseCase.featchImages(page: page).subscribe(onNext: {[weak self]  dummyResponse in
            if !(dummyResponse.photos?.photo?.isEmpty ?? false) {
                self?.handleDummyData(data: dummyResponse)
                self?.isLoadingSpinnerAvaliable.onNext(false)
                self?.isPaginationRequestStillResume = false
                self?.isRefreshRequstStillResume = false
                self?.refreshControlCompelted.onNext(())
            }
        }).disposed(by: disposeBag)
        
        refreshControlAction.subscribe { [weak self] _ in
            self?.refreshControlTriggered()
        }
        .disposed(by: disposeBag)
    }
    
    private func handleDummyData(data: ImagesModel) {
        maxValue = data.photos?.pages ?? 0
        if pageCounter == 1, let finalData = data.photos?.photo {
            self.maxValue = data.photos?.pages ?? 0
            items.accept(finalData)
        } else if let data = data.photos?.photo {
            let oldDatas = items.value
            items.accept(oldDatas + data)
        }
        pageCounter += 1
    }
    
    private func refreshControlTriggered() {
        isPaginationRequestStillResume = false
        pageCounter = 1
        items.accept([])
        fetchDummyData(page: pageCounter,
                       isRefreshControl: true)
    }
}

