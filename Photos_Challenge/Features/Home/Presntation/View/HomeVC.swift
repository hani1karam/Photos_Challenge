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
    
    @IBOutlet weak var homeTableView: UITableView!
    static let cellIdentifierDemoCell = "HomeTableViewCell"
    public var homeViewModel:HomeViewModel?
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    
    private lazy var viewSpinner: UIView = {
        let view = UIView(frame: CGRect(
                            x: 0,
                            y: 0,
                            width: 100,
                            height: 100)
        )
        let spinner = UIActivityIndicatorView()
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
        return view
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind()
        
        refreshControl.addTarget(self, action: #selector(refreshControlTriggered), for: .valueChanged)
    }
    
    private func layout() {
        homeTableView.register(UINib(nibName: HomeVC.cellIdentifierDemoCell, bundle: nil), forCellReuseIdentifier: HomeVC.cellIdentifierDemoCell)
    }
    
    private func bind() {
        tableViewBind()
        tableScroll()
        loaderSpinner()
    }
    
    private func tableViewBind() {
        homeViewModel?.items.bind(to:(self.homeTableView.rx.items(cellIdentifier: HomeVC.cellIdentifierDemoCell, cellType: HomeTableViewCell.self))){ row,branch,cell in
            cell.reloadCellProudctImage(image: branch)
            cell.titleLabel?.text = branch.title
        }.disposed(by: self.disposeBag )
    }
    
    func tableScroll() {
        
        homeTableView.rx.didScroll.subscribe { [weak self] _ in
            guard let self = self else { return }
            let offSetY = self.homeTableView.contentOffset.y
            let contentHeight = self.homeTableView.contentSize.height
            
            if offSetY > (contentHeight - self.homeTableView.frame.size.height - 100) {
                self.homeViewModel?.fetch()
            }
        }
        .disposed(by: disposeBag)
    }
    
    private func loaderSpinner() {
        homeViewModel?.isLoadingSpinnerAvaliable.subscribe { [weak self] isAvaliable in
            guard let isAvaliable = isAvaliable.element,
                  let self = self else { return }
            self.homeTableView.tableFooterView = isAvaliable ? self.viewSpinner : UIView(frame: .zero)
        }
        .disposed(by: disposeBag)
        
        homeViewModel?.refreshControlCompelted.subscribe { [weak self] _ in
            guard let self = self else { return }
            self.refreshControl.endRefreshing()
        }
        .disposed(by: disposeBag)
    }
    
    @objc private func refreshControlTriggered() {
        homeViewModel?.refreshControlAction.onNext(())
    }
}


//MARK: - TableViewDelegate
extension HomeVC:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
