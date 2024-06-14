//
//  ViewController.swift
//  Crudtask
//
//  Created by Bharath on 13/05/24.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate ,UITableViewDataSource {
    var uniqueDesignations = [String]()
    
    var detailModal = [JsonEmployee]()
    var arrayOfDestination :[[String:String]] = []
   // var det : [JsonEmployee]!
    var arrayofDict :[[ String:String]] = []
    @IBOutlet weak var TableViewMain: UITableView!
    
    @IBOutlet weak var ButtonAdd: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableViewMain.delegate = self
        TableViewMain.dataSource = self
        ButtonAdd.layer.cornerRadius = 	ButtonAdd.frame.width / 2
        ButtonAdd.layer.masksToBounds = true
        var obj1 = sqlite()
        apiCall(link: "https://retoolapi.dev/fZq19k/data")
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeTheColor), name: NSNotification.Name(rawValue: "barath"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(handleObjectSentNotification), name: NSNotification.Name("ObjectSentNotification"), object: nil)


    }
   
      
    

    override func viewWillAppear(_ animated: Bool) {
        if let array = UserDefaults.standard.object(forKey: "myList") as? [[String:String]] {
            if array.count > 0 {
                self.arrayofDict = array
                self.TableViewMain.reloadData()
            }
        }
    }
    
    
    @objc func handleObjectSentNotification(_ notification: Notification) {
      
        if let objectReceived = notification.object as? [String: String] {
          
            let name = objectReceived["name"]
            let designation = objectReceived["designation"]
            
            print("Received Object - Name: \(name ?? ""), Designation: \(designation ?? "")")
        }
    }
    
    @objc func changeTheColor() {
        self.TableViewMain.backgroundColor = .red
    }
    
    
    func apiCall(link : String){
        print("1")
        let url1 = URL(string: link)!
        var urlRequest = URLRequest(url: url1)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest){
            data,response,error in
                if let output = data{
                    print("output",output)
                    print("2")
                    do{
                        let jsonDecoder = JSONDecoder()
                        print("1")
                        let responseModel = try  jsonDecoder.decode([JsonEmployee].self, from: output)
                        print("3")
                        print("Response model ",responseModel)
                        self.detailModal = responseModel
//                        DispatchQueue.main.async {
//                        self.loadingVlauesInTgable()
//                        }

                        self.loadingVlauesInTgable()
                
                        
                     //   self.det = responseModel
                        //self.arrayofDict = responseModel
                              
                    }
                    catch (let excep){
                        print(excep)
                    }
                }
            else
            {
                print("no")
            }
            
        }.resume()
    }
    
    
    
    func loadingVlauesInTgable() {
        // self.TableViewMain.reloadData()
    
      
       
           
           // Iterate through detailModal to extract unique designations
           detailModal.forEach { employee in
               if let designation = employee.designation, !uniqueDesignations.contains(designation) {
                   uniqueDesignations.append(designation)
               }
           }
           
print(uniqueDesignations)
          
    }
    
    
    
    @IBAction func ButtonADD(_ sender: Any) {
        let vc  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AddUserViewController") as! AddUserViewController
        vc.designations = uniqueDesignations
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayofDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // self.TableViewMain.rowHeight = 80.0
        let cell = TableViewMain.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let LabelName = cell.viewWithTag(100) as! UILabel
        let LabelDesignation = cell.viewWithTag(101) as! UILabel
        let labelDob = cell.viewWithTag(102) as! UILabel
        let commonArr = self.arrayofDict[indexPath.row]
      //  LabelName.text = commonArr["name"] as! String
//        labelDob.text = commonArr.bob
//        LabelDesignation.text = commonArr.designation
    //    labelDob.text = commonArr["dob"] as? String
   //     LabelDesignation.text = commonArr["designation"] as! String
        
        
        
//        if let designation1 = commonArr["designation"]! as String{
//            LabelDesignation.text = desigation1
        
        let userData = arrayofDict[indexPath.row]
          
          LabelName.text = userData["name"]
          LabelDesignation.text = userData["designation"]
          labelDob.text = userData["dob"]
//        }
        return cell
            
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle:     nil).instantiateViewController(withIdentifier: "DetailPageEmployeeViewController")  as! DetailPageEmployeeViewController
        self.navigationController?.pushViewController(vc, animated: true)
            
    }

}

