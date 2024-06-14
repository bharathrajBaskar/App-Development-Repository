
import UIKit

class DescriptionViewController: UIViewController {

    @IBOutlet weak var LabelDescription: UILabel!
    @IBOutlet weak var LabelName: UILabel!
    @IBOutlet weak var ImageViewCelebrity: UIImageView!
    
    var ar:[String:String] = [:]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        LabelName.text = ar["Name"]
        LabelDescription.text = ar["Description"]
       
        
        if let imageName = ar["Image"] ,let img = UIImage(named: imageName)
        
        {
            ImageViewCelebrity.image = img
            ImageViewCelebrity.contentMode = .scaleAspectFit
        }
    }
    
    
    
}




