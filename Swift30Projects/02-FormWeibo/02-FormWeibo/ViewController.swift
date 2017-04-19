//
//  ViewController.swift
//  02-FormWeibo
//
//  Created by 买明 on 19/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var birthdayDatePicker: UIDatePicker!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var likeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        birthdayDatePicker.maximumDate = Date()
    }

    @IBAction func slideNumber(_ sender: UISlider) {
        numberLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func clickSubmit(_ sender: UIButton) {
        guard nameTextField.text != "" else {
            showAlert("Tips", "姓名不可以为空哟", "好的")
            return
        }
        
        let name = nameTextField.text!
        let gender = ["男", "女", "保密"][genderSegmentedControl.selectedSegmentIndex]
        
        let gregorian = Calendar(identifier: .gregorian)
        let now = Date()
        let components = (gregorian as NSCalendar).components(NSCalendar.Unit.year, from: birthdayDatePicker.date, to: now, options: [])
        let age = components.year
        let like = likeSwitch.isOn ? "我喜欢这个 Form！" : ""
    
        let tweet = "我是「\(name)」，今年「\(age!)」岁。我的性别是「\(gender)」，我的幸运数字是「\(numberLabel.text!)」。\n\(like)"
        
        showWeibo(tweet)
    }
    
    func showWeibo(_ tweet: String) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeSinaWeibo) {
            let twitterVC = SLComposeViewController(forServiceType: SLServiceTypeSinaWeibo)
            twitterVC?.setInitialText(tweet)
            present(twitterVC!, animated: true, completion: nil)
        } else {
            showAlert("Tips", "您的设备未绑定微博账号，请在设置中绑定后再试。", "好的")
        }
    }

    func showAlert(_ title: String, _ message: String, _ actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
}

