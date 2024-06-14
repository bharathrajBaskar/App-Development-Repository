

import UIKit

class AddUserViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate {
  
    let userDefaultsLocal = UserDefaults.standard
    @IBOutlet weak var TextViewDescription: UITextView!
    
    @IBOutlet weak var LabelDescription: UILabel!
    @IBOutlet weak var ImageViewProfilePic: UIImageView!
    @IBOutlet weak var TextFieldDesignation: UITextField!
    @IBOutlet weak var LabelDesignation: UILabel!
    @IBOutlet weak var TextFieldDob: UITextField!
    @IBOutlet weak var LabelDob: UILabel!
    @IBOutlet weak var TextFieldName: UITextField!
    @IBOutlet weak var LabelName: UILabel!
    @IBOutlet weak var TableView2: UITableView!
    var designations = [String]()
    let datepicker = UIDatePicker()
    
    var dictUD = [String:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView2.dataSource = self
        TableView2.delegate = self
        TableView2.isHidden = true
        self.createDatepicker()
        TextFieldDesignation.delegate = self
        print("Unique designation",designations)
        ImageViewProfilePic.layer .borderWidth = 1
        ImageViewProfilePic.layer.masksToBounds = false
        ImageViewProfilePic.layer.borderColor = UIColor.black.cgColor
        ImageViewProfilePic.layer.cornerRadius = ImageViewProfilePic.frame.height/2
        ImageViewProfilePic.clipsToBounds = true
        let img = UIImage(named: "uploadImage.jpg")
        ImageViewProfilePic.image = img
        ImageViewProfilePic.contentMode = .scaleAspectFit
//        NotificationCenter.default.addObserver(self, selector: #selector(AddUserViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//
//             // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
//           NotificationCenter.default.addObserver(self, selector: #selector(AddUserViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
//
//    @objc func keyboardWillShow(notification: NSNotification) {
//
//        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//
//           return
//        }
//      self.view.frame.origin.y = 0 - keyboardSize.height
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//      self.view.frame.origin.y = 0
//    }
    
    @IBAction func ButtonSubmit(_ sender: Any) {
        
        if self.TextFieldName.text!.count > 0 {
            dictUD["name"] = self.TextFieldName.text
        }
        if self.TextFieldDob.text!.count > 0{
            dictUD["dob"] = self.TextFieldDob.text
        }
        if self.TextFieldDesignation.text!.count > 0{
            dictUD["designation"] = self.TextFieldDesignation.text
            print("designation completed")
        }
        if let description = self.TextViewDescription.text, !description.isEmpty {
                dictUD["description"] = description
            }
        
        if let imageSave = ImageViewProfilePic.image{
            save(img: imageSave)
            if let imagePath = UserDefaults.standard.string(forKey: "ProfilePicturePath"){
                dictUD["imagePath"] = imagePath
            }
        }
        
        
        UserDefaults.standard.set([dictUD], forKey: "myList")
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func ButtonUpload(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
            //  imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
      present(imagePicker, animated: true)
        
    }
    
    
    func createToolBar() -> UIToolbar{
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let ButtonDone = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClick))
        
        toolbar.setItems([ButtonDone], animated: true)
        
        
        return toolbar
    }

    func createDatepicker(){
        if #available(iOS 13.4, *) {
            datepicker.preferredDatePickerStyle = .wheels
        }
        datepicker.datePickerMode = .date
        TextFieldDob.inputView = datepicker
        TextFieldDob.inputAccessoryView = createToolBar()
        
    }
    
    @objc  func doneClick (){
let dateForametter  = DateFormatter()
      dateForametter.dateStyle = .medium
      dateForametter.timeStyle = .none
      //self.TextFieldDob.text = "\(datepicker)"  dateFormat.string(from: date.date)
        
        self.TextFieldDob.text = dateForametter.string(from: datepicker.date)
//      self.view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return designations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView2.dequeueReusableCell(withIdentifier: "Cell2",for: indexPath)
        let designationLabel = cell.viewWithTag(100) as! UILabel
        designationLabel.text = designations[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TextFieldDesignation.text = designations[indexPath.row]
        TableView2.isHidden = true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        TableView2.isHidden = false
    }
    func save(img : UIImage){
//        let data = img.pngData()! as NSData
//        userDefaultsLocal.set(data, forKey: "ProfilePicture")
//        print("Pic saved")
        
        if let data  = img.pngData(){
            let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let url = documents.appendingPathComponent("profilePicture1.jpg")
            do{
                try data.write(to: url)
                UserDefaults.standard.set(url.path, forKey: "ProfilePicturePath")
            }
            catch (let err){
                print(err)
            }
            
        }
    }

}


extension AddUserViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else{return}
        ImageViewProfilePic.image = image
//        save(img: image)
        picker.dismiss(animated: true,completion: nil)
                
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true,completion: nil)
    }
    
}
