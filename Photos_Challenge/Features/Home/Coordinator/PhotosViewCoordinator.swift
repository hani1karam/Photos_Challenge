//
//  PhotosViewCoordinator.swift
//  Photos_Challenge
//
//  Created by hany karam on 5/17/22.
//

import Foundation
import RxSwift
import UIKit
class PhotosViewCoordinator:BaseCoordinator {
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    override func start() -> UIViewController {
        let viewController = HomeVC(nibName: "HomeVC", bundle: nil)
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        viewController.homeViewModel = viewModel
        navigationController.viewControllers = [viewController]
        appDelegate?.window?.rootViewController = navigationController
        return viewController
    }
}
