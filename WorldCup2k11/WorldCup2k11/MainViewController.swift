//
//  MainViewController.swift
//  WorldCup2k11
//
//  Created by Bharath on 29/04/24.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var MSDBtn: UIButton!
    @IBOutlet weak var BtnAlert: UIButton!
    var arrayOfDictionary :[[String:String]] = [
        [ "Name":"Mahendra Singh Dhoni","Image":"Ms.jpg","Description":"Dhoni made his international debut in 2004. His talent with the bat came to the fore in an innings of 148 runs against Pakistan in his fifth international match. Within a year he joined the India Test team, where he quickly established himself with a century (100 or more runs in a single innings) against Pakistan. "],
        ["Name":"Virender Sehwag", "Image":"sehwag.jpg","Description":"The most remarkable aspect of Sehwag's career of course has been his ability to build massive scores at breathtaking speed. He holds the Indian record for highest number of Test double-hundreds, and came within seven runs of becoming the first batsman to score three triple-hundreds."],
        ["Name":"Sachin Tendulkar","Image":"Sachin.jpg","Description":"Sachin Tendulkar, often hailed as the God of Cricket is an Indian cricket legend whose unmatched talent, consistency, and records have left an indelible mark on the sport worldwide. His mastery of the game and countless records, including being the highest run-scorer in both Test and ODI cricket, have made him an icon cherished by cricket enthusiasts globally."],
        ["Name":"Gautam Gambhir","Description":"Gautam Gambhir, a former Indian cricketer, was known for his tenacity and ability to anchor innings, particularly in pressure situations. His contributions played a crucial role in India's triumphs in the 2007 T20 World Cup and the 2011 Cricket World Cup, cementing his status as a respected figure in Indian cricket history.",  "Image":"Gowtham.jpg"       ],
        ["Name":"Virat Kohli","Description":"Virat Kohli, the captain of the Indian cricket team, is renowned for his aggressive batting style and unwavering commitment to excellence. His remarkable consistency across all formats of the game and his leadership skills have established him as one of the modern greats of cricket, inspiring millions of fans around the world.","Image":"Virat.jpg"],
        ["Name":"Yuvraj Singh","Description":"Yuvraj Singh, a dynamic left-handed batsman and a handy left-arm spinner, was a vital cog in the Indian cricket team for many years. Known for his explosive batting and remarkable fielding, Yuvraj's crowning glory came during the 2011 Cricket World Cup, where his all-round performances earned him the Player of the Tournament award and helped India clinch the title after 28 years. Off the field, his courageous battle against cancer and subsequent return to cricket made him an inspiration to many.","Image":"Yuvaraj.jpg"],
        ["Name":"Suresh Raina","Description":"Suresh Raina, a versatile cricketer, was known for his aggressive batting, electric fielding, and occasional off-spin. A key player in India's limited-overs setup, Raina played crucial roles in many memorable victories, including the 2011 Cricket World Cup triumph. His ability to perform under pressure and his team spirit made him a valuable asset to the Indian team for over a decade.",
         "Image":"Raina.jpg"],
        ["Name":"Harbhajan Singh","Image":"Harbajan.jpg","Description":"Harbhajan Singh, a prolific off-spinner, was a stalwart of the Indian cricket team for many years. Known for his lethal spin bowling, particularly in Test cricket, Harbhajan played a significant role in numerous Indian victories, including the famous series wins abroad. His battles with top batsmen and his knack for taking crucial wickets in critical moments earned him a special place in Indian cricket history."],
        ["Name":"Zaheer Khan","Description":"Zaheer Khan, a skilled left-arm fast bowler, was a linchpin of the Indian bowling attack for over a decade. Known for his ability to swing the ball both ways and his mastery of reverse swing, Zaheer played a pivotal role in India's successes in Test and ODI cricket, including the historic 2011 Cricket World Cup victory. His intelligence, experience, and skill made him a mentor figure to younger bowlers and a respected figure in the cricketing world."
         ,"Image":"Zaheer.jpg"
        ],
        ["Name":"Munaf Patel","Description":"Munaf Patel, a right-arm fast bowler, was known for his ability to generate good pace and extract bounce from the pitch. He played a crucial role in India's bowling lineup, particularly in limited-overs cricket, contributing to the team's success in various tournaments. Munaf's accuracy and ability to bowl tight lines under pressure made him a valuable asset to the Indian team during his career.",
         "Image":"Munaf.jpg"
        ],
        ["Name":"Sreesanth","Description":"Sreesanth, a talented but controversial fast bowler, was known for his aggressive bowling style and occasional batting contributions. He had moments of brilliance on the field, including playing a significant role in India's victory in the inaugural T20 World Cup in 2007. However, his career was marred by controversies, particularly the spot-fixing scandal in the Indian Premier League, which led to his suspension from cricket.",
         "Image":"Sree.jpg"
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MSDBtn.layer.borderColor = UIColor.blue.cgColor
        MSDBtn.layer.cornerRadius = 6.0
        MSDBtn.layer.borderWidth = 1.0
        MSDBtn.tintColor = .black
        MSDBtn.titleEdgeInsets = UIEdgeInsets(top: 5, left: 2, bottom: 5, right: 2)
        
        
        
    }
    func  callViewControllerwk( Position : Int){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScrollDescViewController") as! ScrollDescViewController
        vc.arrayOfDictionary = [arrayOfDictionary[Position]]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func scrollViewController(Position : Int){
        let vc = UIStoryboard(name: "Main", bundle:     nil).instantiateViewController(withIdentifier: "ScrollDescViewController") as!
        ScrollDescViewController
        vc.arrayOfDictionary = [arrayOfDictionary[Position]]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func BtnSehwag(_ sender: Any) {
        scrollViewController(Position: 01)
        // callViewControllerwk(Position: 1)
    }
    
    
    
    @IBAction func BtnMsd(_ sender: Any) {
        //         let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WicketKeeperViewController") as! WicketKeeperViewController
        //         vc.arrayOfDictionary = [arrayOfDictionary[0]]
        //         self.navigationController?.pushViewController(vc, animated: true)
        scrollViewController(Position: 0)
        
    }
    
    
    
    @IBAction func BtnSachin(_ sender: Any) {
        //        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WicketKeeperViewController") as! WicketKeeperViewController
        //        vc.arrayOfDictionary = [arrayOfDictionary[2]]
        //        self.navigationController?.pushViewController(vc, animated: true)
        scrollViewController(Position: 02)
        //callViewControllerwk(Position: 2)
    }
    
    
    @IBAction func BtnGambhir(_ sender: Any) {
        scrollViewController(Position: 03)
       // callViewControllerwk(Position: 3)
    }
    
    
    @IBAction func BtnVirat(_ sender: Any) {
        scrollViewController(Position: 04)
        // callViewControllerwk(Position: 4)
    }
    
    
    @IBAction func BtnYuvaraj(_ sender: Any) {
        scrollViewController(Position: 05)
      //  callViewControllerwk(Position: 5)
    }
    
    
    
    @IBAction func BtnRaina(_ sender: Any) {
        scrollViewController(Position: 06)
       // callViewControllerwk(Position: 6)
    }
    
    @IBAction func BtnHarbhajan(_ sender: Any) {
        scrollViewController(Position: 07)
      //  callViewControllerwk(Position: 7)
    }
    
    
    @IBAction func BtnZaheer(_ sender: Any) {
        scrollViewController(Position: 08)
     //   callViewControllerwk(Position: 8)
    }
    
    
    @IBAction func BtnMpatel(_ sender: Any) {
        scrollViewController(Position: 09)
        // callViewControllerwk(Position: 9   )
    }
    
    
    @IBAction func BtnSreeSanth(_ sender: Any) {
        scrollViewController(Position: 10)
       // callViewControllerwk(Position: 10)
    }
    
    @IBAction func SheetAction(_ sender: Any) {let dialogueMessage = UIAlertController(title: "Confirm Please", message: "Do you want to change the color of the view ", preferredStyle: .actionSheet)
        
        let okButton = UIAlertAction(title: "Ok", style: .default,handler: {
            (action) -> Void in
            self.view.backgroundColor = .red
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel,handler: {
            (action) -> Void in
            print("cancel action")
        })
        dialogueMessage.addAction(okButton)
        dialogueMessage.addAction(cancelButton)
        self.present(dialogueMessage, animated: true,completion: nil)
    }
    @IBAction func BtnAlertAction(_ sender: Any) {
        //declarimng the alert
        let dialogueMessage = UIAlertController(title: "Confirm Please", message: "Do you want to change the color of the view ", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Ok", style: .default,handler: {
            (action) -> Void in
            self.view.backgroundColor = .systemPink
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel,handler: {
            (action) -> Void in
            print("cancel action")
        })
        dialogueMessage.addAction(okButton)
        dialogueMessage.addAction(cancelButton)
        self.present(dialogueMessage, animated: true,completion: nil)
        
    }}
