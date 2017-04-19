//
//  AboutViewController.swift
//  01-Gallery
//
//  Created by 买明 on 19/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1040)
    }

}
