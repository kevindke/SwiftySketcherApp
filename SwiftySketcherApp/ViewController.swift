//
//  ViewController.swift
//  SwiftySketcherApp
//
//  Created by Shijir Tsogoo on 5/30/16.
//  Copyright © 2016 Shijir Tsogoo. All rights reserved.
//
import Firebase
import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ref = FIRDatabase.database().reference()

        ref.child("Session").observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
 
            let session = snapshot.value as! String
            print(session)
            
            
            
        })
        

   
        
        // Do any additional setup after loading the view, typically from a nib.
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

