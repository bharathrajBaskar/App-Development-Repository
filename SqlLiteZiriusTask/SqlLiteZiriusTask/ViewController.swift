

import UIKit
var DbObjc = Sqlite()

class ViewController: UIViewController {
    
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var ButtonLogin: UIButton!
    @IBOutlet weak var TextFieldPassword: UITextField!
    @IBOutlet weak var TextFieldEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        TextFieldEmailProperties(textField: TextFieldEmail)
        TextFieldEmailProperties(textField: TextFieldPassword)
        ErrorLabel.textColor = UIColor.red
        TextFieldEmail.textColor = UIColor.white
        TextFieldPassword.textColor = UIColor.white
    }
    
    
    
    func TextFieldEmailProperties(textField  :UITextField){
        
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1.0
        let viewRight = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 50, height: TextFieldEmail.frame.size.height))
        let imgRight = UIImageView()
        
        viewRight.addSubview(imgRight)
        imgRight.frame = CGRect(x: 10, y: 10, width: 30.0, height: 30)
        imgRight.contentMode = .scaleAspectFit
        textField.rightView = viewRight
        textField.rightViewMode = .always
        if textField == TextFieldEmail{
            imgRight.image = UIImage(named: "email")
            textField.attributedPlaceholder = NSAttributedString(string: "Email",attributes:[NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        else{
            imgRight.image = UIImage(named: "lock")
            textField.attributedPlaceholder = NSAttributedString(string: "Password",attributes:[NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        
    }
    
    
    
    @IBAction func ButtonLogin(_ sender: Any) {
//        if  checkErrorEmail(emailTextField: TextFieldEmail) && (checkErrorPassword(passwordTextField : TextFieldPassword) != nil){
//
//
//            let email = TextFieldEmail.text
//            let password = TextFieldPassword.text
////            let insertAvalue = DbObjc.insertUser(email: email!, password: password!)
////            if insertAvalue{
////                ErrorLabel.text = "Logined successfully"
////                ErrorLabel.textColor = UIColor.green
////
////            }
////            else{
////                ErrorLabel.text = "Problem in saving the user "
////                ErrorLabel.textColor = UIColor.red
////            }
//            if email == "bharath@gmail.com" && password == "123456789"{
//                ErrorLabel.text = "Logined successfully"
//                ErrorLabel.textColor = UIColor.green
//                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CollectionViewController") as! CollectionViewController
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//            else{
//                ErrorLabel.text = "error in login"
//                ErrorLabel.textColor = UIColor.red
//            }
//    }
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CollectionViewController") as! CollectionViewController
        self.navigationController?.pushViewController(vc, animated: true)
}

    func emailValidator(email :String)-> Bool{
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    
    func checkErrorEmail(emailTextField:UITextField) -> Bool{
        let email = emailTextField.text
        if emailValidator(email: email!){
            TextFieldEmail.layer.borderColor = UIColor.white.cgColor
            ErrorLabel.text = ""
            return true
        }
        else{
            TextFieldEmail.layer.borderColor = UIColor.red.cgColor
            ErrorLabel.text = "Enter the valid Email"
            return false
        }
    }
    
    func checkErrorPassword(passwordTextField :UITextField) -> Bool?{
        let password = passwordTextField.text
        if  password!.count < 9 {
            TextFieldPassword.layer.borderColor = UIColor.red.cgColor
            ErrorLabel.text = "Enter a valid password"
            return false
        }
        else{
            TextFieldPassword.layer.borderColor = UIColor.white.cgColor
            return true
        }
    }
}

