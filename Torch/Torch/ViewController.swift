//
//  ViewController.swift
//  Torch
//
//  Created by Manish Kumar on 22/08/18.
//  Copyright © 2018 Innofied. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var barrierView: UIView!
    
    
    var torch : TorchView?
    var maskLayer : CAShapeLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addTorch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addTorch(){
        torch = TorchView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0), parent: self.view)
        torch?.dragDelegate = self
        self.view.addSubview(torch!)
    }
    
}


extension ViewController : DragRecognizerDelegate{
    
    func torchMoved(withPoint point: CGPoint) {
        let torchCentre = point
        let wallStartCoordinates = CGPoint(x: 50.0, y: UIScreen.main.bounds.height - 111.0)

        let deltaX1 = torchCentre.x - wallStartCoordinates.x
        let deltaY1 = torchCentre.y - wallStartCoordinates.y
        let h1 = sqrt((deltaX1 * deltaX1) + (deltaY1 * deltaY1))
        
        let pointX1OnCircumference = ( 150.0 * deltaX1 / h1)
        let pointY1OnCircumference = ( 150.0 * deltaY1 / h1)
        let point1OnCircumference = CGPoint(x: pointX1OnCircumference, y: pointY1OnCircumference)

        let wallEndCoordinates = CGPoint(x: UIScreen.main.bounds.width - 50.0, y: UIScreen.main.bounds.height - 111.0)
       
        let deltaX2 = torchCentre.x - wallEndCoordinates.x
        let deltaY2 = torchCentre.y - wallEndCoordinates.y
        let h2 = sqrt((deltaX2 * deltaX2) + (deltaY2 * deltaY2))
        
        let pointX2OnCircumference = (150.0 * deltaX2 / h2)
        let pointY2OnCircumference = (150.0 * deltaY2 / h2)
        let point2OnCircumference = CGPoint(x: pointX2OnCircumference, y: pointY2OnCircumference)
        
//        print("wallStartCoordinates : \(wallStartCoordinates) ")
//        print("wallEndCoordinates : \(wallEndCoordinates) ")
        print("point1OnCircumference : \(point1OnCircumference) ")
        print("point2OnCircumference : \(point2OnCircumference) ")


        let bezierPathMask = UIBezierPath()
        bezierPathMask.usesEvenOddFillRule = true
        bezierPathMask.move(to: wallStartCoordinates)
        bezierPathMask.addLine(to: wallEndCoordinates)
        bezierPathMask.addLine(to: point1OnCircumference)
        bezierPathMask.addLine(to: point2OnCircumference)
        bezierPathMask.addLine(to: wallStartCoordinates)
        bezierPathMask.close()
        
        if  maskLayer != nil {
            maskLayer?.removeFromSuperlayer()
            maskLayer = nil
        }
        maskLayer = CAShapeLayer()
        maskLayer?.path = bezierPathMask.cgPath
        maskLayer?.fillColor = UIColor.red.cgColor
        torch?.layerForEmitter?.addSublayer(maskLayer!)
        
        
        
        
//        torch?.layerForEmitter?.mask = maskLayer
        
        
    }
}







