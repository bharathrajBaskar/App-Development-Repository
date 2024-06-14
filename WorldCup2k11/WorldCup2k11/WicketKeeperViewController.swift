//
//  WicketKeeperViewController.swift
//  WorldCup2k11
//
//  Created by Bharath on 29/04/24.
//

import UIKit

class WicketKeeperViewController: UIViewController {
    var arrayOfDictionary :[[String:String]] = []
    @IBOutlet weak var WkDescriptionLabel: UILabel!
    @IBOutlet weak var WkImageview: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
print(arrayOfDictionary)
        NameLabel.font = UIFont.boldSystemFont(ofSize: 20)

//        if let firstPlayer = arrayOfDictionary.first {
//            if let name = firstPlayer["Name"], let imageStr = firstPlayer["Image"], let description = firstPlayer["Description"] {
//                NameLabel.text = name
//    
//                let image :UIImage = UIImage(named: imageStr)!
//                WkImageview.image = image
//                WkImageview.contentMode = .scaleAspectFit
//                WkDescriptionLabel.text = description
//            }
//            
//        }
    }

  
    
//    func wicketKeeperDhoni(){
//        let imageView = UIImage(named: "MSDhoni.jpg")
//        WkImageview.image = imageView
//        WkDescriptionLabel.text = "Dhoni made his international debut in 2004. His talent with the bat came to the fore in an innings of 148 runs against Pakistan in his fifth international match. Within a year he joined the India Test team, where he quickly established himself with a century (100 or more runs in a single innings) against Pakistan "
//        self.NameLabel.text = "Mahindra Singh Dhoni "
//
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
