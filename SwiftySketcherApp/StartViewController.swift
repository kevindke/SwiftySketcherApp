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
    
    var sessions = []
    let sessionsTableIdentifier = "sessionsTableIdentifier"
    var tableViewController = UITableViewController(style: .Plain)

    @IBOutlet var sessionLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        let ref = FIRDatabase.database().reference()
        
        ref.child("Sessions").observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
            
            
            
            if snapshot.exists()  {
            
                let fbSessions = snapshot.value as! [String: AnyObject]
                self.sessions = Array(fbSessions.values)
                
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
        cell?.textLabel?.text = self.sessions[indexPath.row] as! String
        return cell!
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
