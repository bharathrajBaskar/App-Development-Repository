//
//  MultiplePicturesCollectionViewController.swift
//  TableExample
//
//  Created by Bharath on 10/05/24.
//

import UIKit

class MultiplePicturesCollectionViewController: UIViewController ,UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{

    @IBOutlet weak var collect: UICollectionView!
 
    
    var ar: [String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       view.viewWithTag(999)as! UILabel
       view.viewWithTag(1001)as! UILabel
//        var a = ["Ajith.jpg","Kamal.jpg"]
//        i?.append(a)
        
        collect.dataSource = self
        collect.delegate = self
        
    
        
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ar.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collect.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath)
        
        let imgView = cell.viewWithTag(1000) as! UIImageView
       
    
        
        if let image = ar["Image"] , let assignImg = UIImage(named: image)
        {
            imgView.image = assignImg
            imgView.contentMode = .scaleAspectFit
            
        }
            
        
        return cell
                
    }

}
