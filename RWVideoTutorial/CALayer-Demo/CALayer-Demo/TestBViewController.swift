//
//  TestBViewController.swift
//  CALayer-Demo
//
//  Created by 买明 on 11/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class TestBViewController: UIViewController {
    
    @IBOutlet weak var statusView: StatusView!
    @IBOutlet weak var stepper: UIStepper!

    @IBAction func stepperValueDidChange(_ sender: UIStepper) {
        statusView.currentValue = CGFloat(sender.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusView.currentValue = 3.0
        stepper.value = 3.0
        stepper.maximumValue = 10.0
    }

}
