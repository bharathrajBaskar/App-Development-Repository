//
//  UpdateViewController.swift
//  SqlLiteZiriusTask
//
//  Created by Bharath on 31/05/24.
//
protocol UpdateViewControllerDelegate: AnyObject {
    func didUpdateUser(updatedUser: [String: String])
}

import UIKit

class UpdateViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    var arrayOfDict:[String:String] = [:]
    weak var delegate: UpdateViewControllerDelegate?

    @IBOutlet weak var TextFieldName: UITextField!
    @IBOutlet weak var TextFieldPhoneNo: UITextField!
    @IBOutlet weak var ProfilePicImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setValues(Dict: arrayOfDict)
    
    }
    

    @IBAction func ButtonChangeImage(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc,animated: true)
    }
    

    @IBAction func ButtonSave(_ sender: Any) {
        guard let newName = TextFieldName.text, !newName.isEmpty,
                    let newPhoneNo = TextFieldPhoneNo.text, !newPhoneNo.isEmpty,
                    let email = arrayOfDict["email"] else {
                  print("Error: Name, phone number, or email is invalid")
                  return
              }
              
              let imgPath = saveImageToDocumentsDirectory(image: ProfilePicImageView.image!)
              
              guard let imagePath = imgPath else {
                  print("Error saving image")
                  return
              }
              
              let success = dbTable.updateUserDetails(email: email, newName: newName, newPhoneNo: newPhoneNo, newImagePath: imagePath)
              
              if success {
                  arrayOfDict["name"] = newName
                  arrayOfDict["phone_no"] = newPhoneNo
                  arrayOfDict["image"] = imagePath
                  delegate?.didUpdateUser(updatedUser: arrayOfDict)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotifyForFetch), object: nil)
                  self.navigationController?.popViewController(animated: true)
                  print("Details updated successfully")
              } else {
                  print("Failed to update details")
              }
    }
    func setValues(Dict:[String:String]){
        TextFieldName.text = Dict["name"]
        TextFieldPhoneNo.text = Dict["phone_no"]
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
                    print(image!)
                    self.ProfilePicImageView.image = image
                }
            }

        }
        
    }
    func saveImageToDocumentsDirectory(image: UIImage) -> String? {
            guard let data = image.jpegData(compressionQuality: 1.0) ?? image.pngData() else {
                return nil
            }
            let timestamp = Int(Date().timeIntervalSince1970)
            let imageName = "updated_\(timestamp).png"
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
        
   
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let editedImage = info[.editedImage] as? UIImage {
                ProfilePicImageView.image = editedImage
            } else if let originalImage = info[.originalImage] as? UIImage {
                ProfilePicImageView.image = originalImage
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    
}
