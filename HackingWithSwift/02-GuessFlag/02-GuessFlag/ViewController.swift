//
//  ViewController.swift
//  02-GuessFlag
//
//  Created by 买明 on 20/02/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    @IBOutlet weak var flagButtonA: UIButton!
    @IBOutlet weak var flagButtonB: UIButton!
    @IBOutlet weak var flagButtonC: UIButton!
    
    var countries = Array<String>()
    var correctAnswer = 0
    var score = 0
    
    @IBAction func flagButtonClick(_ sender: UIButton) {
        var title: String
        
        // 判断
        if sender.tag == correctAnswer {
            title = "猜对啦"
            score += 1
        } else {
            title = "猜错咯"
            score -= 1
        }
        
        // UIAlertController .alert 中间弹窗 .actionSheet 底部弹窗
        let alertController = UIAlertController(title: title,
                                                message: "分数：\(score)",
                                                preferredStyle: .alert)
        // 添加按钮
        alertController.addAction(UIAlertAction(title: "继续",
                                                style: .default,
                                                handler: guess))
        present(alertController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 按钮边框宽度
        flagButtonA.layer.borderWidth = 5
        flagButtonB.layer.borderWidth = 5
        flagButtonC.layer.borderWidth = 5
        
        // 按钮边框颜色 注意类型 cgColor
        flagButtonA.layer.borderColor = UIColor.red.cgColor
        flagButtonB.layer.borderColor = UIColor.red.cgColor
        flagButtonC.layer.borderColor = UIColor.red.cgColor
        
        flagButtonA.tag = 0
        flagButtonB.tag = 1
        flagButtonC.tag = 2
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        guess()
    }
    
    // 可选参数
    func guess(action: UIAlertAction! = nil) {
        // 利用 GameplayKit 的 GKRandomSource 打乱数组
        countries = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: countries) as! Array<String>
        
        // 取前三个设置图片
        flagButtonA.setImage(UIImage(named: countries[0]), for: .normal)
        flagButtonB.setImage(UIImage(named: countries[1]), for: .normal)
        flagButtonC.setImage(UIImage(named: countries[2]), for: .normal)
        
        // 返回小于某数的整数
        correctAnswer = GKRandomSource.sharedRandom().nextInt(upperBound: 3)
        title = countries[correctAnswer]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

