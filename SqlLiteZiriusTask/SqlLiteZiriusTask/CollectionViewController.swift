//
//  CollectionViewController.swift
//  SqlLiteZiriusTask
//
//  Created by Bharath on 24/05/24.
//

//import UIKit
//
//class CollectionViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
//    var userArrayOfDict:[[String:String]] = []
//
//    @IBOutlet weak var CollectionViewMain: UICollectionView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        CollectionViewMain.dataSource = self
//        CollectionViewMain.delegate = self
//        dbTable.fetchUserAndStoreitinArrayOfDict()
//
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//     return globalUserArrayOfDictionary.count+1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = CollectionViewMain.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath)
//        let imageProfile = cell.viewWithTag(100) as! UIImageView
//        let labelName = cell.viewWithTag(101) as! UILabel
//        print("GLobal arr , indexpath ",globalUserArrayOfDictionary,indexPath)
//        if globalUserArrayOfDictionary.count == indexPath.item{
//            print("yes")
//           // let cell = CollectionViewMain.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath)
//            imageProfile.image = UIImage(named: "newUser")
//            imageProfile.contentMode = .scaleAspectFit
//            labelName.text = ""
//
//        }
//        else{
//            print("no")
//            let user = globalUserArrayOfDictionary[indexPath.item]
//                    if let name = user["name"] {
//                        labelName.text = name
//                    }
//            if let imagePathrender = user["image"], let image = UIImage(contentsOfFile: imagePathrender){
//                imageProfile.image = image
//                imageProfile.contentMode = .scaleAspectFit
//            }
//        }
//
//
//        return cell
//
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if globalUserArrayOfDictionary.count == indexPath.item{
//            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddUserSqlViewController") as! AddUserSqlViewController
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//        else{
//
//            let arr = globalUserArrayOfDictionary[indexPath.item]
//            print(arr["image"])
//        }
//    }
//
//}

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var CollectionViewMain: UICollectionView!
    
    var userArrayOfDictionary: [[String: String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CollectionViewMain.dataSource = self
        CollectionViewMain.delegate = self
        fetchUserData()
        print("userArrayOfDictionary",userArrayOfDictionary)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: NSNotification.Name(rawValue: kNotifyForFetch), object: nil)
    }
    @objc func fetchData(){
        userArrayOfDictionary = dbTable.fetchUserAndReturnArray()
        CollectionViewMain.reloadData()
    }
    func fetchUserData() {
        userArrayOfDictionary = dbTable.fetchUserAndReturnArray()
        CollectionViewMain.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userArrayOfDictionary.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionViewMain.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath)
        let imageProfile = cell.viewWithTag(100) as! UIImageView
        let labelName = cell.viewWithTag(101) as! UILabel
        
        if userArrayOfDictionary.count == indexPath.item {
            imageProfile.image = UIImage(named: "newUser")
            imageProfile.contentMode = .scaleAspectFit
            labelName.text = ""
        } else {
            let user = userArrayOfDictionary[indexPath.item]
            labelName.text = user["name"]
            print(user["image"])

            
            if let imgPath = user["image"]  {
                if let urlImage = URL(string: imgPath)?.lastPathComponent {
                    let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
                    let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
                    let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
                    if let dirPath          = paths.first
                    {
                        let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(urlImage)
                        let image    = UIImage(contentsOfFile: imageURL.path)
                       
                        print(imgPath)
                        print(urlImage)
                        print(dirPath)
                        print(imageURL)
                        print(image!)
                        imageProfile.image = image
                    }
                }

            }
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 98, height: 128)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if userArrayOfDictionary.count == indexPath.item {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddUserSqlViewController") as! AddUserSqlViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let user = userArrayOfDictionary[indexPath.item]
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditPageViewController") as! EditPageViewController
            vc.EditPageDict = user
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
     func load(fileName: String) -> UIImage? {
        let fileURL = URL(fileURLWithPath: fileName)
     
        var imageName =    fileURL.lastPathComponent
    
        
         guard FileManager.default.fileExists(atPath: fileURL.path)
         else{
            print("file path not found",fileURL.path)
            return nil
             
         }
        print(fileURL)
        do {
            let imageData = try Data(contentsOf:fileURL )
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        
        return nil
    }


}

