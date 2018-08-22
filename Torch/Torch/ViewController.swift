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
        let wallEndCoordinates = CGPoint(x: UIScreen.main.bounds.width - 50.0, y: UIScreen.main.bounds.height - 111.0)

        
        
    }
}







