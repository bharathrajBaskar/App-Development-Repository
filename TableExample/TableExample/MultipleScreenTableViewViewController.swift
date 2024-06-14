//
//  MultipleScreenTableViewViewController.swift
//  TableExample
//
//  Created by Bharath on 08/05/24.
//

import UIKit

class MultipleScreenTableViewViewController: UIViewController,UITableViewDelegate ,UITableViewDataSource {
    

    var arrayOfDictionaryForPlayers : [[String:String]] = []
    
    
    @IBOutlet weak var TableViewMultiple: UITableView!
    
    @IBOutlet weak var NextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableViewMultiple.delegate = self
        TableViewMultiple.dataSource = self
        TableViewMultiple.separatorStyle = .none


    }
        
    @IBAction func NextButtonRight(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "OnlyTableCustomViewController")
//        self.navigationController?.pushViewController(vc, animated: true)
        self.arrayOfDictionaryForPlayers = [
            
            [ "Name":"Mahendra Singh Dhoni","Image":"Ms.jpg","Description":"Dhoni made his international debut in 2004. His talent with the bat came to the fore in an innings of 148 runs against Pakistan in his fifth international match. Within a year he joined the India Test team, where he quickly established himself with a century (100 or more runs in a single innings) against Pakistan. ","Role":"WK"],
            ["Name":"Virender Sehwag", "Image":"sehwag.jpg","Description":"The most remarkable aspect of Sehwag's career of course has been his ability to build massive scores at breathtaking speed. He holds the Indian record for highest number of Test double-hundreds, and came within seven runs of becoming the first batsman to score three triple-hundreds.","Role":"Bat"],
            ["Name":"Sachin Tendulkar","Image":"Sachin.jpg","Description":"SSachin Tendulkar, often hailed as the God of Cricket, is a legendary figure in the world of sports. Born on April 24, 1973, in Mumbai, India, Tendulkar's cricketing journey is marked by records, accolades, and unwavering admiration from fans worldwide. Making his debut for the Indian cricket team at the tender age of 16, Tendulkar's career spanned over two decades, during which he showcased unparalleled skill, consistency, and passion for the game. His batting prowess was unmatched, characterized by impeccable technique, exquisite timing, and an insatiable hunger for runs. Tendulkar holds numerous records in international cricket, including being the highest run-scorer in both Test and One Day International (ODI) formats. Beyond statistics, Sachin's influence transcended the boundary ropes, inspiring generations of cricketers and fans alike. His humility, dedication, and sportsmanship endeared him to millions, earning him the title of Master Blaster and a special place in the hearts of cricket enthusiasts worldwide.","Role":"Bat"],
            ["Name":"Gautam Gambhir","Description":"Gautam Gambhir, a former Indian cricketer, was known for his tenacity and ability to anchor innings, particularly in pressure situations. His contributions played a crucial role in India's triumphs in the 2007 T20 World Cup and the 2011 Cricket World Cup, cementing his status as a respected figure in Indian cricket history.",  "Image":"Gowtham.jpg"   ,"Role":"Bat"    ],
            ["Name":"Virat Kohli","Description":"Virat Kohli, the captain of the Indian cricket team, is renowned for his aggressive batting style and unwavering commitment to excellence. His remarkable consistency across all formats of the game and his leadership skills have established him as one of the modern greats of cricket, inspiring millions of fans around the world.","Image":"Virat.jpg","Role":"Bat"],
            ["Name":"Yuvraj Singh","Description":"Yuvraj Singh, a dynamic left-handed batsman and a handy left-arm spinner, was a vital cog in the Indian cricket team for many years. Known for his explosive batting and remarkable fielding, Yuvraj's crowning glory came during the 2011 Cricket World Cup, where his all-round performances earned him the Player of the Tournament award and helped India clinch the title after 28 years. Off the field, his courageous battle against cancer and subsequent return to cricket made him an inspiration to many.","Image":"Yuvaraj.jpg","Role":"AR"],
            ["Name":"Suresh Raina","Description":"Suresh Raina, a versatile cricketer, was known for his aggressive batting, electric fielding, and occasional off-spin. A key player in India's limited-overs setup, Raina played crucial roles in many memorable victories, including the 2011 Cricket World Cup triumph. His ability to perform under pressure and his team spirit made him a valuable asset to the Indian team for over a decade.","Role":"AR",
             "Image":"Raina.jpg"],
            ["Name":"Harbhajan Singh","Image":"Harbajan.jpg","Description":"Harbhajan Singh, a prolific off-spinner, was a stalwart of the Indian cricket team for many years. Known for his lethal spin bowling, particularly in Test cricket, Harbhajan played a significant role in numerous Indian victories, including the famous series wins abroad. His battles with top batsmen and his knack for taking crucial wickets in critical moments earned him a special place in Indian cricket history.","Role":"Bowl"],
            ["Name":"Zaheer Khan","Description":"Zaheer Khan, a skilled left-arm fast bowler, was a linchpin of the Indian bowling attack for over a decade. Known for his ability to swing the ball both ways and his mastery of reverse swing, Zaheer played a pivotal role in India's successes in Test and ODI cricket, including the historic 2011 Cricket World Cup victory. His intelligence, experience, and skill made him a mentor figure to younger bowlers and a respected figure in the cricketing world."
             ,"Image":"Zaheer.jpg","Role":"Bowl"
            ],
            ["Name":"Munaf Patel","Description":"Munaf Patel, a right-arm fast bowler, was known for his ability to generate good pace and extract bounce from the pitch. He played a crucial role in India's bowling lineup, particularly in limited-overs cricket, contributing to the team's success in various tournaments. Munaf's accuracy and ability to bowl tight lines under pressure made him a valuable asset to the Indian team during his career.",
             "Image":"Munaf.jpg","Role":"Bowl"
            ],
            ["Name":"Sreesanth","Description":"Sreesanth, a talented but controversial fast bowler, was known for his aggressive bowling style and occasional batting contributions. He had moments of brilliance on the field, including playing a significant role in India's victory in the inaugural T20 World Cup in 2007. However, his career was marred by controversies, particularly the spot-fixing scandal in the Indian Premier League, which led to his suspension from cricket.",
             "Image":"Sree.jpg","Role":"Bowl"
            ]
        ]
        self.TableViewMultiple.reloadData()
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let arr = arrayOfDictionaryForPlayers[indexPath.row]
        print(arr)
       // var ar:[String:String] = arr
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DescriptionViewController") as! DescriptionViewController
        vc.ar = arr
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfDictionaryForPlayers.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.TableViewMultiple.rowHeight = 100.0
        let cell = TableViewMultiple.dequeueReusableCell(withIdentifier: "CellOne", for: indexPath)
        
        let imageViewPlayer = cell.viewWithTag(200) as! UIImageView
        
        let labelName = cell.viewWithTag(201) as! UILabel
        
        let labelRole = cell.viewWithTag(230) as! UILabel
        
        let currentArray = arrayOfDictionaryForPlayers[indexPath.row]
        let playerName = currentArray["Name"]
        labelName.text = playerName
        let  playerRole = currentArray["Role"]
        labelRole.text = playerRole
        //print(labelRole.text)
        if let imageForPlayer = currentArray["Image"] , let assignImg = UIImage(named: imageForPlayer)
        {
            imageViewPlayer.image = assignImg
            imageViewPlayer.contentMode = .scaleAspectFit
            
        }
        cell.selectionStyle = .none
        
            return cell
        
        
    }
    

    
}
