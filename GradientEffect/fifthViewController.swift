//
//  fifthViewController.swift
//  GradientEffect
//
//  Created by Lalit Joshi on 13/03/18.
//  Copyright © 2018 Vivek Gajbe. All rights reserved.
//

import UIKit

class fifthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        ////        // Do any additional setup after loading the view, typically from a nib.
        let viw = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height ))
        //viw.backgroundColor = UIColor.green
        
        let gradialLayer = RadialGradientLayer2()
        gradialLayer.frame = viw.bounds
        viw.layer.addSublayer(gradialLayer)
        
        self.view.addSubview(viw)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class RadialGradientLayer2: CALayer {
    
    required override init() {
        super.init()
        needsDisplayOnBoundsChange = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(layer: Any) {
        super.init(layer: layer)
    }
    
    public var colors = [UIColor.gray.cgColor,UIColor.black.cgColor] //[UIColor.red.cgColor, UIColor.blue.cgColor]
    
    override func draw(in ctx: CGContext) {
        ctx.saveGState()
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var locations = [CGFloat]()
        for i in 0...colors.count-1 {
            locations.append(CGFloat(i) / CGFloat(colors.count))
        }
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations)
        let center = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
        let radius = min(bounds.height / 1.7, bounds.height / 1.7)
        ctx.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: radius, options: CGGradientDrawingOptions(rawValue: 0))
    }
}
