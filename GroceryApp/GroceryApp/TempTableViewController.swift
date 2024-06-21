//
//  TempTableViewController.swift
//  GroceryApp
//
//  Created by Bharath on 20/06/24.
//

import UIKit

class TempTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

//var arrayOfList = [ProductModel]()
    
    
    private let cache = NSCache<NSNumber,UIImage>()
    private let utilityQueue = DispatchQueue.global(qos:.utility)
    
    
    @IBOutlet weak var tableViewList: UITableView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  arrayOfDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSurf", for: indexPath)
        
        let img = cell.viewWithTag(1001) as! UIImageView
        
//        let dict = arrayOfDatas[indexPath.row]
//        img.image = dict.image?.first
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let imgView = cell.viewWithTag(1001) as! UIImageView
        let dict = arrayOfDatas[indexPath.row]
        
        if let cacheImage = cache.object(forKey: NSNumber(value: indexPath.row)) {
            imgView.image = cacheImage
        }
        else {
          //  imgView.image = self.downloadImage(from: URL(string: dict.image!.first!)!, int: NSNumber(value: indexPath.row))
            
        }
        
        
        
        
        
        
    }
    
    @IBAction func buttonBackClicked(_ sender: Any) {
        self.dismiss(animated: false)
    }
 
    
//    
//    func findAInName(name: String) -> Bool {
//        var dumyname = name
//        if dumyname.contains("a") {
//            return true
//        }
//        else {
//           return false
//        }
//    }
//    
//    
//    func findAInNameClosure(name: String, completion : @escaping(Bool) -> Void) {
//        var dumyname = name
//        if dumyname.contains("a") {
//             completion(true)
//        }
//        completion(false)
//    }
    
}




























extension TempTableViewController {
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }


//    
//    func downloadImage(from url: URL,int:NSNumber) -> UIImage? {
//        print("Download Started")
//        var imgeView = UIImageView()
//        
//        getData(from: url) { data, response, error in
//            guard let data = data, error == nil else { return }
//            print(response?.suggestedFilename ?? url.lastPathComponent)
//            print("Download Finished")
//           // cache.setObject(data, forKey: int)
//            DispatchQueue.main.async() { [weak self] in
//                imgeView.image = UIImage(data: data)
//                self!.cache.setObject(imgeView.image!, forKey: int)
//                imgeView.contentMode = .scaleAspectFit
//                return  UIImage(data: data)
//            }
//            
//        }
//        return nil
//    }
}
