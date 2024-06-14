//
//  OnlyTableCustomViewController.swift
//  TableExample
//
//  Created by Bharath on 08/05/24.
//

import UIKit

class OnlyTableCustomViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var ButtonNextCustom: UIButton!
    
    @IBOutlet weak var TableViewCustom: UITableView!
    var arrayOfdictionaryActor:[[String:String]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewCustom.delegate = self
        TableViewCustom.dataSource = self
        TableViewCustom.separatorStyle = .none
        self.arrayOfdictionaryActor = [
            ["Name": "Rajinikanth", "Description": "Rajinikanth, often referred to as Thalaivar, is a legendary Tamil actor known for his charismatic screen presence and iconic style. With a career spanning several decades, Rajinikanth has delivered numerous blockbuster movies and has a massive fan following worldwide.", "Image": "Rajini.jpg", "Role": "Hero"],
            ["Name": "Kamal Haasan", "Description": "Kamal Haasan, hailed as Ulaganayagan, is a versatile actor, filmmaker, and politician. Renowned for his exceptional acting skills and ability to portray diverse characters, Kamal Haasan has left an indelible mark on the Tamil film industry.", "Image": "Kamal.jpg", "Role": "Hero"],
            ["Name": "Vijay", "Description": "Vijay, also known as Thalapathy, is one of the leading actors in Tamil cinema. With his charm, acting prowess, and mass appeal, Vijay has garnered a huge fan base and delivered several commercially successful films.", "Image": "Vijay.jpg", "Role": "Hero"],
            ["Name": "Ajith Kumar", "Description": "Ajith Kumar, fondly called Thala by his fans, is a popular actor known for his intense performances and action-packed roles. Despite facing numerous challenges, Ajith has risen to stardom through his dedication and hard work.", "Image": "Ajith.jpg", "Role": "Hero"],
            ["Name": "Nayanthara", "Description": "Nayanthara, often referred to as the Lady Superstar, is a highly acclaimed actress in Tamil cinema. With her impressive acting skills and diverse roles, Nayanthara has emerged as one of the most sought-after actresses in the industry.", "Image": "Nayanthara.jpg", "Role": "Heroine"],
          
            ["Name": "Suriya", "Description": "Suriya, recognized for his versatility and commitment to his craft, is a prominent actor in Tamil cinema. With a string of successful films, Suriya has won the hearts of audiences and established himself as a top star.", "Image": "Suriya.jpg", "Role": "Hero"],
            ["Name": "Trisha Krishnan", "Description": "Trisha Krishnan, known for her beauty and acting prowess, is a leading actress in Tamil and Telugu cinema. With a career spanning several years, Trisha has delivered several memorable performances and continues to be a favorite among audiences.", "Image": "Trisha.jpg", "Role": "Heroine"],
            ["Name": "Vijay Sethupathi", "Description": "Vijay Sethupathi, known for his versatile acting and unconventional roles, has emerged as one of the most talented actors in Tamil cinema. With a unique style and captivating performances, Vijay Sethupathi has garnered widespread acclaim and a dedicated fan following.", "Image": "Vijay_Sethupathi.jpg", "Role": "He ro"]
        ]
        
        self.TableViewCustom.rowHeight = 100.0
        let nib  = UINib(nibName: "CustomTableCellsTableViewCell", bundle: nil)
        TableViewCustom.register(nib, forCellReuseIdentifier: "CustomTableCellsTableViewCell")
       
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfdictionaryActor.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableViewCustom.dequeueReusableCell(withIdentifier: "CustomTableCellsTableViewCell",for: indexPath)
        as! CustomTableCellsTableViewCell
        
        let actorName = arrayOfdictionaryActor[indexPath.row]
      cell.LabelActorName.text = actorName["Name"]
        cell.LabelActorRole.text = actorName["Role"]
        
        if let imageAct = actorName["Image"] , let img = UIImage(named: imageAct){
            cell.ImageViewActor.image = img
            cell.ImageViewActor.contentMode = .scaleAspectFit
        }
        cell.selectionStyle = .none
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let arr = arrayOfdictionaryActor[indexPath.row]
        print(arr)
       // var ar:[String:String] = arr
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DescriptionViewController") as! DescriptionViewController
        vc.ar = arr
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func ButtonNextCustom(_ sender: Any) {
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "MultipleScreenTableViewViewController") as! MultipleScreenTableViewViewController
//        self.navigationController?.pushViewController(vc, animated:    true)
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
