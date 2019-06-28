//
//  ViewController.swift
//  Clubhub
//
//  Created by Nicholas Baldini on 1/11/18.
//  Copyright © 2018 Nicholas Baldini. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire


class ViewController: UIViewController {
    
    //override func viewDidAppear(_ animated: Bool) {
        // 1
        //let nav = self.navigationController?.navigationBar
        
        // 2
        //nav?.barStyle = UIBarStyle.black
        //nav?.tintColor = UIColor.yellow
        
        // 3
        //let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        //imageView.contentMode = .scaleAspectFit
        
        // 4
        //let image = UIImage(named: "Apple_Swift_Logo")
       // imageView.image = image
        
        // 5
        //navigationItem.titleView = imageView
   // }
    
    
    
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    
    
    //The login script url make sure to write the ip instead of localhost
    //you can get the ip using ifconfig command in terminal
    let URL_USER_LOGIN = "http://cgi.soic.indiana.edu/~team53/v1/login.php"
    
    //the defaultvalues to store user data
    let defaultValues = UserDefaults.standard
    
    //the connected views
    //don't copy instead connect the views using assistant editor
    

    
    @IBOutlet weak var labelMessage: UILabel!
    
    @IBOutlet weak var textFieldUserName: UITextField!

    @IBOutlet weak var textFieldPassword: UITextField!
    
    //the button action function
   
    
    @IBAction func buttonLogin(_ sender: Any) {
        //getting the username and password
        let parameters: Parameters=[
            "username":textFieldUserName.text!,
            "password":textFieldPassword.text!
        ]
        
        //making a post request
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseJSON
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
                        let userId = user.value(forKey: "userID") as! Int
                        let userName = user.value(forKey: "username") as! String
                        let userEmail = user.value(forKey: "email") as! String
                        let userPhone = user.value(forKey: "phone") as! String
                        let userFname = user.value(forKey: "fname") as! String
                        let userLname = user.value(forKey: "lname") as! String
                        let userFullname = userFname+" "+userLname
                        
                        
                        //saving user values to defaults
                        self.defaultValues.set(userId, forKey: "userid")
                        self.defaultValues.set(userName, forKey: "username")
                        self.defaultValues.set(userEmail, forKey: "useremail")
                        self.defaultValues.set(userPhone, forKey: "userphone")
                        self.defaultValues.set(userFname, forKey: "userfname")
                        self.defaultValues.set(userLname, forKey: "userlname")
                        self.defaultValues.set(userFullname, forKey: "userfullname")
                        
                        //Clear Labels
                        self.textFieldUserName.text! = ""
                        self.textFieldPassword.text! = ""
                        
                        
                        //switching the screen
                        let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewcontroller") as! ProfileViewController
                        self.navigationController?.pushViewController(profileViewController, animated: true)
                        
                        self.dismiss(animated: false, completion: nil)
                    }else{
                        //error message in case of invalid credential
                        self.labelMessage.text = "Invalid username or password"
                    }
                }
        }
    }
    
    
    override func viewDidLoad() {
        self.title = "ClubHub"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white, NSAttributedStringKey.font: UIFont(name: "Arial", size: 40.0)!];
        self.navigationController!.navigationBar.setTitleVerticalPositionAdjustment(8, for: UIBarMetrics.default)

        
        btnMenuButton.target = revealViewController()
        btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        super.viewDidLoad()
        //hiding the navigation button
        //let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        //navigationItem.leftBarButtonItem = backButton
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //if user is already logged in switching to profile screen
        if defaultValues.string(forKey: "username") != nil{
            let ProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewcontroller") as! ProfileViewController
            self.navigationController?.pushViewController(ProfileViewController, animated: true)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}




