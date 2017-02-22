//
//  ViewController.swift
//  09-GuessLetter
//
//  Created by 买明 on 22/02/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
    // 注意在 Storyboard 设置 Lines 为 0
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var inputText: UITextField!
    
    var letterButtons = Array<UIButton>()
    var selectedButtons = Array<UIButton>()
    var solutions = Array<String>()
    var difficultyLevel = 1
    
    var score = 0 {
        didSet {
            // 属性观察器：设置值后自动调用
            scoreLabel.text = "分数：\(oldValue)"
        }
    }
    @IBAction func clickLetterButton(_ sender: UIButton) {
        inputText.text = inputText.text! + (sender.titleLabel?.text)!
        selectedButtons.append(sender)
        sender.isHidden = true
    }
    
    @IBAction func clickSubmitButton(_ sender: UIButton) {
        // 如果答对了
        if let solutionPosition = solutions.index(of: inputText.text!) {
            selectedButtons.removeAll()
            
            // 将显示字母数处换为答案
            var splitHint = answerLabel.text!.components(separatedBy: "\n")
            splitHint[solutionPosition] = inputText.text!
            answerLabel.text = splitHint.joined(separator: "\n")
            
            inputText.text = ""
            score += 1
            
            // 升级
            if score % 7 == 0 {
                let alertController = UIAlertController(title: "干得漂亮！",
                                                        message: "要挑战下一关吗？",
                                                        preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Go!",
                                                        style: .default,
                                                        handler: levelUp))
                present(alertController, animated: true)
            }
        }
    }
    
    @IBAction func clickClearButton(_ sender: UIButton) {
        // 清空处理
        inputText.text?.removeAll()
        
        for button in selectedButtons {
            button.isHidden = false
        }
        
        selectedButtons.removeAll()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 根据 Tag 得到所有的 letterButton
        for subview in view.subviews where subview.tag == 1001 {
            letterButtons.append(subview as! UIButton)
        }
        
        // 加载
        loadLevel()
    }
    
    func loadLevel() {
        var hintString = ""
        var solutionString = ""
        var letterBits = Array<String>()
        
        guard let path = Bundle.main.path(forResource: "level\(difficultyLevel)", ofType: "txt") else { return }
        guard let contents = try? String(contentsOfFile: path) else { return }
        
        // 分割为每一行内容
        var lines = contents.components(separatedBy: "\n")
        // 随机打乱
        lines = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: lines) as! [String]
        
        // 按行取
        for (index, line) in lines.enumerated() {
            // 分割答案和提示 TW|ITT|ER: Short online chirping
            let parts = line.components(separatedBy: ": ")
            // TW|ITT|ER
            let answer = parts[0]
            // Short online chirping
            let hint = parts[1]
            
            // 1. Short online chirping
            hintString += "\(index + 1). \(hint)\n"
            
            // TWITTER
            let solutionWord = answer.replacingOccurrences(of: "|", with: "")
            solutionString += "\(solutionWord.characters.count) 个字母\n"
            solutions.append(solutionWord)
            
            // ["TW", "ITT", "ER"]
            let bits = answer.components(separatedBy: "|")
            letterBits += bits
        }
        
        print(hintString)
        hintLabel.text = hintString.trimmingCharacters(in: .whitespacesAndNewlines)
        answerLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        letterBits = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: letterBits) as! Array<String>
        if letterBits.count == letterButtons.count {
            for i in 0..<letterBits.count {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
    }
    
    func levelUp(action: UIAlertAction) {
        difficultyLevel += 1
        solutions.removeAll()
        loadLevel()
        
        for btn in letterButtons {
            btn.isHidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

