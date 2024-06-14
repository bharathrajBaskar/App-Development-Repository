
import UIKit

class DetailPageEmployeeViewController: UIViewController {

    @IBOutlet weak var TextViewDescription: UITextView!
    @IBOutlet weak var LabelDesignation: UILabel!
    @IBOutlet weak var ImageViewProfilePicture: UIImageView!
    @IBOutlet weak var LabelName: UILabel!
    var arrayofDict :[[ String:String]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        TextViewDescription.layer.borderColor = UIColor.black.cgColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageViewtapped))
        self.ImageViewProfilePicture.isUserInteractionEnabled = true
        self.ImageViewProfilePicture.addGestureRecognizer(tap)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let array = UserDefaults.standard.object(forKey: "myList") as? [[String:String]] {
            if array.count > 0 {
                self.arrayofDict = array
                //self.TableViewMain.reloadData()
                
                let userData = arrayofDict[0]
                  
                  LabelName.text = userData["name"]
                  LabelDesignation.text = userData["designation"]
                TextViewDescription.text = userData["description"]
                if let imagePath = userData["imagePath"] {
                    print(imagePath)
                                  if let image = UIImage(contentsOfFile: imagePath) {
                                      ImageViewProfilePicture.image = image
                                  }
                
              }
            }
        }
    }
    
    
    @objc func imageViewtapped( ){
        
        
        let objectToSend: [String: String] = ["name": LabelName.text ?? "", "designation": LabelDesignation.text ?? ""]
        
        // Post the object via notification
        NotificationCenter.default.post(name: NSNotification.Name("ObjectSentNotification"), object: objectToSend)

        NotificationCenter.default.post(name: NSNotification.Name("barath"), object: nil)
    }

    

}
