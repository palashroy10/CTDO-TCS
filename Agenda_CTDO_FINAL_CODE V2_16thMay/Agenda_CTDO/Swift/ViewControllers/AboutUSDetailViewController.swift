//
//  AboutUSDetailViewController.swift
//  Agenda_CTDO
//
//  Created by Palash Roy on 1/9/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class AboutUSDetailViewController: UIViewController {

    var companyNamePDF = ""
    var selectedIndex: Int = 0
    @IBOutlet private weak var aboutUsDescription: UIWebView!
    @IBOutlet private weak var companyNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedIndex == 1 {
            companyNameLabel.text = "About TCS"
        }
        
        switch selectedIndex {
        case 0:
            companyNamePDF = "TATA.pdf"
            companyNameLabel.text = "About TATA"
        case 1:
            companyNamePDF = "TCS.pdf"
            companyNameLabel.text = "About TCS"
        case 2:
            companyNamePDF = "USAATCSLocations.pdf"
            companyNameLabel.text = "USAA_TCS Locations"
        default:
            break
        }
        
        // Do any additional setup after loading the view.
        let itineraryPdf = companyNamePDF
        
        let path = Bundle.main.resourcePath! + "/" + itineraryPdf
        print(path)
        
        let pdf = URL(string: path)
            let req = NSURLRequest(url: pdf!)
//            yourWebViewOutletName.loadRequest(req as URLRequest)
            aboutUsDescription.loadRequest(req as URLRequest)
        
    }
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
