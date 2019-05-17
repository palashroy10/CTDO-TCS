//
//  FeedbackViewController.swift
//  Agenda_CTDO
//
//  Created by Palash Roy on 1/9/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit
import MessageUI

class FeedbackViewController: UIViewController, MFMailComposeViewControllerDelegate, UITextViewDelegate, UITextFieldDelegate {
    var tapRec: UITapGestureRecognizer?

    @IBOutlet private weak var toEmailTextField: UITextField!
    @IBOutlet private weak var contentTextView: UITextView!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var sendButton: UIButton!
    @IBOutlet private weak var containerview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        toEmailTextField.text = "sreehari.pola@tcs.com, Jeromejosephprakash@chennai.tcs.co.in, praveen.panneer@tcs.com,a.lakshman@tcs.com"
        
        contentTextView.delegate = self
        sendButton.layer.cornerRadius = 18.0
        sendButton.layer.borderColor = UIColor.black.cgColor
        sendButton.layer.borderWidth = 0.5
        
        contentTextView.layer.borderWidth = 0.5
        contentTextView.layer.borderColor = UIColor.gray.cgColor
        contentTextView.layer.cornerRadius = 5.0
        
        nameTextField.layer.borderWidth = 0.5
        nameTextField.layer.borderColor = UIColor.gray.cgColor
        nameTextField.layer.cornerRadius = 20.0
        
        toEmailTextField.layer.cornerRadius = 20.0
        
        let ViewForDoneButtonOnKeyboard = UIToolbar()
        ViewForDoneButtonOnKeyboard.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let btnDoneOnKeyboard = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(FeedbackViewController.doneBtn(fromKeyboardClicked:)))
        ViewForDoneButtonOnKeyboard.items = [flexBarButton, btnDoneOnKeyboard]
        
        contentTextView.inputAccessoryView = ViewForDoneButtonOnKeyboard
    }
    
    @objc func doneBtn(fromKeyboardClicked sender: Any?) {
        //Hide Keyboard by endEditing or Anything you want.
        view.endEditing(true)
    }
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    /*
     #pragma mark - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func sendMail(_ sender: Any) {
        
        //make email as email keyboard
        if !isValidEmail(toEmailTextField.text) {
            let alert = UIAlertController(title: "Email!", message: "Please enter valid email", preferredStyle: .alert)
            present(alert, animated: true)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
                print("You pressed button OK")
            }) //
            alert.addAction(defaultAction)
            return
        } else if (nameTextField.text?.count ?? 0) == 0 {
            let alert = UIAlertController(title: "Name!", message: "Please enter your name", preferredStyle: .alert)
            present(alert, animated: true)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
                print("You pressed button OK")
            }) //
            alert.addAction(defaultAction)
            return
        }
        
        let controller = MFMailComposeViewController()
        controller.mailComposeDelegate = self
        controller.setToRecipients([toEmailTextField.text!])
        controller.setSubject("\(nameTextField.text ?? "")'s feedback")
        controller.setMessageBody(contentTextView.text, isHTML: true)
        
        //if controller
        
        if MFMailComposeViewController.canSendMail() {
            present(controller, animated: true)
        } else {
            self.showSendMailErrorAlert()
        }
        
    }
    
    func isValidEmail(_ checkString: String?) -> Bool {
        let stricterFilter = false // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
        let stricterFilterString = "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$"
        let laxString = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        let emailRegex = stricterFilter ? stricterFilterString : laxString
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: checkString)
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .alert)
        
        sendMailErrorAlert.show(self, sender: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if result == .sent {
            print("It's away!")
        }
        dismiss(animated: true)
    }
    
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        let touch = touches.first as? UITouch
        
        if contentTextView.isFirstResponder && touch?.view != contentTextView {
            print("The textView is currently being edited, and the user touched outside the text view")
            contentTextView.resignFirstResponder()
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if (textView.text == "Your thoughts") {
            textView.text = ""
        }
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if (textView.text == "") {
            textView.text = "Your thoughts"
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == nameTextField {
            animate(textField, up: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameTextField {
            animate(textField, up: false)
        }
    }
    
    func animate(_ textField: UITextField?, up: Bool) {
        var animatedDistance: Int
        let moveUpValue = Int((textField?.frame.origin.y ?? 0.0) + (textField?.frame.size.height ?? 0.0))
        let orientation: UIInterfaceOrientation = UIApplication.shared.statusBarOrientation
        if orientation == .portrait || orientation == .portraitUpsideDown {
            animatedDistance = 236 - (460 - moveUpValue - 5)
        } else {
            animatedDistance = 182 - (320 - moveUpValue - 5)
        }
        
        if animatedDistance > 0 {
            let movementDistance: Int = animatedDistance
            let movementDuration: Float = 0.3
            let movement: Int = up ? -movementDistance : movementDistance
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationBeginsFromCurrentState(true)
            UIView.setAnimationDuration(TimeInterval(movementDuration))
            view.frame = view.frame.offsetBy(dx: 0, dy: CGFloat(movement))
            UIView.commitAnimations()
        }
    }
}
