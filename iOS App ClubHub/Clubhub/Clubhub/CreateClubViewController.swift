//
//  CreateClubViewController.swift
//  Clubhub
//
//  Created by Alex Pegram on 4/10/18.
//  Copyright © 2018 Nicholas Baldini. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class CreateClubViewController: UIViewController {
    
    let URL_CREATE_CLUB = "http://cgi.soic.indiana.edu/~team53/v1/createclub.php"
    
    //Text Entries
    @IBOutlet weak var textFieldClubName: UITextField!
    @IBOutlet weak var textFieldClubEmail: UITextField!
    @IBOutlet weak var textFieldClubPass: UITextField!
    @IBOutlet weak var textFieldClubAbout: UITextField!
    @IBOutlet weak var textFieldClubLatitude: UITextField!
    @IBOutlet weak var textFieldClubLocation: UITextField!
    @IBOutlet weak var labelMessage: UILabel!
    //Menu Button
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    
    
    @IBAction func CreateButton(_ sender: Any) {
        
        let geocoder = CLGeocoder()
        let address = textFieldClubLatitude.text!
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error ?? "")
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                print("Lat: \(coordinates.latitude) -- Long: \(coordinates.longitude)")
                
                let parameters: Parameters=[
                    "clubname":self.textFieldClubName.text!,
                    "clubemail":self.textFieldClubEmail.text!,
                    "clubpass":self.textFieldClubPass.text!,
                    "clubabout":self.textFieldClubAbout.text!,
                    "clubaddress":self.textFieldClubLatitude.text!,
                    "clublat":coordinates.latitude,
                    "clublong":coordinates.longitude,
                    "clubloc":self.textFieldClubLocation.text!]
                
                Alamofire.request(self.URL_CREATE_CLUB, method: .post, parameters: parameters).responseJSON {
                    response in
                    print(response)
                    
                    if let result = response.result.value {
                        let jsonData = result as! NSDictionary
                        self.labelMessage.text = jsonData.value(forKey: "message") as! String?
                        if jsonData.value(forKey: "message") as! String? == "Club created successfully" {
                            self.textFieldClubLocation.text! = ""
                            self.textFieldClubLatitude.text! = ""
                            self.textFieldClubAbout.text! = ""
                            self.textFieldClubPass.text! = ""
                            self.textFieldClubEmail.text! = ""
                            self.textFieldClubName.text! = ""
                        }else {
                            self.labelMessage.text = "Invalid Entries"
                        }
                    }else {
                        self.labelMessage.text = "Invalid Entries"
                    }
                }

            }else {
                self.labelMessage.text = "Invalid Entries"
            }
        })
        
        
        
        
        
        
        
        
        
    }
    
    
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
