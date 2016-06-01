//
//  StartViewController.swift
//  SwiftySketcherApp
//
//  Created by Shijir Tsogoo on 5/30/16.
//  Copyright © 2016 Shijir Tsogoo. All rights reserved.
//

import UIKit
import Firebase

class StartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    typealias sessionTuple = (sessionKey: String, creatorName: String, creatorDevice: String, gameOn: Bool)
    var sessions = [sessionTuple]()
    let sessionsTableIdentifier = "sessionsTableIdentifier"
    var tableViewController = UITableViewController(style: .Plain)
    let deviceUniqID:String = UIDevice.currentDevice().identifierForVendor!.UUIDString

    @IBOutlet var sessionLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    @IBAction func createNewSession(sender: AnyObject) {
        //Create new session key in Firebase
        let newSession = FIRDatabase.database().reference().child("Sessions").childByAutoId()
        //Passing the unique Id of the device to creator field
        
        
        newSession.child("CreatorDevice").setValue(deviceUniqID)
        newSession.child("CreatorName").setValue("New session being created")
        newSession.child("Players").child(deviceUniqID).child("PlayerName").setValue("_")
        newSession.child("GameOn").setValue(false)
        
        let nameViewController = storyboard?.instantiateViewControllerWithIdentifier("nameScreen") as! NameViewController
        
        nameViewController.creatingSession = true
        nameViewController.sessionKey = newSession.key
        nameViewController.deviceID = deviceUniqID
        
        
        self.presentViewController(nameViewController, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        let ref = FIRDatabase.database().reference()
        
        ref.child("Sessions").observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
            
            
            
            if snapshot.exists()  {
            
                let fbSessions = snapshot.value as! [String: AnyObject]
                
                
                for sessionData in fbSessions {
                
                    let _sessionKey = sessionData.0
                    let _creatorName = sessionData.1["CreatorName"] as! String
                    let _creatorDevice = sessionData.1["CreatorDevice"] as! String
                    let _gameOn = sessionData.1["GameOn"] as! Bool
                    
                    let _sessionTuple = sessionTuple(_sessionKey,_creatorName,_creatorDevice,_gameOn)
                    
                

                    self.sessions.append(_sessionTuple)
                    //Array(fbSessions.values)
                
                }
                
                

                if self.sessions.count==1 {
                    
                    self.sessionLabel.text = "There is a session."
                    
                }
                
                if self.sessions.count>1{
                    
                    self.sessionLabel.text = "There are \(self.sessions.count) sessions."
                    
                }
                
                self.tableView.reloadData()
                
            }else{
                
                self.sessionLabel.text = "No sessions. Create your session."
                self.sessions = []
                self.tableView.reloadData()
                
            }

            
            
        })

        // Do any additional setup after loading the view.
    
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sessions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(sessionsTableIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCellStyle.Default,
                reuseIdentifier: sessionsTableIdentifier)
        }
        
        
        cell?.textLabel?.text = self.sessions[indexPath.row].creatorName
        
        
        return cell!
    }
    //selecting tableRow
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
        let nameViewController = storyboard?.instantiateViewControllerWithIdentifier("nameScreen") as! NameViewController
        
        nameViewController.creatingSession = false
        nameViewController.sessionKey = self.sessions[indexPath.row].sessionKey
        nameViewController.deviceID = deviceUniqID
        
        self.presentViewController(nameViewController, animated: true, completion: nil)
        
        
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
