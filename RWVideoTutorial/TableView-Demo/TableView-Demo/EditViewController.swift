//
//  EditViewController.swift
//  TableView-Demo
//
//  Created by 买明 on 15/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class EditViewController: UITableViewController {
    
    var image: Image?
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let image = image else {
            return
        }
        
        mainImageView.image = image.image
        nameTextField.text = image.name
        typeLabel.text = LikeType.toString(image.like)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        image?.image = mainImageView.image
        image?.name = nameTextField.text!
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
        if indexPath.row == 0 && indexPath.section == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.allowsEditing = false
            picker.delegate = self
            present(picker, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToType" {
            if let likeController = segue.destination as? LikeViewController {
                likeController.image = image
            }
        } else if segue.identifier == "GoToDetail" {
            if let detailController = segue.destination as? DetailViewController {
                detailController.image = image
            }
        }
    }
    
}

extension EditViewController: UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            image?.image = pickedImage
            mainImageView.image = pickedImage
            
            dismiss(animated: true)
        }
    }
}
