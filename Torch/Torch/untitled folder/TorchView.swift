//
//  TorchView.swift
//  Torch
//
//  Created by Manish Kumar on 22/08/18.
//  Copyright © 2018 Innofied. All rights reserved.
//

import UIKit

protocol DragRecognizerDelegate {
    func torchMoved(withPoint point: CGPoint)
}

class TorchView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var sourceTorch : UIView?
    var parentView : UIView?
    var layerForEmitter : CAShapeLayer?
    var dragDelegate : DragRecognizerDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        createRoundTorchView()
    }
    
    
    init(frame: CGRect, parent: UIView) {
        super.init(frame: frame)
        self.parentView = parent
        createRoundTorchView()
    }


    func createRoundTorchView(){
        sourceTorch = UIView(frame: CGRect(x: (UIScreen.main.bounds.width - 40.0)/2.0, y: (UIScreen.main.bounds.height - 40.0)/2.0, width: 40.0, height: 40.0))
        sourceTorch?.backgroundColor = UIColor.white
        sourceTorch?.layer.cornerRadius = 20.0
        sourceTorch?.layer.borderColor = UIColor.black.cgColor
        sourceTorch?.layer.borderWidth = 3.0
        self.parentView!.addSubview(sourceTorch!)
        
        createEmitterForTorch()
        addTouchDragGestureToTorchSource()
    }
    
    func createEmitterForTorch(){
        
        layerForEmitter = CAShapeLayer()
        layerForEmitter!.path = createRoundedBezierPath().cgPath
        layerForEmitter!.lineWidth = 1.0
        layerForEmitter!.fillColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        layerForEmitter!.strokeColor = UIColor(red: 221.0/255.0, green: 221.0/255.0, blue: 221.0/255.0, alpha: 1.0).cgColor
        self.sourceTorch?.layer.addSublayer(layerForEmitter!)
    }
    
    func createRoundedBezierPath() -> UIBezierPath{
        let startAngle = CGFloat(.pi * 3.0/2.0)
        let endAngle = CGFloat(.pi * 2 + (.pi * 3.0/2.0))
        let centerPoint = CGPoint(x: 20.0 , y: 20.0)
        
        let circularPath = UIBezierPath(arcCenter: centerPoint, radius: 150.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        circularPath.close()
        
        return circularPath
        
    }

    
    
    func addTouchDragGestureToTorchSource(){
        
        let dragTorch = UIPanGestureRecognizer(target: self, action:#selector(torchSourceDragged(recognizer:)))
        sourceTorch!.addGestureRecognizer(dragTorch)
    }
    
    @objc func torchSourceDragged(recognizer : UIPanGestureRecognizer){
        
        let point = recognizer.location(in: parentView)

        if dragDelegate != nil{
            dragDelegate?.torchMoved(withPoint: point)
        }
        sourceTorch!.center.x = point.x
        sourceTorch!.center.y = point.y

    }
    
}
