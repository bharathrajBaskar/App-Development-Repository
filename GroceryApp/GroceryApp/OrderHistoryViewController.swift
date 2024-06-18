//
//  OrderHistoryViewController.swift
//  GroceryApp
//
//  Created by Bharath on 14/06/24.
//

import UIKit

class OrderHistoryViewController: UIViewController {
    var arrayOfOrders:[[String:Any]] = []
    @IBOutlet weak var OrderHistoryTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        OrderHistoryTableView.delegate = self
        OrderHistoryTableView.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        arrayOfOrders = dbObject.fetchOrders()
        print("array of orders",arrayOfOrders)
        OrderHistoryTableView.reloadData()
    }

    @IBAction func ButtonBackClicked(_ sender: Any) {
        
        
    }
   

}

extension OrderHistoryViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = OrderHistoryTableView.dequeueReusableCell(withIdentifier: "orderhistorycell", for: indexPath)
        let orderLabel = cell.viewWithTag(400) as! UILabel
        let dateLabel = cell.viewWithTag(401) as! UILabel
        let rupeeLabel = cell.viewWithTag(402) as! UILabel
        let noOfItem = cell.viewWithTag(403) as! UILabel
        let order = arrayOfOrders[indexPath.row]
//        orderLabel.text = order["id"]
//        dateLabel.text = order["date_of_order"]
//        rupeeLabel.text = order["total_price"]
//        noOfItem.text = order["no_of_products"]
        
        cell.selectionStyle = .none
        orderLabel.text =  "Order \(String(describing: order["id"] ?? ""))"
                dateLabel.text = String(describing: order["date_of_order"] ?? "")
                rupeeLabel.text = "₹ \(String(describing: order["total_price"] ?? ""))"
                noOfItem.text = "\(String(describing: order["no_of_products"] ?? "")) items"
        return cell
        
        

        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrderHistoryDetailPageViewController") as! OrderHistoryDetailPageViewController
        let order = arrayOfOrders[indexPath.row]
        vc.orderId = String(describing: order["id"] ?? "")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
}
