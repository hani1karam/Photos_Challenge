//
//  DataUser.swift
//  Photos_Challenge
//
//  Created by hany karam on 5/18/22.
//

import Foundation
extension DataUser{
    func convertToTodo() -> ItemModel {
        ItemModel(
            id:id,
            image: image)
    }
}
