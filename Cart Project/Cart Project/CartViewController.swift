//
//  CartViewController.swift
//  Cart Project
//
//  Created by Bharath on 21/05/24.

import UIKit
var globalArr :[EmployeeJson] = []

class CartViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    var count = 0

    @IBOutlet weak var CartTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        CartTableView.dataSource = self
        CartTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalArr.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = CartTableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        var arr = globalArr[indexPath.row]
      
        let labelName = cell.viewWithTag(200) as! UILabel
        let labelCount = cell.viewWithTag(201) as! UILabel
        let labelCountiteration = cell.viewWithTag(202) as! UILabel
        
//        let itemcount = arr.count
        labelName.text = arr.name
       // labelCountiteration.text = String(count)
      //  labelCountiteration.text = String(arr.count)
        // labelCountiteration.text = arr.count
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    func countOccurrences(of item : EmployeeJson) -> Int{
        var count = 0   
        for employee in globalArr{
            if employee.id == item.id{
                count+=1
            }
                
        }
        return count
    }
    
}


