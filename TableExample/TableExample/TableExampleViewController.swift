//
//  TableExampleViewController.swift
//  TableExample
//
//  Created by Bharath on 07/05/24.
//



import UIKit

class TableExampleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var arrayOfPlayer :[[String:String]] = []
    var arrayOfImg : [String] = []
    var detailsModal : ModalBitcoin!
    @IBOutlet weak var TableViewExample: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewExample.delegate = self
        TableViewExample.dataSource = self
        TableViewExample.separatorStyle = .none
        apiCall(StringLink: "https://api.coindesk.com/v1/bpi/currentprice.json")
                            self.arrayOfPlayer = [
                                [ "Name":"Mahendra Singh Dhoni","Image":"Ms.jpg","Description":"Dhoni made his international debut in 2004. His talent with the bat came to the fore in an innings of 148 runs against Pakistan in his fifth international match. Within a year he joined the India Test team, where he quickly established himself with a century (100 or more runs in a single innings) against Pakistan. ","Role":"WK"],
                                ["Name":"Virender Sehwag", "Image":"sehwag.jpg","Description":"The most remarkable aspect of Sehwag's career of course has been his ability to build massive scores at breathtaking speed. He holds the Indian record for highest number of Test double-hundreds, and came within seven runs of becoming the first batsman to score three triple-hundreds.","Role":"Bat"],
                                ["Name":"Sachin Tendulkar","Image":"Sachin.jpg","Description":"Sachin Tendulkar, often hailed as the God of Cricket is an Indian cricket legend whose unmatched talent, consistency, and records have left an indelible mark on the sport worldwide. His mastery of the game and countless records, including being the highest run-scorer in both Test and ODI cricket, have made him an icon cherished by cricket enthusiasts globally.","Role":"Bat"],
                                ["Name":"Gautam Gambhir","Description":"Gautam Gambhir, a former Indian cricketer, was known for his tenacity and ability to anchor innings, particularly in pressure situations. His contributions played a crucial role in India's triumphs in the 2007 T20 World Cup and the 2011 Cricket World Cup, cementing his status as a respected figure in Indian cricket history.",  "Image":"Gowtham.jpg"   ,"Role":"Bat"    ],
                                ["Name":"Virat Kohli","Description":"Virat Kohli, the captain of the Indian cricket team, is renowned for his aggressive batting style and unwavering commitment to excellence. His remarkable consistency across all formats of the game and his leadership skills have established him as one of the modern greats of cricket, inspiring millions of fans around the world.","Image":"Virat.jpg"],
                                ["Name":"Yuvraj Singh","Description":"Yuvraj Singh, a dynamic left-handed batsman and a handy left-arm spinner, was a vital cog in the Indian cricket team for many years. Known for his explosive batting and remarkable fielding, Yuvraj's crowning glory came during the 2011 Cricket World Cup, where his all-round performances earned him the Player of the Tournament award and helped India clinch the title after 28 years. Off the field, his courageous battle against cancer and subsequent return to cricket made him an inspiration to many.","Image":"Yuvaraj.jpg","Role":"AR"],
                                ["Name":"Suresh Raina","Description":"Suresh Raina, a versatile cricketer, was known for his aggressive batting, electric fielding, and occasional off-spin. A key player in India's limited-overs setup, Raina played crucial roles in many memorable victories, including the 2011 Cricket World Cup triumph. His ability to perform under pressure and his team spirit made him a valuable asset to the Indian team for over a decade.","Role":"AR",
                                 "Image":"Raina.jpg"],
                                ["Name":"Harbhajan Singh","Image":"Harbajan.jpg","Description":"Harbhajan Singh, a prolific off-spinner, was a stalwart of the Indian cricket team for many years. Known for his lethal spin bowling, particularly in Test cricket, Harbhajan played a significant role in numerous Indian victories, including the famous series wins abroad. His battles with top batsmen and his knack for taking crucial wickets in critical moments earned him a special place in Indian cricket history.","Role":"Bowl"],
                                ["Name":"Zaheer Khan","Description":"Zaheer Khan, a skilled left-arm fast bowler, was a linchpin of the Indian bowling attack for over a decade. Known for his ability to swing the ball both ways and his mastery of reverse swing, Zaheer played a pivotal role in India's successes in Test and ODI cricket, including the historic 2011 Cricket World Cup victory. His intelligence, experience, and skill made him a mentor figure to younger bowlers and a respected figure in the cricketing world."
                                 ,"Image":"Zaheer.jpg"
                                ],
                                ["Name":"Munaf Patel","Description":"Munaf Patel, a right-arm fast bowler, was known for his ability to generate good pace and extract bounce from the pitch. He played a crucial role in India's bowling lineup, particularly in limited-overs cricket, contributing to the team's success in various tournaments. Munaf's accuracy and ability to bowl tight lines under pressure made him a valuable asset to the Indian team during his career.",
                                 "Image":"Munaf.jpg"
                                ],
                                ["Name":"Sreesanth","Description":"Sreesanth, a talented but controversial fast bowler, was known for his aggressive bowling style and occasional batting contributions. He had moments of brilliance on the field, including playing a significant role in India's victory in the inaugural T20 World Cup in 2007. However, his career was marred by controversies, particularly the spot-fixing scandal in the Indian Premier League, which led to his suspension from cricket.",
                                 "Image":"Sree.jpg","Role":"Bowl"
                                ]
                            ]
      //  self.arrayOfImg = ["Ms.jpg","Harbajan.jpg","Sree.jpg","Munaf.jpg","Zaheer.jpg"]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfPlayer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        self.TableViewExample.rowHeight = 80.0
        let cell = TableViewExample.dequeueReusableCell(withIdentifier:"Cell1" , for: indexPath)
        let img = cell.viewWithTag(100) as! UIImageView
        let labeltext = cell.viewWithTag(101) as! UILabel
        let labeltext2 = cell.viewWithTag(102) as! UILabel
        let arrayValues = arrayOfPlayer[indexPath.row]
      //  print(type(of: arrayOfImg))
        print(arrayValues)
       // var name = arrayOfPlayer[[arrayValues["Name"]]]
       // labeltext.text = arrayOfPlayer[indexPath.row]
    //    var imgna = arrayOfImg[indexPath.row]
        let name = arrayValues["Name"]
        
        labeltext.text = name
        let imgArr = arrayValues["Image"]
       print(imgArr)
        
        let LabelRole = arrayValues["Role"]
        if LabelRole == ""{
            labeltext2.text = " "
        }
        else{
            labeltext2.text = LabelRole
        }
        if let imageName = arrayValues["Image"], let image = UIImage(named: imageName) {
                img.image = image
            img.contentMode  = .scaleAspectFit
            }
     //   img.image = UIImage(named: imgArr)
            //   img.contentMode = .scaleAspectFit
        
    //    let labelName = arrayOfPlayer[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
        
    }
    

}

extension TableExampleViewController {
    
    
    func apiCall(StringLink :String){
        
        var UrlLink = URL(string: StringLink)!
        
        var urlRequest = URLRequest(url: UrlLink)
        
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest){
            data,response,error in
            if let output = data{
                print("output",output)
                do{
//                    let v = try JSONSerialization.jsonObject(with: output)
//                    print("Response", v)
                    let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(ModalBitcoin.self, from: output)
                    print("responseModel",responseModel)
                    self.detailsModal = responseModel
                }
                catch (let exp){
                    print(exp)
                }
            }
            else{
                print("no ")
            }
          
        }.resume()
   
    }
    
}
