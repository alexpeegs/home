//
//  ClubTableViewController.swift
//  Clubhub
//
//  Created by Alex Pegram on 4/11/18.
//  Copyright © 2018 Nicholas Baldini. All rights reserved.
//

import UIKit
import Alamofire

class ClubTableViewController: UITableViewController {
    
    let URL_MY_CLUBS = "http://cgi.soic.indiana.edu/~team53/v1/userclubs.php"
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    
    var myclubsArray = [AnyObject]()
    var myclubArray = [AnyObject]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaultValues = UserDefaults.standard
        let userid = defaultValues.string(forKey: "userid")
        print(userid!)
        let parameters: Parameters=["userid": userid!
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
        
        //Title
        self.title = "ClubHub"
        
        //Title Font, color, and position
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white, NSAttributedStringKey.font: UIFont(name: "Arial", size: 40.0)!];
        self.navigationController!.navigationBar.setTitleVerticalPositionAdjustment(8, for: UIBarMetrics.default)
        
        //Menu Button
        btnMenuButton.target = revealViewController()
        btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Get the count of the Array
        return(myclubsArray.count)
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        let title = myclubsArray[indexPath.row]["clubName"]
        cell.textLabel?.text = title as? String
        
        if cell.textLabel?.text == cell.textLabel?.text
        {
                let URL_THIS_CLUB = "http://cgi.soic.indiana.edu/~team53/v1/showclub.php"
                let clubid = myclubsArray[indexPath.row]["clubID"]
                print(clubid!!)
                let parameters: Parameters=["clubid": clubid!!
                ]
            
                //making a post request
                Alamofire.request(URL_THIS_CLUB, method: .get,  parameters: parameters).responseJSON { response in
                    //printing response
                    //print(response)
                    
                    //getting the json value from the server
                    let result = response.result
                    if let dict = result.value as? Dictionary<String,AnyObject>{
                        if let innerDict = dict["clubs"]{
                            self.myclubArray = innerDict as! [AnyObject]
                            self.tableView.reloadData()
                        }
                    }
                    print(self.myclubArray)
                }
                return cell
        }
        else {
            return cell
        }
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
