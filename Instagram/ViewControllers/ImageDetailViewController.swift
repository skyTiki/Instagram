//
//  ImageDetailViewController.swift
//  Instagram
//
//  Created by takatoshi.ichige on 2021/05/17.
//

import UIKit
import FirebaseUI

class ImageDetailViewController: UIViewController {

    var postId = ""
    @IBOutlet weak var detailImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postId + ".jpg")
        detailImageView.sd_setImage(with: imageRef)
        
    }
    

}
