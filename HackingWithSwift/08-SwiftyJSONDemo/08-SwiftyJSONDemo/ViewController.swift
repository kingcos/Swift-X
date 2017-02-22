//
//  ViewController.swift
//  08-SwiftyJSONDemo
//
//  Created by 买明 on 21/02/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UITableViewController {
    
    let cellId = "cell_id"
    var news = Array<Dictionary<String, String>>()

    override func viewDidLoad() {
        super.viewDidLoad()

        let apiURL: String
        
        // API Powered by gank.io
        if navigationController?.tabBarItem.tag == 0 {
            apiURL = "https://gank.io/api/history/content/100/1"
        } else {
            apiURL = "https://gank.io/api/history/content/day/2017/02/21"
        }
        
        guard let url = URL(string: apiURL) else { return }
        
        // 注册 Cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        // 解析 JSON
        if let data = try? Data(contentsOf: url) {
            let json = JSON(data: data)
            
            if json["error"] == false {
                parse(json: json)
                return
            }
        }
        
        // 报错
//        showError()
        tableView.performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    func parse(json: JSON) {
        for result in json["results"].arrayValue {
            let title = result["title"].stringValue
            let content = result["content"].stringValue
            
            news.append(["title": title,
                         "content": content])
        }
        
//        tableView.reloadData()
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    }
    
    func showError() {
        let alertController = UIAlertController(title: "出错啦",
                                                message: "请检查网络连接",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",
                                                style: .default))
        present(alertController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = news[indexPath.row]["title"]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.detailItem = news[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

