//
//  OrderHistoryViewController.swift
//  GroceryApp
//
//  Created by Bharath on 14/06/24.
//

import UIKit

class OrderHistoryViewController: UIViewController {

    @IBOutlet weak var OrderHistoryTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func ButtonBackClicked(_ sender: Any) {
        
        
    }
   

}

extension OrderHistoryViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    
    
    
}
