//
//  ViewController.swift
//  GradientEffect
//
//  Created by Lalit Joshi on 09/03/18.
//  Copyright © 2018 Vivek Gajbe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let defaultNavigationBarFrame = CGRect(x: 0, y: 0, width: self.view.frame.size.width , height: 64)
        let gradialLayer = RadialGradientLayer1()
        gradialLayer.frame = defaultNavigationBarFrame
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(self.image(fromLayer: gradialLayer), for: .default)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func image(fromLayer layer: CALayer) -> UIImage {
        UIGraphicsBeginImageContext(layer.frame.size)
        
        layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return outputImage!
    }
    class RadialGradientLayer1: CALayer {
        
        var center: CGPoint {
            return CGPoint(x: bounds.width/2, y: bounds.height)
        }
        
        var radius: CGFloat {
            return (bounds.height * 1.7)
        }

        var colors: [UIColor] = [UIColor.lightGray,UIColor.black] {
            didSet {
                setNeedsDisplay()
            }
        }
        
        var cgColors: [CGColor] {
            return colors.map({ (color) -> CGColor in
                return color.cgColor
            })
        }
        
        override init() {
            super.init()
            needsDisplayOnBoundsChange = true
        }
        
        required init(coder aDecoder: NSCoder) {
            super.init()
        }
        
        override func draw(in ctx: CGContext) {
            ctx.saveGState()
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let locations: [CGFloat] = [0.0, 1.0]
            guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: locations) else {
                return
            }
            ctx.drawRadialGradient(gradient, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: radius, options: CGGradientDrawingOptions(rawValue: 1))
        }
    }

    class RadialGradientView1: UIView {
        
        private let gradientLayer = RadialGradientLayer()
        
        var colors: [UIColor] {
            get {
                return gradientLayer.colors
            }
            set {
                gradientLayer.colors = newValue
            }
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            if gradientLayer.superlayer == nil {
                layer.insertSublayer(gradientLayer, at: 0)
            }
            gradientLayer.frame = bounds
        }
        
    }
}





