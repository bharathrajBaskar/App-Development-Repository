//
//  FullSizeImageViewController.swift
//  WorldCup2k11
//
//  Created by Bharath on 03/05/24.
//

import UIKit

class FullSizeImageViewController: UIViewController {
    var arrayOfDictioanry1:[[String:String]] = []
    @IBOutlet weak var imgFull: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(arrayOfDictioanry1)
        if let firstOne = arrayOfDictioanry1.first{
            if let image = firstOne["Image"]
            {
                let img :UIImage = UIImage(named: image)!
                imgFull.image = img
                imgFull.contentMode = .scaleAspectFit
            }
        }
        
    }
    


}
