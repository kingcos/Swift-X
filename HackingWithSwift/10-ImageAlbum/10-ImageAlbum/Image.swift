//
//  Image.swift
//  10-ImageAlbum
//
//  Created by 买明 on 22/02/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

// Image 模型类
class Image: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
