//
//  MMImageViewController.swift
//  01-ImageViewer
//
//  Created by 买明 on 20/02/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit
import Social

class MMImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = imageName
        // 导航器右上按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                            target: self,
                                                            action: #selector(rightShareButtonClick))
        if let image = imageName {
            imageView.image = UIImage(named: image)
        }
    }

    func rightShareButtonClick() {
        // UIActivityViewController
//        let activityVC = UIActivityViewController(activityItems: [imageView.image!],
//                                                  applicationActivities: [])
//        activityVC.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
//        present(activityVC, animated: true)
        
        // 分享到 iOS 内置社交媒体：需要导入 Social
        if let slcVC = SLComposeViewController(forServiceType: SLServiceTypeSinaWeibo) {
            slcVC.setInitialText("测试分享新浪微博")
            slcVC.add(imageView.image!)
            slcVC.add(URL(string: "maimieng.com"))
            
            present(slcVC, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
