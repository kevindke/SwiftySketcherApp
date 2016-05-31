//
//  NameViewController.swift
//  SwiftySketcherApp
//
//  Created by Shijir Tsogoo on 5/30/16.
//  Copyright © 2016 Shijir Tsogoo. All rights reserved.
//

import UIKit
import Firebase

class NameViewController: UIViewController {
    
    var creatingSession:Bool = false;
    
    @IBOutlet var nameField: UITextField!

    @IBAction func nameEntered(sender: AnyObject) {
        
        //if true, create a new session
        if self.creatingSession {
            
            //Create new session key in Firebase
            let newSession = FIRDatabase.database().reference().child("Sessions").childByAutoId()
            //Passing the unique Id of the device to creator field
            let deviceUniqID:String = UIDevice.currentDevice().identifierForVendor!.UUIDString
            
            newSession.child("CreatorDevice").setValue(deviceUniqID)
            newSession.child("CreatorName").setValue(nameField.text)
        
            
        
        }
        //if false, join an existing session
        else{
        
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
