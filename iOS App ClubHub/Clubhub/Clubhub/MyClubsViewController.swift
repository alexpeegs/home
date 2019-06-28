//
//  MyClubsViewController.swift
//  Clubhub
//
//  Created by Alex Pegram on 4/16/18.
//  Copyright © 2018 Nicholas Baldini. All rights reserved.
//

import UIKit
import Alamofire

class MyClubsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let URL_MY_CLUBS = "http://cgi.soic.indiana.edu/~team53/v1/userclubs.php"
    
    let defaultValues = UserDefaults.standard
    @IBOutlet weak var tableView: UITableView!
    
    var myclubsArray = [AnyObject]()
    var myclubArray = [AnyObject]()
    
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let defaultValues = UserDefaults.standard
        if let userid = defaultValues.string(forKey: "userid") {
        //print(userid!)
            let parameters: Parameters=["userid": userid
        ]
        
        //making a post request
        Alamofire.request(URL_MY_CLUBS, method: .get,  parameters: parameters).responseJSON { response in
            //printing response
            //print(response)
            
            //getting the json value from the server
            let result = response.result
            if let dict = result.value as? Dictionary<String,AnyObject>{
                if let innerDict = dict["clubs"]{
                    self.myclubsArray = innerDict as! [AnyObject]
                    self.tableView.reloadData()
                }
            }
            print(self.myclubsArray)
        }
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
        return(myclubsArray.count)
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell") as! MyCustomTableViewCell
        //let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.mapLbl.text = myclubsArray[indexPath.row]["clubName"] as? String
        
        //cell.textLabel?.text = maplocationsArray[indexPath.row]["clubName"] as? String
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        
        
        return(cell)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //CREATE CELL
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell") as! MyCustomTableViewCell
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as?
        //CustomTableViewCell
        //Set Cell TextLabel to the chosen value from the array
        //let title = maplocationsArray[indexPath.row]["clubName"]
        //cell.textLabel?.text = title as? String
        //cell.textLabel?.text.
        //The chosen label displays then displays its location on the map
        if cell.mapLbl.text! == cell.mapLbl.text
        {
            let URL_THIS_CLUB = "http://cgi.soic.indiana.edu/~team53/v1/showclub.php"
            let clubid = myclubsArray[indexPath.row]["clubID"]
            print(clubid!!)
            let parameters: Parameters=["clubid": clubid!!
            ]
            print(parameters)
            
            //making a post request
            Alamofire.request(URL_THIS_CLUB, method: .post,  parameters: parameters).responseJSON { response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    
                    //if there is no error
                        
                        //getting the user from response
                        let user = jsonData.value(forKey: "user") as! NSDictionary
                        print(user)
                    
                        //deleting previously existing values
                        self.defaultValues.removeObject(forKey: "clubhomename")
                        self.defaultValues.removeObject(forKey: "clubid")
                        self.defaultValues.removeObject(forKey: "clubhomeemail")
                        self.defaultValues.removeObject(forKey: "clubhomeabout")
                        self.defaultValues.removeObject(forKey: "clubhomesnippet")
                        //self.defaultValues.removeObject(forKey: "clubhomeaddress")
                        
                        //getting user values
                        let clubname = user.value(forKey: "clubname") as? String
                        let clubid = user.value(forKey: "clubid") as? Int
                        let clubemail = user.value(forKey: "clubemail") as? String
                        let clubabout = user.value(forKey: "clubabout") as? String
                        let clubsnippet = user.value(forKey: "clubsnippet") as? String
                        let clubaddress = user.value(forKey: "clubaddress") as? String
            
                        
                        //saving user values to defaults
                        self.defaultValues.set(clubname, forKey: "clubhomename")
                        self.defaultValues.set(clubid, forKey: "clubid")
                        self.defaultValues.set(clubemail, forKey: "clubhomeemail")
                        self.defaultValues.set(clubabout, forKey: "clubhomeabout")
                        self.defaultValues.set(clubsnippet, forKey: "clubhomesnippet")
                        self.defaultValues.set(clubaddress, forKey: "clubhomeaddress")
                        
                        let ClubHomeViewController = self.storyboard?.instantiateViewController(withIdentifier: "ClubHomeViewcontroller") as! ClubHomeViewController
                        self.navigationController?.pushViewController(ClubHomeViewController, animated: true)
                    
                }
            }
            
        }
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
