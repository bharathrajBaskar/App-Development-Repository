import UIKit

class VerticalButtonViewController: UIViewController, ScrollDescViewControllerDelegate {
    
    @IBOutlet weak var buttonMSD: UIButton!
    
    @IBOutlet weak var buttonSehwag: UIButton!
    
    @IBOutlet weak var buttonSachin: UIButton!
    
    
    @IBOutlet weak var buttonGowtham: UIButton!
    
    @IBOutlet weak var buttonKholi: UIButton!
    
    @IBOutlet weak var buttonYuvaraj: UIButton!
    
    
    @IBOutlet weak var buttonRaina: UIButton!
    
    
    @IBOutlet weak var buttonHarbhajan: UIButton!
    
    
    @IBOutlet weak var buttonZaheer: UIButton!
    
    @IBOutlet weak var buttonMunaf: UIButton!
    
    @IBOutlet weak var buttonSreesanth: UIButton!
    var playerName = ""
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
        ]]
    override func viewDidLoad() {
        super.viewDidLoad()

    
        
        self.buttonMSD.addTarget(self, action: #selector(self.callForMSD), for: .touchUpInside)
        self.buttonSehwag.addTarget(self, action: #selector(self.callForSehwag), for: .touchUpInside)
        self.buttonSachin.addTarget(self, action: #selector(self.callForSachin), for: .touchUpInside)
        self.buttonGowtham.addTarget(self, action: #selector(self.callForGowtham), for: .touchUpInside)
        self.buttonKholi.addTarget(self, action: #selector(self.callForKholi), for: .touchUpInside)
        self.buttonYuvaraj.addTarget(self, action: #selector(self.callForYuvaraj), for: .touchUpInside)
        self.buttonRaina .addTarget(self, action: #selector(self.callForRaina), for: .touchUpInside)
        self.buttonHarbhajan.addTarget(self, action: #selector(self.callForHarbajan), for: .touchUpInside)
        self.buttonZaheer.addTarget(self, action: #selector(self.callForZaheer), for: .touchUpInside)
        self.buttonMunaf.addTarget(self, action: #selector(self.callForMunaf), for: .touchUpInside)
        self.buttonSreesanth.addTarget(self, action: #selector(self.callForSreesanth), for: .touchUpInside)
        
        
    }
    func  callViewControllerwk( Position : Int){
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScrollDescViewController") as! ScrollDescViewController
//        vc.arrayOfDictionary = [arrayOfDictionary[Position]]
//        self.navigationController?.pushViewController(vc, animated: true)
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScrollDescViewController") as! ScrollDescViewController
        vc.arrayOfDictionary = [arrayOfDictionary[Position]]
        vc.playerName = arrayOfDictionary[Position]["Name"] ?? ""
                vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
         
    }

   
    @objc func callForMSD() {
        callViewControllerwk(Position: 0    )
    }
    
    
    @objc func callForSehwag(){
        callViewControllerwk(Position: 1)
        
        
    }
    
    @objc func callForSachin(){
        callViewControllerwk(Position: 2)
        
    }
    
    @objc func callForGowtham(){
        callViewControllerwk(Position: 3)
    }
    
    @objc func callForKholi(){
        callViewControllerwk(Position: 4)
    }
    
    @objc func callForYuvaraj(){
        callViewControllerwk(Position: 5)
    }
    
    @objc func callForRaina(){
        callViewControllerwk(Position: 6)
    }
    
    
    @objc func callForHarbajan(){
        callViewControllerwk(Position: 7)
    }
    @objc func callForZaheer(){
        callViewControllerwk(Position: 8)
    }
    @objc func callForMunaf(){
        callViewControllerwk(Position: 9)
    }
    @objc func callForSreesanth(){
        callViewControllerwk(Position: 10)
    }
    func switchToggledForPlayer(_ playerName: String, isCaptain: Bool) {
         
          switch playerName {
          case "Mahendra Singh Dhoni":
              buttonMSD.setTitle(isCaptain ? "Captain MSD" : "MSD", for: .normal)
          case "Virender Sehwag":
              buttonSehwag.setTitle(isCaptain ? "Captain Sehwag" : "Sehwag", for: .normal)
         case "Sachin Tendulkar" :
              buttonSachin.setTitle(isCaptain ?"Captain Sachin" : "Sachin", for: .normal)
              
              
          default:
              break
          }
      }
}
