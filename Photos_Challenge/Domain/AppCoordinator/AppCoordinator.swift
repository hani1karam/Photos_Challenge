//
//  AppCoordinator.swift
//  Photos_Challenge
//
//  Created by hany karam on 5/17/22.
//

import UIKit

import RxSwift

class AppCoordinator: BaseCoordinator {
    
    lazy var disposeBag: DisposeBag = {
            return DisposeBag()
        }()

    init(navigationController: UINavigationController?) {
        navigationController?.navigationBar.backgroundColor = UIColor.white
    }
    override func start() -> UIViewController {
        return show()
    }
    private func show() -> UIViewController {
        removeChildCoordinators()
        let coordinator = AppDelegate.container.resolve(PhotosViewCoordinator.self)!
        return start(coordinator: coordinator)
    }
}
