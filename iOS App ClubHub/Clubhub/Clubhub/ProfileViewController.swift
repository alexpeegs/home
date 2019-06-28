
import UIKit

class ProfileViewController: UIViewController {
    

    
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    
    //label again don't copy instead connect
    
    
    @IBOutlet weak var labelUserName: UILabel!
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelPhone: UILabel!
    
    @IBOutlet weak var labelEmail: UILabel!
    
    //button
    //@IBAction func buttonLogout(_ sender: UIButton) {
    
    
    @IBAction func buttonLogout(_ sender: Any) {
        
        
        //removing values from default
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        
        //switching to login screen
        //let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        //self.navigationController?.pushViewController(loginViewController, animated: true)
        //self.dismiss(animated: false, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
        
        
    }
    
    override func viewDidLoad() {
        
        //Title
        self.title = "ClubHub"
        
        //Title Font, color, and position
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white, NSAttributedStringKey.font: UIFont(name: "Arial", size: 40.0)!];
        self.navigationController!.navigationBar.setTitleVerticalPositionAdjustment(8, for: UIBarMetrics.default)
        
        //Menu Button
        btnMenuButton.target = revealViewController()
        btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        super.viewDidLoad()
        
        //hiding back button
        //let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        //navigationItem.leftBarButtonItem = backButton
        
        
        //getting user data from defaults
        let defaultValues = UserDefaults.standard
        if let username = defaultValues.string(forKey: "username"){
            //setting the name to label
            labelUserName.text = username
        }else{
            //send back to login view controller
        }
        if let email = defaultValues.string(forKey: "useremail"){
            //setting the name to label
            labelEmail.text = email
        }else{
            //send back to login view controller
        }
        if let phone = defaultValues.string(forKey: "userphone"){
            //setting the name to label
            labelPhone.text = phone
        }else{
            //send back to login view controller
        }
        if let name = defaultValues.string(forKey: "userfullname"){
            //setting the name to label
            labelName.text = name
        }else{
            //send back to login view controller
        }
        //if let lname = defaultValues.string(forKey: "userlname"){
        //setting the name to label
        //labelName.text = lname
        //defaultValues.string(forKey: "userlname"
        //}else{
        //send back to login view controller
        //}
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
