//
//  AvatarView.swift
//  CALayer-Demo
//
//  Created by 买明 on 11/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class AvatarView: UIView {
    
    let layerGradient = CAGradientLayer()
    let layerAvatar = CAShapeLayer()
    
//    var imageView: UIImageView?
    
    struct LayerProp {
        let shadowRadius: CGFloat = 20.0
        let shadowOpacity: Float = 0.5
        let shadowOffset = CGSize.zero
    }
    
    struct GradientLayerProp {
        let startColor = UIColor.red
        let endColor = UIColor.blue
        
        let startPoint = CGPoint(x: 0.5, y: 0)
        let endPoint = CGPoint(x: 0.5, y: 1)
    }
    
    struct ImageViewLayerProp {
        let borderColor = UIColor.black
        let borderWidth: CGFloat = 5.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        layer.addSublayer(layerGradient)
        
        // Layer Shadow
        let layerProp = LayerProp()
        layer.shadowRadius = layerProp.shadowRadius
        layer.shadowOpacity = layerProp.shadowOpacity
        layer.shadowOffset = layerProp.shadowOffset
        
        layerAvatar.fillColor = nil
        layerAvatar.lineWidth = 10.0
        layerAvatar.contentsGravity = kCAGravityResizeAspectFill
        layer.addSublayer(layerAvatar)
        layerAvatar.contents = UIImage(named: "avatar")?.cgImage
        layerAvatar.strokeColor = UIColor.white.cgColor
        
//        imageView = subviews[0] as? UIImageView
//        imageView?.image = UIImage(named: "avatar")
//        
//        // Layer Border
//        let ivLayerProp = ImageViewLayerProp()
//        imageView?.layer.borderColor = ivLayerProp.borderColor.cgColor
//        imageView?.layer.borderWidth = ivLayerProp.borderWidth
//        imageView?.layer.masksToBounds = true
//        
//        imageView?.contentMode = .scaleAspectFit
//        addSubview(imageView!)
        
        // Gradient Layer
        let gLayerProp = GradientLayerProp()
        layerGradient.colors = [gLayerProp.startColor.cgColor,
                                gLayerProp.endColor.cgColor]
        layerGradient.startPoint = gLayerProp.startPoint
        layerGradient.endPoint = gLayerProp.endPoint
//        layerGradient.locations = [0, 1, 1]
    }
    
    override func layoutSubviews() {
//        imageView?.layer.cornerRadius = (imageView?.bounds.height)! / 2.0
        
        layerAvatar.frame = CGRect(x: (bounds.width - bounds.height) / 2.0, y: 10.0, width: bounds.height - 20.0, height: bounds.height - 20.0)
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(ovalIn: layerAvatar.bounds).cgPath
        layerAvatar.mask = maskLayer
        layerAvatar.path = maskLayer.path
        
        layerGradient.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
    }
    
    
    
}
