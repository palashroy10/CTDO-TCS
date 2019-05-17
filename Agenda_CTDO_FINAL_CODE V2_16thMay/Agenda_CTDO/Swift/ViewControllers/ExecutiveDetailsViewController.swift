//
//  ExecutiveDetailsViewController.swift
//  Agenda_CTDO
//
//  Created by Palash Roy on 1/10/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit
var pinchGestureRecognizer: UIPinchGestureRecognizer?
class ExecutiveDetailsViewController: UIViewController, UIGestureRecognizerDelegate {
    var person: Person?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let person = person {
            profileImage.image = UIImage(named: person.largeImg)
        personName.text = person.name
        personDesignation.text = person.designation
            personDescription.text = person.desc
        personDescription.contentOffset = CGPoint.zero
        personDescription.scrollRangeToVisible(NSRange(location: 0, length: 0))
        
        pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(ExecutiveDetailsViewController.pinchGesture(_:)))
        pinchGestureRecognizer?.delegate = self
        if let pinchGestureRecognizer = pinchGestureRecognizer {
            personDescription.addGestureRecognizer(pinchGestureRecognizer)
        }
        }
    }
    
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var personName: UILabel!
    @IBOutlet private weak var personDesignation: UILabel!
    @IBOutlet private weak var personDescription: UITextView!
    
    @IBAction private func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func pinchGesture(_ gestureRecognizer: UIPinchGestureRecognizer?) {
        let font: UIFont? = personDescription.font
        var pointSize: CGFloat? = font?.pointSize
        let fontName = font?.fontName
        
        pointSize = (((gestureRecognizer?.velocity ?? 0.0) > 0) ? 1 : -1) * 1 + (pointSize ?? 0.0)
        
        if (pointSize ?? 0.0) < 13 {
            pointSize = 13
        }
        if (pointSize ?? 0.0) > 42 {
            pointSize = 42
        }
        
        personDescription.font = UIFont(name: fontName ?? "", size: pointSize ?? 0.0)
    }
    
}
