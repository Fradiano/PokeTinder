//
//  ViewController.swift
//  GestureCardSwipe
//
//  Created by Fradiano Hasani on 05.01.23.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var username = "Ash"
    var password = "111"
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self
        nameField.keyboardType = .emailAddress
        pwField.textContentType = .password
        pwField.keyboardType = .numbersAndPunctuation
       
        dismissKeyboard()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case nameField:
            pwField.becomeFirstResponder()
        default:
            view.endEditing(true)
        }
        return true
    }
    
    @objc func donePressed(){
        pwField.becomeFirstResponder()
    }
    
    @objc func dismissOnTapOutside(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func dismissKeyboard(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(touchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func touchOutside(){
        view.endEditing(true)
    }
    
    
    func loginfunc(){
        if nameField.text != username || pwField.text != password{
            let alert = UIAlertController(title: "Falsche Log-in Daten", message: "try something else or register", preferredStyle: .alert)
            
            self.present(alert, animated:  true, completion:{
                
                alert.view.superview?.isUserInteractionEnabled = true
                alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
            })
        }else{
            self.loginBtn.setTitle("catch 'em all!", for: .normal)
        }
    }
    
    @IBAction func login(){
        loginfunc()
    }
    
}

