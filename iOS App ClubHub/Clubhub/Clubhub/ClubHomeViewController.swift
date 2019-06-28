//
//  ClubHomeViewController.swift
//  Clubhub
//
//  Created by Alex Pegram on 4/16/18.
//  Copyright © 2018 Nicholas Baldini. All rights reserved.
//

import UIKit
import Alamofire

class ClubHomeViewController: UIViewController {
    
    let URL_JOIN_CLUB = "http://cgi.soic.indiana.edu/~team53/v1/joinclub.php"
    
    let defaultValues = UserDefaults.standard

    
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    
    @IBOutlet weak var clubname: UILabel!
    
    @IBOutlet weak var clubaddress: UILabel!
    
    @IBOutlet weak var clubemail: UILabel!
    
    @IBOutlet weak var clubabout: UILabel!
    
    @IBOutlet weak var clubsnippet: UILabel!
    
    
    @IBAction func createEvent(_ sender: Any) {
        let CreateEventViewController = self.storyboard?.instantiateViewController(withIdentifier: "CreateEventViewController") as! CreateEventViewController
        self.navigationController?.pushViewController(CreateEventViewController, animated: true)
    }
    
    @IBAction func viewEvents(_ sender: Any) {
        
        let ViewEventsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewEventsViewController") as! ViewEventsViewController
        self.navigationController?.pushViewController(ViewEventsViewController, animated: true)
    }
    
    
//    @IBAction func joinClub(_ sender: Any) {
//
//        let parameters: Parameters=[
//            "userid":defaultValues.string(forKey: "userid")!,
//            "clubid":defaultValues.string(forKey: "clubid")!]
//
//        Alamofire.request(URL_JOIN_CLUB, method: .post, parameters: parameters).responseJSON {
//            response in
//            print(response)
//            
//            if let result = response.result.value {
//                let jsonData = result as! NSDictionary
//                print(jsonData.value(forKey: "message") as! String?)
//            }
//            let MyClubsViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyClubsViewController") as! MyClubsViewController
//            self.navigationController?.pushViewController(MyClubsViewController, animated: true)
//        }
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Title
        self.title = "ClubHub"
        
        //Title Font, color, and position
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white, NSAttributedStringKey.font: UIFont(name: "Arial", size: 40.0)!];
        self.navigationController!.navigationBar.setTitleVerticalPositionAdjustment(8, for: UIBarMetrics.default)
        
        //Menu Button
        btnMenuButton.target = revealViewController()
        btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        
        
        
        
        //getting user data from defaults
        let defaultValues = UserDefaults.standard
        if let clubhomename = defaultValues.string(forKey: "clubhomename"){
            //setting the name to label
            clubname.text = clubhomename
        }else{
            //send back to login view controller
        }
        if let email = defaultValues.string(forKey: "clubhomeemail"){
            //setting the name to label
            clubemail.text = email
        }else{
            //send back to login view controller
        }
        if let clubhomeabout = defaultValues.string(forKey: "clubhomeabout"){
            //setting the name to label
            clubabout.text = clubhomeabout
        }else{
            //send back to login view controller
        }
        if let clubhomesnippet = defaultValues.string(forKey: "clubhomesnippet"){
            //setting the name to label
            clubsnippet.text = clubhomesnippet
        }else{
            //send back to login view controller
        }
        if let clubhomeaddress = defaultValues.string(forKey: "clubhomeaddress"){
            //setting the name to label
            clubaddress.text = clubhomeaddress
        }else{
            //send back to login view controller
        }
        
        
        

        // Do any additional setup after loading the view.
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
