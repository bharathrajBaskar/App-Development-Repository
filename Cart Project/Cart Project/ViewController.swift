//
//  ViewController.swift
//  Cart Project
//
//  Created by Bharath on 21/05/24.

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var ButtonCart: UIButton!
    
    var arrayOfDictionaryApi : [[String:String]] =  []
    
    var detailModel = [EmployeeJson]()
    @IBOutlet weak var TableViewMain: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewMain.dataSource = self
        TableViewMain.delegate = self
        apiCall(link: "https://retoolapi.dev/fZq19k/data")
        ButtonCart.layer.cornerRadius = ButtonCart.frame.width / 2
        ButtonCart.layer.masksToBounds = true
    
    }
    
    func apiCall(link :String)
    {
        let url = URL(string: link)!
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlReq){
            data,response,error in
            if let output1 = data{
                print("Output :" ,output1)
                do
                {
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode([EmployeeJson].self, from: output1)
                    print("responseModel",responseModel)
                    self.detailModel = responseModel
                    DispatchQueue.main.async {
                        self.reloadDataFunc()
                    }
                }
                catch(let err){
                    print("error",err)
                }
            }
        }.resume()
        
    }
    func reloadDataFunc(){
        self.TableViewMain.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewMain.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        let labelName = cell.viewWithTag(100) as! UILabel
        let labelDesignation = cell.viewWithTag(101) as!  UILabel
        
        let employee = detailModel[indexPath.row]
           labelName.text = employee.name
        labelDesignation.text = employee.designation
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedItem = detailModel[indexPath.row]
            
//            if let selectedID = selectedItem.id {
//                let isIDPresent = globalArr.contains { $0.id == selectedID }
//
//                if !isIDPresent {
//                    globalArr.append(selectedItem)
//                    print(selectedItem)
//                } else {
//                    print("Item with ID \(selectedID) is already present in the global array.")
//                }
//            } else {
//                print("Selected item does not have an ID.")
//            }
//       print("global array",globalArr)
        
//        globalArr.append(selectedItem)
        
//        if globalArr.count > 0 {
//            if let selectedID = selectedItem.id {
//                let isIDPresent = globalArr.contains { $0.id == selectedID }
//                print(isIDPresent)
//                if !isIDPresent {
//                    globalArr.append(selectedItem)
//                    print(selectedItem)
//                } else {
//
//                    if var count = selectedItem.count {
//                        count += 1
//                        selectedItem.count = count
//                    }
//
//                }
//            }
//        }
//        else {
//            globalArr.append(selectedItem)
//        }
        if let selectedID = selectedItem.id {
             if let index = globalArr.firstIndex(where: { $0.id == selectedID }) {
                 
                 globalArr[index].count = (globalArr[index].count ?? 1) + 1
             } else {
                 
                 var itemWithCount = selectedItem
                 itemWithCount.count = 1
                 globalArr.append(itemWithCount)
             }
         }
        
        print("Global Array",globalArr)
    }
    
    
    @IBAction func ButtonCart(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

