//
//  ItemModel.swift
//  Photos_Challenge
//
//  Created by hany karam on 5/18/22.
//

struct ItemModel: Codable {
    let id : String?
    let image : String?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case image = "image"
    }
}
