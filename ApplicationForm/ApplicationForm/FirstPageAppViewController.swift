//
//  FirstPageAppViewController.swift
//  ApplicationForm
//
//  Created by Bharath on 06/05/24.
//

import UIKit

class FirstPageAppViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var FemaleBtn: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var CollegeNameTextField: UITextField!
    @IBOutlet weak var DobTextField: UITextField!
    @IBOutlet weak var MaleBtn: UIButton!
    @IBOutlet weak var NativeTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var CgpaTextField: UITextField!
    @IBOutlet weak var YearOfPassedOuttextField: UITextField!
    @IBOutlet weak var StreamOfStudyTextField: UITextField!
    @IBOutlet weak var MobileNoTextField: UITextField!
    
    @IBOutlet weak var viewContent: UIView!
    var checkBoxunchecked = UIImage(named: "unchecked.png")
    var checkBoxChecked = UIImage(named: "approved.png")
    var initialCB:Bool = true
    let date = UIDatePicker()
    @IBOutlet weak var TermsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createDatePicker()
        nameTextField.delegate = self
        CollegeNameTextField.delegate = self
        DobTextField.delegate = self
        NativeTextField.delegate = self
        MobileNoTextField.delegate = self
        StreamOfStudyTextField.delegate = self
        YearOfPassedOuttextField.delegate = self
        CgpaTextField.delegate = self
        emailTextField.delegate = self
        
        emailTextField.keyboardType = .emailAddress
        MobileNoTextField.keyboardType = .numberPad
        YearOfPassedOuttextField.keyboardType = .numberPad
        CgpaTextField.keyboardType = .decimalPad
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardWhentapped))
        
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)

        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
          
            CollegeNameTextField.becomeFirstResponder()
        } else if textField == CollegeNameTextField {
            DobTextField.becomeFirstResponder()
        } else if textField == DobTextField {
           
            NativeTextField.becomeFirstResponder()
        } else if textField == NativeTextField {
            
            MobileNoTextField.becomeFirstResponder()
        }
        else if textField == StreamOfStudyTextField{
            YearOfPassedOuttextField.becomeFirstResponder()
        }
        else if textField == MobileNoTextField{
            StreamOfStudyTextField.becomeFirstResponder()
        }
        else if textField == YearOfPassedOuttextField{
            CgpaTextField.becomeFirstResponder()
        }
        else if textField == CgpaTextField{
            emailTextField.becomeFirstResponder()
        }
        
        
        else if textField == emailTextField {
            textField.resignFirstResponder()
            CgpaTextField.becomeFirstResponder()
        }
        return true
    }

    @IBAction func FemaleBtn(_ sender: Any) {
        
        FemaleBtn.setImage(UIImage(named: "radioon1.png"), for: .normal)
        MaleBtn.setImage(UIImage(named: "radiooff1.png"), for: .normal)
    }
    
    @IBAction func MaleBtn(_ sender: Any) {
        MaleBtn.setImage(UIImage(named: "radioon1.png"), for: .normal)
        FemaleBtn.setImage(UIImage(named: "radiooff1.png"), for: .normal)
    }
    
    func createDone() -> UIToolbar{
        //create tool bar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        //done btn
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolBar.setItems([doneBtn], animated: true)
        return toolBar
    }

    @IBAction func TermsBtn(_ sender: Any) {
        initialCB.toggle()
        if initialCB{
            TermsButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
        else{
            TermsButton.setImage(UIImage(named: "approved"), for: .normal)
        }
    }
    
    func createDatePicker(){
        if #available(iOS 13.4, *) {
            date.preferredDatePickerStyle = .wheels
        }
        date.datePickerMode = .date
        DobTextField.inputView = date
        DobTextField.inputAccessoryView = createDone()
        
        
    }
    
 @objc func donePressed(){
     let dateFormat = DateFormatter()
     dateFormat.dateStyle = .medium
    // dateFormat.dateFormat = "d.M.yyyy"
     
     dateFormat.timeStyle = .none
     self.DobTextField.text = dateFormat.string(from: date.date)
    // self.view.endEditing(true)
     NativeTextField.becomeFirstResponder()
        
     
    }
    
    @objc func dismissKeyboardWhentapped() {
        self.view.endEditing(true)
    }
    
    
    @IBAction func ButtonSubmit(_ sender: Any) {
        
        if nameTextField.text != ""{
            
        }
    }
    
    func validateTextField(){
        
    }
    
//    func passwordValidator(textfield:UITextField) -> Bool
//    {
//       // var password = textfield.text
//        if textfield.text == ""
// {
//            textfield.layer.borderColor = UIColor.red.cgColor
//            self.PasswordErrorFieldLabel.text = "password cannot be empty"
//
//            return false
//        }
//        else{
//            return true
//        }
//    }
    
    
}
