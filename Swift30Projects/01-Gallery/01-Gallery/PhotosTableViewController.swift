//
//  PhotosTableViewController.swift
//  01-Gallery
//
//  Created by 买明 on 19/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class PhotosTableViewController: UITableViewController {

    let cellIdentifier = "PhotoCell"
    var photos: [Photo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photos = Photo.initPhotos()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath)
        let photo = photos![indexPath.row]
        
        cell.textLabel?.text = photo.name
        cell.imageView?.image = UIImage(named: photo.imageName)

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto" {
            if let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell),
            let photoVC = segue.destination as? PhotoViewController {
                photoVC.photo = photos?[indexPath.row]
            }
        }
    }
}
