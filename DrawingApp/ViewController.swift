//
//  ViewController.swift
//  DrawingApp
//
//  Created by Leo Moon on 2017-06-18.
//  Copyright © 2017 Leo Moon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var drawingImageView: UIImageView!
    
    var lastDrawingPoint = CGPoint.zero
    var didSwiped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        didSwiped = false
        if let touch = touches.first {
            lastDrawingPoint = touch.location(in: self.view)
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        didSwiped = true
        if let touch = touches.first {
            let currentDrawingPoint = touch.location(in: self.view)
            drawLines(fromPoint: lastDrawingPoint, toPoint: currentDrawingPoint)
            
            lastDrawingPoint = currentDrawingPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !didSwiped {
            drawLines(fromPoint: lastDrawingPoint, toPoint: lastDrawingPoint)
        }
    }
    func drawLines(fromPoint: CGPoint, toPoint: CGPoint) {
        UIGraphicsBeginImageContext(self.view.frame.size)
        drawingImageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        context?.setBlendMode(CGBlendMode.normal)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(5)
        context?.setStrokeColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor)
        
        context?.strokePath()
        
        drawingImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext()
    }

}

