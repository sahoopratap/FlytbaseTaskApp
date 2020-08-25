//
//  LoginViewController.swift
//  FlytbaseTaskApp
//
//  Created by Suchiprava Sahoo on 24/08/20.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    ///UI reference
    @IBOutlet var outerView: UIView!
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldPassword: UITextField!
 
    //MARK: View DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
      //  navigationController?.setNavigationBarHidden(true, animated: true)
        designAfterStoryboard()
    }
    
    ///Set for design the login screen
   fileprivate func designAfterStoryboard() {
        outerView.layer.cornerRadius = 10
        outerView.layer.masksToBounds = true
        outerView.layer.borderColor = UIColor.gray.cgColor
        outerView.layer.borderWidth = 2.0
    }
    
    ///Login button action
    @IBAction func login(_ sender: Any) {
        if validation() {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let calcul = story.instantiateViewController(identifier: "ViewController" ) as! ViewController
        self.navigationController?.pushViewController(calcul, animated: true)
        }
    }
    
    ///Check for validation
       fileprivate func validation() -> Bool{
           guard let email = txtFldEmail.text?.trimmingCharacters(in: .whitespaces), email.count != 0 else {
            self.showAlertView(title: "Please enter your email address", message: "", preferredStyle: .alert, okLabel: "OK", targetViewController: self) { (action) in
            }
              return false
           }
           if !self.isValidEmail(testStr: email){
            self.showAlertView(title: "Please enter an valid email address", message: "", preferredStyle: .alert, okLabel: "OK", targetViewController: self) { (action) in
            }
               return false
           }
           guard let password = txtFldPassword.text?.trimmingCharacters(in: .whitespaces), password.count != 0 else {
            self.showAlertView(title: "Please enter your password", message: "", preferredStyle: .alert, okLabel: "OK", targetViewController: self) { (action) in
            }
               return false
           }
           return true
       }
    
    ///Set the email validation
    fileprivate func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    ///Set alert view
   fileprivate func showAlertView(title alerTitle:String ,message alertMessage:String, preferredStyle style:UIAlertController.Style, okLabel: String,  targetViewController: UIViewController,okHandler: ((UIAlertAction?) -> Void)!){
           
           let alertController = UIAlertController(title: alerTitle, message: alertMessage, preferredStyle: style)
           let okAction = UIAlertAction(title: okLabel, style: .default, handler: okHandler)
           
           // Add Actions
           alertController.addAction(okAction)
           
           // Present Alert Controller
           targetViewController.present(alertController, animated: true, completion: nil)
       }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

//MARK: TextField Delegate methods
extension LoginViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
