//
//  ViewEventsViewController.swift
//  Clubhub
//
//  Created by Alex Pegram on 4/18/18.
//  Copyright © 2018 Nicholas Baldini. All rights reserved.
//

import UIKit
import Alamofire

class ViewEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let URL_VIEW_EVENTS = "http://cgi.soic.indiana.edu/~team53/v1/clubevents.php"
    
    let defaultValues = UserDefaults.standard
    
    var eventsArray = [AnyObject]()

    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            //print(userid!)
            let parameters: Parameters=["clubid":self.defaultValues.string(forKey: "clubid")!
            ]
            
            //making a post request
            Alamofire.request(URL_VIEW_EVENTS, method: .get,  parameters: parameters).responseJSON { response in
                //printing response
                print(response)
                
                //getting the json value from the server
                let result = response.result
                if let dict = result.value as? Dictionary<String,AnyObject>{
                    if let innerDict = dict["clubs"]{
                        self.eventsArray = innerDict as! [AnyObject]
                        self.tableView.reloadData()
                    }
                }
                print(self.eventsArray)
            }
        
        //Title
        self.title = "ClubHub"
        
        //Title Font, color, and position
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white, NSAttributedStringKey.font: UIFont(name: "Arial", size: 40.0)!];
        self.navigationController!.navigationBar.setTitleVerticalPositionAdjustment(8, for: UIBarMetrics.default)
        
        //Menu Button
        btnMenuButton.target = revealViewController()
        btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        
        // Do any additional setup after loading the view.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Get the count of the Array
        return(eventsArray.count)
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventcell") as! EventTableViewCell
        //let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        let lat = eventsArray[indexPath.row]["eventCoordOne"] as? String
        let long = eventsArray[indexPath.row]["eventCoordTwo"] as? String
        let desc = "Address: "+lat!+" "+long!+"\n\n About: "
        let desctwo = eventsArray[indexPath.row]["eventDesc"] as? String
        let evname = eventsArray[indexPath.row]["eventName"] as? String
        cell.eventName.text = evname?.uppercased()
        let create = "Created by:\n"
        let person = eventsArray[indexPath.row]["name"] as? String
        cell.createdBy.text = create+person!
        let time = eventsArray[indexPath.row]["eventTime"] as? String
        let date = eventsArray[indexPath.row]["eventDate"] as? String
        cell.eventDate.text = date!+"\n"+time!
        cell.eventDesc.text = desc+desctwo!
        
        //cell.textLabel?.text = maplocationsArray[indexPath.row]["clubName"] as? String
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        
        
        return(cell)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //CREATE CELL
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventcell") as! EventTableViewCell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
