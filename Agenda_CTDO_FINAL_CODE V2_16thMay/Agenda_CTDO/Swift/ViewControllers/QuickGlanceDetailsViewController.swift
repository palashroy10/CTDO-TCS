//
//  QuickGlanceDetailsViewController.swift
//  Agenda_CTDO
//
//  Created by Palash Roy on 1/20/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class QuickGlanceDetailsViewController: UIViewController {

    var personPDFName = ""
    var titleLabelString = ""
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quickGlanceDescription: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = titleLabelString
        let itineraryPdf = personPDFName
        let path = Bundle.main.path(forResource: itineraryPdf, ofType: nil)
        
        if path != nil {
            let targetURL = URL(fileURLWithPath: path ?? "")
            let req = NSURLRequest(url: targetURL)
            quickGlanceDescription.loadRequest(req as URLRequest)
        }
    }
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    
}
