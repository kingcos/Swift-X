//
//  LikeViewController.swift
//  TableView-Demo
//
//  Created by 买明 on 15/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class LikeViewController: UITableViewController {
    
    var image: Image?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refresh()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let type = LikeType(rawValue: indexPath.row) {
            image?.like = type
        }
        
        refresh()
    }
    
    func refresh() {
        for index in 0...LikeType.counter.rawValue {
            let indexPath = IndexPath(row: index, section: 0)
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = image?.like.rawValue == index ? .checkmark : .none
        }
    }
}
