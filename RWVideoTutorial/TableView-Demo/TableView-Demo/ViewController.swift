//
//  ViewController.swift
//  TableView-Demo
//
//  Created by 买明 on 12/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var imageSets = [ImageSet]()
    
    func setupImages() {
        imageSets = ImageSet.imageSets()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        setupImages()
        
        automaticallyAdjustsScrollViewInsets = false
        navigationItem.rightBarButtonItem = editButtonItem
        tableView.allowsSelectionDuringEditing = true
        tableView.estimatedRowHeight = 70.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // Setup CustomViewController imageName
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToEdit" {
            if let editController = segue.destination as? EditViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let section = imageSets[indexPath.section]
                    let image = section.images[indexPath.row]
                    
                    editController.image = image
                }
            }
        }
    }
    
    // Disabled the segue when editing
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "ImageDetails" && isEditing {
            return false
        }
        
        return true
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    // How many ROWs in each SECTION
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // It will display another row when editing in each section
        let offset = isEditing ? 1 : 0
        return imageSets[section].images.count + offset
    }
    
    // What's in the CELL of the ROW
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        let section = imageSets[indexPath.section]
        
        if isEditing && indexPath.row >= section.images.count {
            cell = tableView.dequeueReusableCell(withIdentifier: "NewCell", for: indexPath)
            
            cell.textLabel?.text = "Add New Image"
            cell.imageView?.image = nil
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath)
            
            if let imageCell = cell as? CustomTableViewCell {
                let image = section.images[indexPath.row]
                
                imageCell.label.text = image.name
                imageCell.mainImageView.image = image.image
                imageCell.likeImageView.image = UIImage(named: LikeType.toString(image.like))
            }
        }
        
        return cell
    }
    
    // How many SECTIONs in this UITableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return imageSets.count
    }
    
    // Set HEADER for each section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return imageSets[section].type.rawValue
    }
    
    // Setup when EDITing
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if editing {
            tableView.beginUpdates()
            
            for (section, set) in imageSets.enumerated() {
                let indexPath = IndexPath(row: set.images.count, section: section)
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
            
            tableView.endUpdates()
            tableView.setEditing(true, animated: true)
        } else {
            tableView.beginUpdates()
            
            for (section, set) in imageSets.enumerated() {
                let indexPath = IndexPath(row: set.images.count, section: section)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
            tableView.endUpdates()
            tableView.setEditing(false, animated: true)
        }
    }
    
    // Setup EDITING STYLE
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        let section = imageSets[indexPath.section]
        
        if indexPath.row >= section.images.count {
            return .insert
        } else {
            return .delete
        }
    }
    
    // Commit edit
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let section = imageSets[indexPath.section]
        
        if editingStyle == .delete {
            section.images.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if editingStyle == .insert {
            let newImage = Image("Demo Image", "", imageSets[indexPath.section].type)
            section.images.append(newImage)
            
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    // Setup when user WILL select a row
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let section = imageSets[indexPath.section]
        
        if isEditing && indexPath.row < section.images.count {
            return nil
        }
        
        return indexPath
    }
    
    // Setup when user DID select a row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let section = imageSets[indexPath.section]
        if isEditing && indexPath.row >= section.images.count {
            self.tableView(tableView, commit: .insert, forRowAt: indexPath)
        }
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        let section = imageSets[indexPath.section]
        
        if isEditing && indexPath.row >= section.images.count {
            return false
        }
        
        return true
    }
    
    // Move row from sourceIndexPath to destinationIndexPath
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let sourceSection = imageSets[sourceIndexPath.section]
        let desitinationSection = imageSets[destinationIndexPath.section]
        let image = sourceSection.images[sourceIndexPath.row]
        
        if sourceSection == desitinationSection {
            if sourceIndexPath.row != destinationIndexPath.row {
                swap(&desitinationSection.images[sourceIndexPath.row], &desitinationSection.images[destinationIndexPath.row])
            }
        } else {
            desitinationSection.images.insert(image, at: destinationIndexPath.row)
            sourceSection.images.remove(at: sourceIndexPath.row)
        }
    }
    
    //
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        let section = imageSets[proposedDestinationIndexPath.section]
        
        if proposedDestinationIndexPath.row >= section.images.count {
            return IndexPath(item: section.images.count - 1, section: proposedDestinationIndexPath.section)
        }
        return proposedDestinationIndexPath
    }
    
    
}
