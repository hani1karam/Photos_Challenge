//
//  ImagesModel.swift
//  Photos_Challenge
//
//  Created by hany karam on 5/17/22.
//

import Foundation
// MARK: - ImagesModel
struct ImagesModel: Codable {
    let photos: Photos?
    let stat: String?
}
// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage, total: Int?
    let photo: [Photo]?
}
// MARK: - Photo
struct Photo: Codable {
    let id, owner, secret, server: String?
    let farm: Int?
    let title: String?
    let ispublic, isfriend, isfamily: Int?
    func flickrImageURL(_ size: String = "m") -> String? {
        if
            let farm = self.farm,
            let server = self.server,
            let id = self.id,
            let secret = self.secret {
            let url =  "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret)_\(size).jpg"
            return url
        }
        return nil
    }

}
