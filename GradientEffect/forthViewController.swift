//
//  forthViewController.swift
//  GradientEffect
//
//  Created by Lalit Joshi on 13/03/18.
//  Copyright © 2018 Vivek Gajbe. All rights reserved.
//

import UIKit

class forthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//Working code
        
//        let defaultNavigationBarFrame = CGRect(x: 0, y: 0, width: self.view.frame.size.width , height: 64)
//
//        let gradialLayer = RadialGradientLayer()
//        gradialLayer.frame = defaultNavigationBarFrame
//        self.navigationController?.navigationBar.barTintColor = UIColor(red: 57/255, green: 3/255, blue: 1/255, alpha: 1)
//
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.navigationBar.setBackgroundImage(self.image(fromLayer: gradialLayer), for: .default)
        
        
        
        
//        let viw = UIView(frame: CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: self.view.frame.size.height - 64))
//       // viw.backgroundColor = UIColor.green
//
//        let gradialLayer = RadialGradientLayer()
//        gradialLayer.frame = defaultNavigationBarFrame
        
//        viw.layer.addSublayer(gradialLayer)
//
//        self.view.addSubview(viw)
//        // Do any additional setup after loading the view.
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

    class RadialGradientLayer: CALayer {
        
        var center: CGPoint {
            return CGPoint(x: bounds.width/2, y: bounds.height)
        }
        
        var radius: CGFloat {
            return (bounds.height * 2.0)
        }

        var colors: [UIColor] = [UIColor.gray,UIColor.black] {
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
    
    
    
    class RadialGradientView: UIView {
        
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
