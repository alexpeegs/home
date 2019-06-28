//
//  MapViewController.swift
//  Clubhub
//
//  Created by Alex Pegram on 2/27/18.
//  Copyright © 2018 Nicholas Baldini. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire

class MapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let URL_ALL_CLUBS = "http://cgi.soic.indiana.edu/~team53/v1/allclubs.php"
    
    //the defaultvalues to store user data
    let defaultValues = UserDefaults.standard
    
    //Create Array to load into TableView
    //var selectedArray:Array = [String](arrayLiteral: "Home", "Radio Club", "Video Game Club", "Math Club", "Soccer Club")
 
    @IBOutlet weak var tableView: UITableView!
    
    var maplocationsArray = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //making a post request
        Alamofire.request(URL_ALL_CLUBS, method: .get).responseJSON { response in
                //printing response
                //print(response)

                //getting the json value from the server
        let result = response.result
            if let dict = result.value as? Dictionary<String,AnyObject>{
                if let innerDict = dict["clubs"]{
                    self.maplocationsArray = innerDict as! [AnyObject]
                    self.tableView.reloadData()
                    }
                }
            print(self.maplocationsArray)
        }
        
        
        //Title
        self.title = "ClubHub"
        
        //Title Font, color, and position
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white, NSAttributedStringKey.font: UIFont(name: "Arial", size: 40.0)!];
        self.navigationController!.navigationBar.setTitleVerticalPositionAdjustment(8, for: UIBarMetrics.default)
        
        //Menu Button
        btnMenuButton.target = revealViewController()
        btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        
        //Create a default view of bloomington
        
        let camera = GMSCameraPosition.camera(withLatitude: 39.1653, longitude: -86.5264, zoom: 15.0)

//      let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.MapDisplay.camera = camera;
    }
    
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Get the count of the Array
        return(maplocationsArray.count)
    }
    
    
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //INTIALIZE CELL
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        //let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.mapLbl.text = maplocationsArray[indexPath.row]["clubName"] as? String
        
        //cell.textLabel?.text = maplocationsArray[indexPath.row]["clubName"] as? String
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        
        
        return(cell)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //CREATE CELL
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as?
            //CustomTableViewCell
        //Set Cell TextLabel to the chosen value from the array
        //let title = maplocationsArray[indexPath.row]["clubName"]
        //cell.textLabel?.text = title as? String
        //cell.textLabel?.text.
        //The chosen label displays then displays its location on the map
        if cell.mapLbl.text! == cell.mapLbl.text
        {
            print(maplocationsArray[indexPath.row]["clubCoordOne"] as! NSString)
            let latitude = Double(maplocationsArray[indexPath.row]["clubCoordOne"] as! String)!
            let longitude = Double(maplocationsArray[indexPath.row]["clubCoordTwo"] as! String)!
            let snippet = maplocationsArray[indexPath.row]["snippet"]
            let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude), zoom: 13.0)
            
            //      let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            self.MapDisplay.camera = camera;
            // Creates a marker in the center of the map.
            let position = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
            let marker = GMSMarker(position: position)
            marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
            marker.title = maplocationsArray[indexPath.row]["clubName"] as? String
            marker.snippet = snippet as? String
            marker.map = MapDisplay
            
        }
        
        //Commented out old hardcoded info for table cells
//
//        if cell.textLabel?.text! == "Radio Club"
//        {
//            let camera = GMSCameraPosition.camera(withLatitude: 39.1684, longitude: -86.5179, zoom: 14.0)
//            self.MapDisplay.camera = camera;
//            let position = CLLocationCoordinate2D(latitude: 39.1684, longitude: -86.5179)
//            let marker = GMSMarker(position: position)
//            marker.position = CLLocationCoordinate2D(latitude: 39.1684, longitude: -86.5179)
//            marker.title = "Radio Club"
//            marker.snippet = "We Love The Radio"
//            marker.map = MapDisplay
//        }
//        if cell.textLabel?.text! == "Math Club"
//        {
//            let camera = GMSCameraPosition.camera(withLatitude: 39.1647, longitude: -86.5234, zoom: 14.0)
//            self.MapDisplay.camera = camera;
//            let position = CLLocationCoordinate2D(latitude: 39.1647, longitude: -86.5234)
//            let marker = GMSMarker(position: position)
//            marker.position = CLLocationCoordinate2D(latitude: 39.1647, longitude: -86.5234)
//            marker.title = "Math Club"
//            marker.snippet = "We Love Math"
//            marker.map = MapDisplay
//        }
//        if cell.textLabel?.text! == "Video Game Club"
//        {
//            let camera = GMSCameraPosition.camera(withLatitude: 39.1721, longitude: -86.5229, zoom: 14.0)
//            self.MapDisplay.camera = camera;
//            let position = CLLocationCoordinate2D(latitude: 39.1721, longitude: -86.5229)
//            let marker = GMSMarker(position: position)
//            marker.position = CLLocationCoordinate2D(latitude: 39.1721, longitude: -86.5229)
//            marker.title = "Video Club"
//            marker.snippet = "We Love GAMES"
//            marker.map = MapDisplay
//        }
//        if cell.textLabel?.text! == "Soccer Club"
//        {
//            let camera = GMSCameraPosition.camera(withLatitude: 39.1809, longitude: -86.5222, zoom: 14.0)
//            self.MapDisplay.camera = camera;
//            let position = CLLocationCoordinate2D(latitude: 39.1809, longitude: -86.5222)
//            let marker = GMSMarker(position: position)
//            marker.position = CLLocationCoordinate2D(latitude: 39.1809, longitude: -86.5222)
//            marker.title = "Soccer Club"
//            marker.snippet = "Welcome to All Levels!"
//            marker.map = MapDisplay
//        }
    }
    
//    //Create Color for Table Cells BACKGROUND
//    func colorForIndex(index: Int) -> UIColor {
//        let itemCount = maplocationsArray.count - 1
//        let color = (CGFloat(index) / CGFloat(itemCount)) * 0.6
//        return UIColor(red: 0.0, green: color, blue: 1.0, alpha: 1.0)
//    }
//    
//    //Create Color for Table Cell TEXT
//
//    func colorForText(index: Int) -> UIColor {
//        let itemCount = maplocationsArray.count - 1
//        let color = (CGFloat(index) / CGFloat(itemCount)) * 0.6
//        return UIColor(red: 1.0, green: color, blue: 3.0, alpha: 1.0)
//    }
//    //Set Color for Table Cell TEXT/BACKGROUND
//
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
//                   forRowAt indexPath: IndexPath) {
//        cell.backgroundColor = colorForIndex(index: indexPath.row)
//        cell.textLabel?.textColor = colorForText(index: indexPath.row)
//    }
    //Create MapDisplay Variable
    
    @IBOutlet weak var MapDisplay: GMSMapView!
    
    //Create MenuButton
    
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!;
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

//    override func loadView() {
//        // Create a GMSCameraPosition that tells the map to display the
//
//    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
