//
//  DetailsVC.swift
//  Photos_Challenge
//
//  Created by hany karam on 5/21/22.
//

import UIKit

class DetailsVC: UIViewController {
    @IBOutlet weak var img: UIImageView!
    var image:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageLoader.sharedLoader.imageForUrl(urlString: image ?? "") { (image, url) in
            DispatchQueue.main.async {
                self.img?.image = image
            }
        }
    }
}
