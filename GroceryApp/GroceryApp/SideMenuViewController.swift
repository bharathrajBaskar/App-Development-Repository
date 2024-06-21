//
//  SideMenuViewController.swift
//  GroceryApp
//
//  Created by Bharath on 21/06/24.
//

import UIKit

protocol SideMenuViewControllerDelegate {
    func selectedCell(_ row: Int)
}

let kNotificationForSideMenuExpanded = "keyforkNotificationForSideMenuExpanded"



class SideMenuViewController: UIViewController {

    @IBOutlet weak var TableViewSide: UITableView!
    @IBOutlet weak var ButtonBack: UIButton!
    @IBOutlet weak var LabelProfileName: UILabel!
    @IBOutlet weak var ImageViewProfilePicture: UIImageView!
    
    
//    var object : SideMenuViewControllerDele
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewSide.delegate = self
        TableViewSide.dataSource = self
        self.ImageViewProfilePicture.layer.cornerRadius = self.ImageViewProfilePicture.frame.size.height / 2
        self.ImageViewProfilePicture.clipsToBounds = true
        ImageViewProfilePicture.image = UIImage(named: "Msd.jpg")
        ImageViewProfilePicture.contentMode = .scaleAspectFill
        self.ButtonBack.layer.cornerRadius = self.ButtonBack.frame.size.height / 2
        self.ButtonBack.clipsToBounds = true
        self.ButtonBack.layer.borderColor = UIColor.black.cgColor
        self.ButtonBack.layer.borderWidth = 1.0
        
        LabelProfileName.text = "Santhosh"
        
        
    }
    

    @IBAction func ButtonBack(_ sender: Any) {
//        NotificationCenter.default.post(name: NSNotification.Name(kNotificationForSideMenuExpanded), object: nil)
    }
    
}


extension SideMenuViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  TableViewSide.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath)
        
        let label = cell.viewWithTag(10) as! UILabel
        cell.selectionStyle = .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        dismiss(animated: false)
//        NotificationCenter.default.post(name: NSNotification.Name(kNotificationForSideMenuExpanded), object: nil)
        
        delegateForSlide!.selectedCell(indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}
