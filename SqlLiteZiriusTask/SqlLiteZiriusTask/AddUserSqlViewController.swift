

import UIKit

class AddUserSqlViewController: UIViewController {
    var dob = Date()
   
    var datePicker = UIDatePicker()
    @IBOutlet weak var TextFieldemail: UITextField!
    @IBOutlet weak var ImageViewProfile: UIImageView!
    @IBOutlet weak var TextFieldPhoneNo: UITextField!
    @IBOutlet weak var TextFieldDob: UITextField!
    @IBOutlet weak var TextFieldName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createDatePicker()
       
    }
    
    func createToolBar() ->UIToolbar{
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action:  #selector(doneBtn))
        toolBar.setItems([doneBtn], animated: true)
        return  toolBar
    }
    
    func createDatePicker(){
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.datePickerMode = .date
        TextFieldDob.inputView = datePicker
        TextFieldDob.inputAccessoryView = createToolBar()
    }
    
   @objc func doneBtn(){
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "dd/M/yyy"
  //     dateFormatter.dateStyle = .medium
       dateFormatter.timeZone = .none
       self.TextFieldDob.text = dateFormatter.string(from: datePicker.date)
       self.dob = datePicker.date
       // self.view.endEditing(true)
       TextFieldDob.resignFirstResponder()
    }
    
    @IBAction func ButtonUpload(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc,animated: true)
    }
    

    @IBAction func ButtonSubmit(_ sender: Any) {
        let imgPath = saveImageToDocumentsDirectory(image: ImageViewProfile.image!)
        print(imgPath!)
        guard let imagePath = imgPath else{
            print("Error")
            return
        }
//        print("image path = ",imagePath)
        let insert = dbTable.insertUser(name: TextFieldName.text!, date_of_birth: dob, phone_no: TextFieldPhoneNo.text!, image: imagePath, email: TextFieldemail.text!)
        if insert{
            print("Successfull")
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CollectionViewController") as!  CollectionViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            print("Failed..")
        }
        
    }
    
    
    func saveImageToDocumentsDirectory(image: UIImage) -> String? {

        guard let data = image.jpegData(compressionQuality: 1.0) ?? image.pngData() else {
            return nil
        }


        let timestamp = Int(Date().timeIntervalSince1970)
        let imageName = "bharath_\(timestamp).png"


        guard let documentsDirectoryString = UserDefaults.standard.string(forKey: kForFileManagerPath),
              let documentsDirectoryURL = URL(string: documentsDirectoryString) else {
            print("Failed to retrieve documents directory from UserDefaults")
            return nil
        }

        let filePath = documentsDirectoryURL.appendingPathComponent(imageName)
        do {
            try data.write(to: filePath)
            return filePath.path
        } catch {
            print("Error saving image: \(error)")
            return nil
        }
    }


}

extension AddUserSqlViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            ImageViewProfile.image = image
            picker.dismiss(animated: true,completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true,completion: nil)
    }
}
