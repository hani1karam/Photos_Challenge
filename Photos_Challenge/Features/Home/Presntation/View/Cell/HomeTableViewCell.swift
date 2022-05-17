//
//  HomeTableViewCell.swift
//  Photos_Challenge
//
//  Created by hany karam on 5/17/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var bagroundView: UIView?
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var photoImageView: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func reloadCellProudctImage(image: Photo) {
        ImageLoader.sharedLoader.imageForUrl(urlString: image.flickrImageURL() ?? "") { (image, url) in
            DispatchQueue.main.async {
                self.photoImageView?.image = image
            }
        }
    }
    
}
