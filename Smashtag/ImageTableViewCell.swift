//
//  imageTableViewCell.swift
//  Smashtag
//
//  Created by Tatiana Kornilova on 7/6/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetImage: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // MARK: - Public API    
    var imageUrl: NSURL? {
        didSet {updateUI()}
    }
    
    private func updateUI() {
        if let url = imageUrl {
            spinner?.startAnimating()
            let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
            dispatch_async(dispatch_get_global_queue(qos, 0)) { () -> Void in
                let imageData = NSData(contentsOfURL: url)
                dispatch_async(dispatch_get_main_queue()) {
                    if url == self.imageUrl {
                        if imageData != nil {
                            self.tweetImage?.image = UIImage(data: imageData!)
                        } else {
                            self.tweetImage?.image = nil
                        }
                        self.spinner?.stopAnimating()
                    }
                }
            }
        }
    }

}
