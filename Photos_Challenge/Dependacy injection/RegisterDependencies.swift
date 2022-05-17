//
//  RegisterDependencies.swift
//  Photos_Challenge
//
//  Created by hany karam on 5/17/22.
//

import Foundation
import Swinject

extension Container {
    func registerDependencies() {
        registerViewModel()
        registerCoordinator()
    }
    
}
