//
//  ListCollectionViewController.swift
//  TableExample
//
//  Created by Bharath on 10/05/24.
//

import UIKit

class ListCollectionViewController: UIViewController , UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    @IBOutlet weak var FullCollectionView: UICollectionView!
    var arrayOfdictionaryAct : [[String:String]]  = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.arrayOfdictionaryAct = [
            ["Name": "Rajinikanth", "Description": "Rajinikanth, often referred to as Thalaivar, is a legendary Tamil actor known for his charismatic screen presence and iconic style. With a career spanning several decades, Rajinikanth has delivered numerous blockbuster movies and has a massive fan following worldwide.", "Image": "Rajini.jpg", "Role": "Hero"],
            ["Name": "Kamal Haasan", "Description": "Kamal Haasan, hailed as Ulaganayagan, is a versatile actor, filmmaker, and politician. Renowned for his exceptional acting skills and ability to portray diverse characters, Kamal Haasan has left an indelible mark on the Tamil film industry.", "Image": "Kamal.jpg", "Role": "Hero"],
            ["Name": "Vijay", "Description": "Vijay, also known as Thalapathy, is one of the leading actors in Tamil cinema. With his charm, acting prowess, and mass appeal, Vijay has garnered a huge fan base and delivered several commercially successful films.", "Image": "Vijay.jpg", "Role": "Hero"],
            ["Name": "Ajith Kumar", "Description": "Ajith Kumar, fondly called Thala by his fans, is a popular actor known for his intense performances and action-packed roles. Despite facing numerous challenges, Ajith has risen to stardom through his dedication and hard work.", "Image": "Ajith.jpg", "Role": "Hero"],
            ["Name": "Nayanthara", "Description": "Nayanthara, often referred to as the Lady Superstar, is a highly acclaimed actress in Tamil cinema. With her impressive acting skills and diverse roles, Nayanthara has emerged as one of the most sought-after actresses in the industry.", "Image": "Nayanthara.jpg", "Role": "Heroine"],
          
            ["Name": "Suriya", "Description": "Suriya, recognized for his versatility and commitment to his craft, is a prominent actor in Tamil cinema. With a string of successful films, Suriya has won the hearts of audiences and established himself as a top star.", "Image": "Suriya.jpg", "Role": "Hero"],
            ["Name": "Trisha Krishnan", "Description": "Trisha Krishnan, known for her beauty and acting prowess, is a leading actress in Tamil and Telugu cinema. With a career spanning several years, Trisha has delivered several memorable performances and continues to be a favorite among audiences.", "Image": "Trisha.jpg", "Role": "Heroine"],
            ["Name": "Vijay Sethupathi", "Description": "Vijay Sethupathi, known for his versatile acting and unconventional roles, has emerged as one of the most talented actors in Tamil cinema. With a unique style and captivating performances, Vijay Sethupathi has garnered widespread acclaim and a dedicated fan following.", "Image": "Vijay_Sethupathi.jpg", "Role": "He ro"],  ["Name": "Rajinikanth", "Description": "Rajinikanth, often referred to as Thalaivar, is a legendary Tamil actor known for his charismatic screen presence and iconic style. With a career spanning several decades, Rajinikanth has delivered numerous blockbuster movies and has a massive fan following worldwide.", "Image": "Rajini.jpg", "Role": "Hero"],
            ["Name": "Kamal Haasan", "Description": "Kamal Haasan, hailed as Ulaganayagan, is a versatile actor, filmmaker, and politician. Renowned for his exceptional acting skills and ability to portray diverse characters, Kamal Haasan has left an indelible mark on the Tamil film industry.", "Image": "Kamal.jpg", "Role": "Hero"],
            ["Name": "Vijay", "Description": "Vijay, also known as Thalapathy, is one of the leading actors in Tamil cinema. With his charm, acting prowess, and mass appeal, Vijay has garnered a huge fan base and delivered several commercially successful films.", "Image": "Vijay.jpg", "Role": "Hero"],
            ["Name": "Ajith Kumar", "Description": "Ajith Kumar, fondly called Thala by his fans, is a popular actor known for his intense performances and action-packed roles. Despite facing numerous challenges, Ajith has risen to stardom through his dedication and hard work.", "Image": "Ajith.jpg", "Role": "Hero"],
            ["Name": "Nayanthara", "Description": "Nayanthara, often referred to as the Lady Superstar, is a highly acclaimed actress in Tamil cinema. With her impressive acting skills and diverse roles, Nayanthara has emerged as one of the most sought-after actresses in the industry.", "Image": "Nayanthara.jpg", "Role": "Heroine"],
          
            ["Name": "Suriya", "Description": "Suriya, recognized for his versatility and commitment to his craft, is a prominent actor in Tamil cinema. With a string of successful films, Suriya has won the hearts of audiences and established himself as a top star.", "Image": "Suriya.jpg", "Role": "Hero"],
            ["Name": "Trisha Krishnan", "Description": "Trisha Krishnan, known for her beauty and acting prowess, is a leading actress in Tamil and Telugu cinema. With a career spanning several years, Trisha has delivered several memorable performances and continues to be a favorite among audiences.", "Image": "Trisha.jpg", "Role": "Heroine"],
            ["Name": "Vijay Sethupathi", "Description": "Vijay Sethupathi, known for his versatile acting and unconventional roles, has emerged as one of the most talented actors in Tamil cinema. With a unique style and captivating performances, Vijay Sethupathi has garnered widespread acclaim and a dedicated fan following.", "Image": "Vijay_Sethupathi.jpg", "Role": "He ro"]
        ]
        
        
        FullCollectionView.delegate = self
        FullCollectionView.dataSource = self
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfdictionaryAct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = FullCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let imgView = cell.viewWithTag(300) as! UIImageView
        let labelName = cell.viewWithTag(301)as! UILabel
        
        let commonArr = arrayOfdictionaryAct[indexPath.item]
        
       
        labelName.text = commonArr["Name"]
        
        if let image = commonArr["Image"] , let assignImg = UIImage(named: image)
        {
            imgView.image = assignImg
            imgView.contentMode = .scaleAspectFit
            
        }
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2 - 10, height: 150.0 )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let arr = arrayOfdictionaryAct[indexPath.item]
        print(arr)
       // var ar:[String:String] = arr
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MultiplePicturesCollectionViewController") as! MultiplePicturesCollectionViewController
        vc.ar = arr
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
