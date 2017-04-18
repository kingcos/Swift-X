//
//  StatusView.swift
//  CALayer-Demo
//
//  Created by 买明 on 11/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class StatusView: UIView {
    
    let bgLayer = CAShapeLayer()
    let fgLayer = CAShapeLayer()
    
    let bgColor = UIColor.gray
    let fgColor = UIColor.black
    
    var label: UILabel?
    var currentValue: CGFloat = 0 {
        didSet {
            animate()
        }
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
        label = subviews[0] as? UILabel
        
        bgLayer.lineWidth = 20.0
        bgLayer.fillColor = nil
        bgLayer.strokeEnd = 1.0
        layer.addSublayer(bgLayer)
        
        fgLayer.lineWidth = 20.0
        fgLayer.fillColor = nil
        fgLayer.strokeEnd = 0
        layer.addSublayer(fgLayer)
        
        bgLayer.strokeColor = bgColor.cgColor
        fgLayer.strokeColor = fgColor.cgColor

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupCAShapeLayer(bgLayer)
        setupCAShapeLayer(fgLayer)
    }
    
    private func setupCAShapeLayer(_ shapeLayer: CAShapeLayer) {
        shapeLayer.frame = bounds
        
        let startAngle = 135.0 * CGFloat.pi / 180.0
        let endAngle = 45.0 * CGFloat.pi / 180.0
        let center = label?.center
        let radius = bounds.width * 0.35
        
        let path = UIBezierPath(arcCenter: center!,
                                radius: radius,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        shapeLayer.path = path.cgPath
    }

    private func animate() {
        label?.text = String(format: "%.0f/10", currentValue)
        
        var fromValue = fgLayer.strokeEnd
        let toValue = currentValue / 10.0
        
        if let presentationLayer = fgLayer.presentation() {
            fromValue = presentationLayer.strokeEnd
        }
        let percentChange = abs(fromValue - toValue)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = fromValue
        animation.toValue = toValue
        
        animation.duration = CFTimeInterval(percentChange * 4)
        
        fgLayer.removeAnimation(forKey: "stroke")
        fgLayer.add(animation, forKey: "stroke")
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        fgLayer.strokeEnd = toValue
        CATransaction.commit()
    }
}
