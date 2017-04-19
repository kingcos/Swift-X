//
//  Photo.swift
//  01-Gallery
//
//  Created by 买明 on 19/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import Foundation

class Photo {
    var name: String
    var imageName: String
    
    init(_ name: String, _ imageName: String) {
        self.name = name
        self.imageName = imageName
    }
    
    class func initPhotos() -> [Photo] {
        var photos = [Photo]()
        
        photos.append(Photo("Flower", "150314_3"))
        photos.append(Photo("Mac mini", "150318"))
        photos.append(Photo("Handwriting", "150325"))
        photos.append(Photo("Tree", "151025_2"))
        photos.append(Photo("Reading", "151028_1"))
        
        return photos
    }
}
