
import UIKit
protocol ScrollDescViewControllerDelegate: AnyObject {
    func switchToggledForPlayer(_ playerName: String, isCaptain: Bool)
}

class ScrollDescViewController: UIViewController {
    @IBOutlet weak var NameView: UIView!
    @IBOutlet weak var buttonBackGroundImage: UIButton!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var ImgMainView: UIView!
    @IBOutlet weak var ButtonImg: UIImageView!
    @IBOutlet weak var ImgImageView: UIImageView!
    @IBOutlet weak var DescriptionView: UIView!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    var arrayOfDictionary:[[String:String]] = []
    var playerName = ""
    weak var delegate: ScrollDescViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.switchButton.setOn(false, animated: false)
        NameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        print(arrayOfDictionary)
        switchButton.addTarget(self, action: #selector(SwitchButtonAction(_:)), for: .valueChanged)
      
        if let firstPlayer = arrayOfDictionary.first {
            if let name = firstPlayer["Name"], let imageStr = firstPlayer["Image"],
                let description = firstPlayer["Description"] {
                NameLabel.text = name
                self.playerName = name
                print(playerName)
                let image :UIImage = UIImage(named: imageStr)!
                ButtonImg.image = image
                ButtonImg.contentMode = .scaleAspectFit
                DescriptionLabel.text = description
                
                
            }
            
        }
      
    }
    
    
    @IBAction func SwitchButtonAction(_ sender: UISwitch) {
        let isCaptain = sender.isOn
                delegate?.switchToggledForPlayer(playerName, isCaptain: isCaptain)
        
    }
    @IBAction func imageButtonFullScreen(_ sender: Any) {
        print("Button is working")
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FullSizeImageViewController") as! FullSizeImageViewController
        print("Button is working 1")
        print(vc.arrayOfDictioanry1)
        vc.arrayOfDictioanry1 = [arrayOfDictionary[0]]
        print(vc.arrayOfDictioanry1)
        print("Button is working 2")
        self.navigationController?.pushViewController(vc, animated: true)
        print("Button is working 3")
        
    }
    
}
