//
//  UpdateViewController.swift
//  Clubhub
//
//  Created by Alex Pegram on 4/5/18.
//  Copyright © 2018 Nicholas Baldini. All rights reserved.
//

import UIKit
import Alamofire

class UpdateViewController: UIViewController {
    
    //The login script url make sure to write the ip instead of localhost
    //you can get the ip using ifconfig command in terminal
    let URL_USER_UPDATE = "http://cgi.soic.indiana.edu/~team53/v1/updateuser.php"
    
    //the defaultvalues to store user data
    let defaultValues = UserDefaults.standard
    
    //the connected views
    //don't copy instead connect the views using assistant editor
    

    
    @IBOutlet weak var labelMessage: UILabel!
    
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    
    @IBOutlet weak var fname: UITextField!
    
    @IBOutlet weak var lname: UITextField!
    
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
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
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateUser(_ sender: Any) {//getting the username and password
        let parameters: Parameters=[
            "userID":defaultValues.string(forKey: "userid")!,
            "fname":fname.text!,
            "lname":lname.text!,
            "phone":phone.text!,
            "email":email.text!
        ]
        print(parameters)
        
        //making a post request
        Alamofire.request(URL_USER_UPDATE, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                

                //getting the json value from the server
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary

                    //if there is no error
                    if(!(jsonData.value(forKey: "error") as! Bool)){

                        //getting the user from response
                        let user = jsonData.value(forKey: "user") as! NSDictionary

                        //getting user values
                        
                        
                        //deleting previously existing values
                        self.defaultValues.removeObject(forKey: "useremail")
                        self.defaultValues.removeObject(forKey: "userphone")
                        self.defaultValues.removeObject(forKey: "userfname")
                        self.defaultValues.removeObject(forKey: "userlname")
                        
                        //getting new values from php query
                        let userEmail = user.value(forKey: "email") as! String
                        let userPhone = user.value(forKey: "phone") as! String
                        let userFname = user.value(forKey: "fname") as! String
                        let userLname = user.value(forKey: "lname") as! String
                        let userFullname = userFname+" "+userLname
                        
                        //saving new values with key
                        self.defaultValues.set(userEmail, forKey: "useremail")
                        self.defaultValues.set(userPhone, forKey: "userphone")
                        self.defaultValues.set(userFname, forKey: "userfname")
                        self.defaultValues.set(userLname, forKey: "userlname")
                        self.defaultValues.set(userFullname, forKey: "userfullname")

                        //Clear Labels
                        self.fname.text! = ""
                        self.lname.text! = ""
                        self.phone.text! = ""
                        self.email.text! = ""
                        
                        //Message to user
                        self.labelMessage.text = "User Updated Successfully"

                    }else{
                        //error message in case of invalid credential
                        self.labelMessage.text = "Invalid entries"
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
