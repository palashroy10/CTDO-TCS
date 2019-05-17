//
//  RelationsViewController.swift
//  Agenda_CTDO
//
//  Created by Palash Roy on 1/10/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class RelationsViewController: UIViewController {

    @IBOutlet private weak var relationsWebView: UIWebView!
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        segmentControl.selectedSegmentIndex = 0
        segmentBarAction(segmentControl)
    }
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func segmentBarAction(_ sender: UISegmentedControl) {
        var pdfName = ""
        switch sender.selectedSegmentIndex {
        case 0:
            pdfName = Bundle.main.path(forResource: "TCS_USAA_Relationship", ofType: "pdf") ?? ""
            if pdfName != "" {
                let targetURL = URL(fileURLWithPath: pdfName)
                let req = NSURLRequest(url: targetURL)
                relationsWebView.loadRequest(req as URLRequest)
            }
        case 1:
            pdfName = Bundle.main.path(forResource: "Purpose4Life_Mobile", ofType: "pdf") ?? ""
            if pdfName != "" {
                let targetURL = URL(fileURLWithPath: pdfName)
                let req = NSURLRequest(url: targetURL)
                    relationsWebView.loadRequest(req as URLRequest)
            }
        default:
            break
        }
    }
    
}
