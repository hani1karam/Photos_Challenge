//
//  GetData.swift
//  Photos_Challenge
//
//  Created by hany karam on 5/18/22.
//

import UIKit
func allImages(_ image:[Photo]?) -> String?{
    var images:String?
    for i in 1..<image!.count {
        images = image?[i].flickrImageURL()
    }
    return images
}
func getAllIds(_ ids:[Photo]?) -> String?{
    var id:String?
    for i in 1..<ids!.count {
        id = ids?[i].id
    }
    return id
}
