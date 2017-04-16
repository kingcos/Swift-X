//
//  TableViewController.swift
//  TableView-Demo
//
//  Created by 买明 on 12/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var sections: [[Image?]?]!

    func setupImages() {
        let sectionTitlesCount = UILocalizedIndexedCollation.current().sectionTitles.count
        sections = [[Image?]?](repeating: nil, count: sectionTitlesCount)
        
        let imageSets = ImageSet.imageSets()
        for imageSet in imageSets {
            for image in imageSet.images {
                let collation = UILocalizedIndexedCollation.current()
                let selectionNumber = collation.section(for: image, collationStringSelector: #selector(getter: MTLFunction.name))
                
                if sections[selectionNumber] == nil {
                    sections[selectionNumber] = [Image?]()
                }
                sections[selectionNumber]?.append(image)
            }
        }
        
        for index in 0..<sections.count {
            if let imageSet = sections[index] {
                sections[index] = imageSet.sorted(by: <)
            }
        }
        
        tableView.allowsSelectionDuringEditing = true
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 70.0
        
        automaticallyAdjustsScrollViewInsets = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImages()
    }
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    // How many ROWs in each SECTION
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = sections[section] else {
            return 0
        }
        
        return section.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath)
        let section = sections[indexPath.section]!

        if let imageCell = cell as? CustomTableViewCell {
            let image = section[indexPath.row]
            
            imageCell.label.text = image!.name
            imageCell.mainImageView.image = image!.image
            imageCell.likeImageView.image = UIImage(named: LikeType.toString(image!.like))
        }
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return UILocalizedIndexedCollation.current().sectionTitles[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Setup CustomViewController imageName
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToEdit" {
            if let editController = segue.destination as? EditViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let section = sections[indexPath.section]!
                    let image = section[indexPath.row]
                    
                    editController.image = image
                }
            }
        }
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return UILocalizedIndexedCollation.current().sectionTitles
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return UILocalizedIndexedCollation.current().section(forSectionIndexTitle: index)
    }
}

func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}
