//
//  ItineraryDetailsViewController.swift
//  Agenda_CTDO
//
//  Created by Palash Roy on 1/10/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class ItineraryDetailsViewController: UIViewController {
    
    var personPDFName = ""
    var selectedIndex: Int = 0
    var pfImageName = ""
    var pName = ""
    var pDesignation = ""
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personDesignation: UILabel!
    @IBOutlet weak var personDescription: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //profileImage.image = UIImage(named: pfImageName)
        personName.text = pName
        personDesignation.text = pDesignation
        let itineraryPdf = personPDFName
        let path = Bundle.main.path(forResource: itineraryPdf, ofType: nil)
        
        if path != nil {
            let targetURL = URL(fileURLWithPath: path ?? "")
            let req = NSURLRequest(url: targetURL)
                personDescription.loadRequest(req as URLRequest)
        }
        
    }
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
