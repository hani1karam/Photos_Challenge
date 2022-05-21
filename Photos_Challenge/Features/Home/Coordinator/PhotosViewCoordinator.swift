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
    //
    override func start() -> UIViewController {
        let viewController = HomeVC(nibName: "HomeVC", bundle: nil)
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        viewController.homeViewModel = viewModel
        
        self.navigationController.navigationItem.backBarButtonItem?.tintColor = UIColor.white
        self.navigationController.navigationBar.isTranslucent = true
        if var textAttributes = navigationController.navigationBar.titleTextAttributes {
            textAttributes[NSAttributedString.Key.foregroundColor] = UIColor.white
            navigationController.navigationBar.titleTextAttributes = textAttributes
        }
        self.navigationController.navigationBar.barTintColor = UIColor(red: 100/255, green: 215/255, blue: 65/255, alpha: 1)
        self.navigationController.navigationBar.barStyle = UIBarStyle.black
        self.navigationController.navigationBar.tintColor = UIColor.white
        viewModel.itemSelected.subscribe(onNext: { [weak self]  branch in
            let sampleVC = DetailsVC(nibName: "DetailsVC", bundle: nil)
            sampleVC.image = branch.flickrImageURL()
            self?.navigationController.pushViewController(sampleVC, animated: false)
            
            
        })
        .disposed(by: disposeBag)
        navigationController.viewControllers = [viewController]
        appDelegate?.window?.rootViewController = navigationController
        return viewController
        
    }
}
