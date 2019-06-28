//
//  CreateEventViewController.swift
//  Clubhub
//
//  Created by Alex Pegram on 4/18/18.
//  Copyright © 2018 Nicholas Baldini. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class CreateEventViewController: UIViewController {
    
    let URL_CREATE_EVENT = "http://cgi.soic.indiana.edu/~team53/v1/createevent.php"
    
    let defaultValues = UserDefaults.standard

    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    
    @IBOutlet weak var eventName: UITextField!
    
    @IBOutlet weak var eventDate: UIDatePicker!
    
    @IBOutlet weak var eventAddress: UITextField!
    
    @IBOutlet weak var eventDesc: UITextView!
    
    var date = ""
    var time = ""
    
    @IBAction func datePickerAction(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.string(from: eventDate.date)
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:SS"
        let strTime = timeFormatter.string(from: eventDate.date)
        self.date = strDate
        self.time = strTime
    }
    
    
    
    
    
    
    @IBAction func createEvent(_ sender: Any) {
        
        let geocoder = CLGeocoder()
        let address = eventAddress.text!
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error ?? "")
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                print("Lat: \(coordinates.latitude) -- Long: \(coordinates.longitude)")
        
                let parameters: Parameters=[
                    "userid":self.defaultValues.string(forKey: "userid")!,
                    "clubid":self.defaultValues.string(forKey: "clubid")!,
                    "eventName":self.eventName.text!,
                    "eventCoordOne":coordinates.latitude,
                    "eventCoordTwo":coordinates.longitude,
                    "eventDesc":self.eventDesc.text!,
                    "eventDate":self.date as String,
                    "eventTime":self.time as String
                    ]
                Alamofire.request(self.URL_CREATE_EVENT, method: .post, parameters: parameters).responseJSON {
                response in
                print(response)

                    if let result = response.result.value {
                        let jsonData = result as! NSDictionary
                        print(jsonData.value(forKey: "message") as! String? as Any)
                        let message = jsonData.value(forKey: "message") as! String?
                        if message == "Event created successfully"{
                            //Clear Labels
                            self.eventName.text! = ""
                            self.eventAddress.text! = ""
                            self.eventDesc.text! = ""
                            
                            let ViewEventsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewEventsViewController") as! ViewEventsViewController
                            self.navigationController?.pushViewController(ViewEventsViewController, animated: true)
                            
                        }
                    }
                }
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventDesc.placeholder = "Please Enter Event Details"
        
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
