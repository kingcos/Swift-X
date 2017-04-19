//
//  PhotoViewController.swift
//  01-Gallery
//
//  Created by 买明 on 19/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var photo: Photo?
    
    @IBAction func clickLike(_ sender: UIButton) {
        print(#function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let imageName = photo?.imageName {
            imageView.image = UIImage(named: imageName)
        }
    }

}
