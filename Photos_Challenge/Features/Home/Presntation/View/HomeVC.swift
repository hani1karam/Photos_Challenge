//
//  HomeVC.swift
//  Photos_Challenge
//
//  Created by hany karam on 5/17/22.
//

import UIKit
import RxSwift
import RxCocoa

class HomeVC: UIViewController {
    @IBOutlet weak var homeTV: UITableView!
    static let cellIdentifierDemoCell = "HomeTableViewCell"
    public var homeViewModel:HomeViewModel?
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showCatrogy()
        fetchData()
        setUpUTableViewDelegate()
    }
    func showCatrogy(){
        homeTV.register(UINib(nibName: HomeVC.cellIdentifierDemoCell, bundle: nil), forCellReuseIdentifier: HomeVC.cellIdentifierDemoCell)
    }
    
    func fetchData() {
        self.homeViewModel?.featchPhotos().subscribe(onNext:{[weak self] dataItem in
            guard let photosData = dataItem.photos?.photo else {return}
            Observable.of(photosData).bind(to:(self?.homeTV.rx.items(cellIdentifier: HomeVC.cellIdentifierDemoCell, cellType: HomeTableViewCell.self))!){[weak self] row,branch,cell in
                cell.reloadCellProudctImage(image: branch)
                cell.titleLabel?.text = branch.title
            }.disposed(by: self?.disposeBag ?? DisposeBag())
        }).disposed(by: disposeBag)
    }
    func setUpUTableViewDelegate() {
        homeTV
            .rx
            .modelSelected(Photo.self)
            .subscribe(onNext: { [weak self]  branch in
                self?.homeViewModel?.itemSelected.onNext(branch)
            })
            .disposed(by: disposeBag)
    }
    
}
