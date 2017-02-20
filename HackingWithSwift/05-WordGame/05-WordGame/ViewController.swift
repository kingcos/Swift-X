//
//  ViewController.swift
//  05-WordGame
//
//  Created by 买明 on 20/02/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UITableViewController {
    
    let cellId = "cell_id"
    var allWords = Array<String>()
    var usedWords = Array<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(inputAnswer))
        
        // 获取文件路径
        guard let startWordsPath = Bundle.main.path(forResource: "start", ofType: "txt") else { return }
        // 读取文件内容
        guard let startWords = try? String(contentsOfFile: startWordsPath) else { return }
        // 分割内容为数组
        allWords = startWords.components(separatedBy: "\n")
        
        // 注册表格项
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        startGame()
    }
    
    func inputAnswer() {
        let alertController = UIAlertController(title: "输入答案",
                                                message: nil,
                                                preferredStyle: .alert)
        // 提示框添加文本输入框
        alertController.addTextField()
        alertController.addAction(UIAlertAction(title: "提交",
                                                style: .default,
                                                handler: { (action) in
                                                    let answerField = alertController.textFields![0]
                                                    if let answer = answerField.text {
                                                        self.submit(answer: answer)
                                                    }
        }))
        
        present(alertController, animated: true)
    }
    
    func startGame() {
        // 打乱数组
        allWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allWords) as! Array<String>
        
        title = allWords[0]
        // 清空数组但保留容量
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    func submit(answer: String) {
        // 统一为小写
        let lowerAnswer = answer.lowercased()
        let errorTitle = "ERROR"
        let errorMessage: String
        
        // 验证答案
        if isPossible(lowerAnswer) {
            if isUsed(lowerAnswer) {
                if isRight(lowerAnswer) {
                    // 答案正确填入第一条
                    usedWords.insert(lowerAnswer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    
                    return
                } else {
                    errorMessage = "这个答案不正确哦"
                }
            } else {
                errorMessage = "这个答案已经有了哦"
            }
        } else {
            errorMessage = "这个答案不可能存在哦"
        }
        
        let alertController = UIAlertController(title: errorTitle,
                                                message: errorMessage,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",
                                                style: .default))
        present(alertController, animated: true)
    }
    
    func isPossible(_ word: String) -> Bool {
        // 判断输入的答案是否在题目中
        let temp = title!.lowercased()
        return temp.contains(word)
    }
    
    func isUsed(_ word: String) -> Bool {
        // 判断输入的答案是否已使用
        return !usedWords.contains(word)
    }
    
    func isRight(_ word: String) -> Bool {
        // 判断输入的答案是否未合法单词
        
        // UITextChecker 文本检查器
        let checker = UITextChecker()
        // NSRange
        let range = NSMakeRange(0, word.utf16.count)
        // 检查英文拼写
        let misspelledRange = checker.rangeOfMisspelledWord(in: word,
                                                            range: range,
                                                            startingAt: 0,
                                                            wrap: false,
                                                            language: "en")
        // 返回拼写是否正确
        return misspelledRange.location == NSNotFound
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

