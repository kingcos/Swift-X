//
//  ViewController.swift
//  01-ImageViewer
//
//  Created by 买明 on 20/02/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let cellId = "image_cell"
    var images = Array<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Image Viewer"
        
        // 文件管理器
        let manager = FileManager.default
        // 包含资源的全路径名（Assets.xcassets 内不支持通过 Bundle 加载）
        let path = Bundle.main.resourcePath!
        // 使用 try! 即可不抛出异常，但当异常发生时将导致程序崩溃
        let items = try! manager.contentsOfDirectory(atPath: path)
        
        for item in items {
//            print(item)
            
            if item.hasPrefix("IMG") {
                images.append(item)
            }
        }
        
        // 注册表格项，不再需要指定 ID
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 重复利用 cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = images[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let imageName = images[indexPath.row]
        // 初始化 Storyboard
        let storyboard = UIStoryboard(name: String(describing: MMImageViewController.self), bundle: nil)
        if let imageVC = storyboard.instantiateInitialViewController() as? MMImageViewController {
            imageVC.imageName = imageName
            // 导航器 Push
            navigationController?.pushViewController(imageVC, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

