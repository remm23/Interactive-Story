//
//  ViewController.swift
//  InteractiveStory
//
//  Created by Remi Tobias on 18/09/2017.
//  Copyright © 2017 Remi Tobias. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var textFieldBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: Notification.Name.UIKeyboardDidHide, object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //startAdventure
        if segue.identifier == "startAdventure" {
            
            do {
                if let name = nameTextField.text {
                    if name == "" {
                        throw AdventureError.nameNotProvided
                    } else {
                        guard let pageController = segue.destination as? PageController else{
                            return
                        }
                        pageController.page = Adventure.story(withName: name)
                    }
                }
            }catch AdventureError.nameNotProvided {
                let alertController = UIAlertController(title: "Name Not Provided", message: "Provide a name to start th story", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(action)
                present(alertController, animated: true, completion: nil)
            } catch let err {
                fatalError("\(err.localizedDescription)")
            }
        }
    }
    
    func keyboardWillShow(_ notification: Notification) {
        if let info = notification.userInfo, let keyboardFrame = info[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let frame = keyboardFrame.cgRectValue // convert from NSValue to CGRect
            // Extends the cinstraint by the keyboard height
            textFieldBottomConstraint.constant = frame.size.height + 10
            
            UIView.animate(withDuration: 0.8) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        textFieldBottomConstraint.constant = 40
            
        UIView.animate(withDuration: 0.8) {
            self.view.layoutIfNeeded()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss the keyboard
        return true
    }
}























