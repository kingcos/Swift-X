//
//  MMImageViewController.swift
//  01-ImageViewer
//
//  Created by 买明 on 20/02/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class MMImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = imageName
        
        if let image = imageName {
            imageView.image = UIImage(named: image)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
