//
//  Container + ViewModel.swift
//  Photos_Challenge
//
//  Created by hany karam on 5/17/22.
//

import Swinject
import SwinjectAutoregistration
import NetworkManager
extension Container {
    func registerViewModel() {
        autoregister(HomeViewModel.self, initializer: HomeViewModel.init)
        autoregister(HomeUseCase.self, initializer: HomeUseCase.init)
        autoregister(DatabaseManagerProtocol.self, initializer: DatabaseManager.init)
    }
    func registerCoordinator() {
        autoregister(AppCoordinator.self, initializer: AppCoordinator.init)
        autoregister(PhotosViewCoordinator.self, initializer: PhotosViewCoordinator.init)
        autoregister(HomeRepository.self, initializer: HomeRepositoryImpl.init)
        autoregister(HomeDataSource.self, initializer: HomeDataSourceImpl.init)
        autoregister(DataProviderProtocol.self, initializer: APIClient.init)
    }
}
