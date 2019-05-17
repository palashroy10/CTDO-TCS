//
//  LocationDetailsViewController.swift
//  Agenda_CTDO
//
//  Created by Palash Roy on 1/10/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class LocationDetailsViewController: UIViewController {

    var locationPDFName = ""
    var locationName = ""
    @IBOutlet weak var locationDescription: UIWebView!
    @IBOutlet weak var locatioNameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locatioNameLbl.text = locationName
        
        let path = Bundle.main.path(forResource: locationPDFName, ofType: nil)
        
        if path != nil {
            let targetURL = URL(fileURLWithPath: path ?? "")
            let req = NSURLRequest(url: targetURL)
            locationDescription.loadRequest(req as URLRequest)
        }
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
