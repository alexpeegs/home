//
//  DiscoverClubsViewController.swift
//  Clubhub
//
//  Created by Lebbeus Woods on 4/10/18.
//  Copyright © 2018 Nicholas Baldini. All rights reserved.
//

import UIKit
import Alamofire

class DiscoverClubsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(allTagsArray.count)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")

        cell.textLabel?.text = allTagsArray[indexPath.row]["tag"] as? String

        return(cell)
    }
    
    
    
    let URL_TAGS = "http://cgi.soic.indiana.edu/~team53/v1/getclubtags.php"
    
    
    //Create menu button
   @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    
    //Link TableView
    @IBOutlet weak var tableView: UITableView!
    
    var allTagsArray = [AnyObject]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        Alamofire.request(URL_TAGS, method: .get).responseJSON{ response in
            let result = response.result
            if let dict = result.value as? Dictionary<String,AnyObject>{
                if let innerDict = dict["tags"]{
                    self.allTagsArray = innerDict as! [AnyObject]
                    self.tableView.reloadData()
                }
            }
            print(self.allTagsArray)
        }
        
        //Title
        self.title = "ClubHub"
        
        //Title Font, color, and position
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white, NSAttributedStringKey.font: UIFont(name: "Arial", size: 40.0)!];
        self.navigationController!.navigationBar.setTitleVerticalPositionAdjustment(8, for: UIBarMetrics.default)
        
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
