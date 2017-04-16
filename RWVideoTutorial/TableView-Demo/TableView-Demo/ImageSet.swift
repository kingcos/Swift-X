//
//  ImageSet.swift
//  TableView-Demo
//
//  Created by 买明 on 12/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class ImageSet: Equatable {
    let type: ImageType
    var images = [Image]()
    
    init(_ type: ImageType, _ images: [Image]) {
        self.type = type
        self.images = images
    }
    
    class func initSceneImages() -> ImageSet {
        var images = [Image]()
        
        images.append(Image("电线杆", "myins_01", .scene))
        images.append(Image("天空", "myins_02", .scene))
        images.append(Image("乳酸菌", "myins_03", .scene))
        images.append(Image("键盘", "myins_04", .scene))
        images.append(Image("线条", "myins_05", .scene))
        
        return ImageSet(.scene, images)
    }
    
    class func initHandwritingImages() -> ImageSet {
        var images = [Image]()
        
        images.append(Image("凌乱的字", "myins_11", .handwriting))
        
        return ImageSet(.handwriting, images)
    }
    
    class func imageSets() -> [ImageSet] {
        return [ImageSet.initSceneImages(), ImageSet.initHandwritingImages()]
    }
    
}

func ==(lhs: ImageSet, rhs: ImageSet) -> Bool {
    return lhs.type == rhs.type && lhs.images.count == rhs.images.count
}
