//
//  Image.swift
//  TableView-Demo
//
//  Created by 买明 on 12/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

enum ImageType: String {
    case scene = "scene"
    case handwriting = "handwriting"
}

enum LikeType: Int {
    case like
    case unlike
    case counter
    
    static func toString(_ type: LikeType) -> String {
        switch type {
        case .like:
            return "like_sel"
        case .unlike:
            return "like_un"
        default:
            return ""
        }
    }
}

class Image: NSObject, Comparable {
    var name: String
    var type: ImageType
    var like: LikeType
    var image: UIImage?
    
    init(_ name: String, _ filename: String, _ type: ImageType) {
        self.name = name
        self.type = type
        
        self.like = .unlike
        self.image = UIImage(named: filename)
    }
}

func <(lhs: Image, rhs: Image) -> Bool {
    return lhs.name < rhs.name
}
