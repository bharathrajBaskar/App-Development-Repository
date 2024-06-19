//
//  OrderHistoryDetailPageViewController.swift
//  GroceryApp
//
//  Created by Bharath on 18/06/24.
//

import UIKit

class OrderHistoryDetailPageViewController: UIViewController {
    var orderId:String?
    @IBOutlet weak var TableViewOrderItems: UITableView!
    @IBOutlet weak var OrderNo: UILabel!
    var arrayOfOrderItems :[[String:Any]] = []
    var totalPrice = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        var stringToInt = Int(orderId!)
        arrayOfOrderItems = dbObject.selectOrderItems(orderId: stringToInt!)
        print("arrayOf orderItems",arrayOfOrderItems)
        TableViewOrderItems.delegate = self
        TableViewOrderItems.dataSource = self
        totalPrice = dbObject.AggregateTotalFunc(orderId: stringToInt!)
        if let orderNo = stringToInt{
            OrderNo.text = "OrderNo  \(orderNo)"
        }
        
    }
    

    @IBAction func ButtonBackClicked(_ sender: Any) {
        dismiss(animated: false)
    }
    

}


extension OrderHistoryDetailPageViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfOrderItems.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if arrayOfOrderItems.count > indexPath.row{
            let cell = TableViewOrderItems.dequeueReusableCell(withIdentifier: "OrderCell",for: indexPath)
            let productImage = cell.viewWithTag(500) as! UIImageView
            let productName = cell.viewWithTag(501) as! UILabel
            let qunatityTitleLabel = cell.viewWithTag(502) as! UILabel
            let quantity = cell.viewWithTag(503) as! UILabel
            let priceLabel = cell.viewWithTag(504) as! UILabel
            let priceTitle = cell.viewWithTag(505) as! UILabel
            let price = cell.viewWithTag(506) as! UILabel
            let data = arrayOfOrderItems[indexPath.row]
//            productName.text = String(describing: data["productName"])
//            quantity.text = String(describing: data["quantity"])
            if let prname = data["productName"] as? String , let pquantity =  data["quantity"] as? Int,
               let pprice = data["productPrice"] as? Double, let totalPrice = data["totalPrice"]  as? Double
            {
                productName.text = prname
                quantity.text = "\(pquantity)"
                priceLabel.text = "₹\(totalPrice)"
                price.text = "₹\(pprice)"
            }
           // productImage.layer.cornerRadius = productImage.frame.width / 2
           let imagestring = data["imagePath"] as! String
            let imageUrl = URL(string: imagestring)!
            downloadImage(url: imageUrl, imageViewMain: productImage)
            
            
            
            return cell
        }
        else{
            let cell = TableViewOrderItems.dequeueReusableCell(withIdentifier: "InvoiceOrder", for: indexPath)
            let totalin =  cell.viewWithTag(700) as! UILabel
            let totalValueup = cell.viewWithTag(701) as! UILabel
            let gst = cell.viewWithTag(702) as! UILabel
            let gstValue = cell.viewWithTag(703) as! UILabel
            let cupon = cell.viewWithTag(704) as! UILabel
            let cuponValue = cell.viewWithTag(705) as! UILabel
            let deliveryCharges = cell.viewWithTag(706) as! UILabel
            let deliveryChargesValue = cell.viewWithTag(707) as! UILabel
            let borderLineUp = cell.viewWithTag(708) as! UILabel
            let totallabel = cell.viewWithTag(709) as! UILabel
            let totalvaluedown = cell.viewWithTag(710) as! UILabel
            let borderLineDown = cell.viewWithTag(711) as! UILabel
            gstValue.text = "nil"
            cuponValue.text = "nil"
            deliveryChargesValue.text = "0.0"
            borderLineUp.text = "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
            borderLineDown.text = "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
          //  totalvalue.text = totalPrice as? String
            totalValueup.text = String(totalPrice)
            totalvaluedown.text = String(totalPrice)
            return cell
        }
    }
    
    
}


extension OrderHistoryDetailPageViewController{
    func downloadImage(url:URL,imageViewMain:UIImageView){
        
        print("Download Started")
        getData(from: url){
            data,response,error in
            guard let data,error == nil else{return}
            
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download finished")
            DispatchQueue.main.async {
                imageViewMain.image =  UIImage(data: data)
                imageViewMain.contentMode = .scaleAspectFit
            }
            
        }
    }
    
    func getData(from url:URL,completion:@escaping(Data?,URLResponse?,Error?) -> ()){
        URLSession.shared.dataTask(with: url,completionHandler: completion).resume()
    }

}
