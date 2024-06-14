

import UIKit
var userArrayOfDictionary:[[String:String]] = []
class EditPageViewController: UIViewController ,UpdateViewControllerDelegate{
    var EditPageDict:[String:String] = [:]
    @IBOutlet weak var ButtonEdit: UIButton!
    @IBOutlet weak var ButtonDelete: UIButton!
    @IBOutlet weak var LabelDob: UILabel!
    @IBOutlet weak var ImageViewProfilePicture: UIImageView!
    @IBOutlet weak var LabelMobile: UILabel!
    @IBOutlet weak var LabelName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setValues(Dict: EditPageDict)
       print(EditPageDict)


    }

    @IBAction func ButtonDeleteFunc(_ sender: Any) {
        
       let funccall = dbTable.DeleteanItemDb(email: EditPageDict["email"]!)
     
        
        if funccall {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotifyForFetch), object: nil)
                    self.navigationController?.popViewController(animated: true)
                } else {
                    print("Failed to delete user")
                }

    }
    
    @IBAction func ButtonEditFunc(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UpdateViewController") as! UpdateViewController
        vc.arrayOfDict = EditPageDict
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func setValues(Dict:[String:String]){
        
        LabelDob.text = Dict["date_of_birth"]
        LabelName.text = Dict["name"]
        LabelMobile.text = Dict["phone_no"]
        if let imgPath = Dict["image"]  {
            if let urlImage = URL(string: imgPath)?.lastPathComponent {
                let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
                let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
                let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
                if let dirPath          = paths.first
                {
                    let imageURLLocation = URL(fileURLWithPath: dirPath).appendingPathComponent(urlImage)
                    let image    = UIImage(contentsOfFile: imageURLLocation.path)
                    print(imgPath)
                    print(urlImage)
                    print(dirPath)
                    print(imageURLLocation)
                    print(image)
                    self.ImageViewProfilePicture.image = image
                }
            }

        }
        
    }
    func didUpdateUser(updatedUser: [String: String]) {
            self.EditPageDict = updatedUser
            self.setValues(Dict: updatedUser)
        }

}

