//
//  AccomDetailsViewController.swift
//  Agenda_CTDO
//
//  Created by Palash Roy on 5/21/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class AccomDetailsViewController: UIViewController {

    @IBOutlet weak var confirmationLabel: UILabel!
    @IBOutlet weak var accomodationDetailsLabel: UILabel!
    
    var accomArr: [String] = [String]()
    var confArr: [String] = [String]()
    public var locindex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        accomArr = ["Embassy Suites by Hilton Los Angeles Glendale, 800 N Central Ave, Glendale, CA 91203, Tel. No : Phone: (818) 550-0828", "Hilton Garden Inn Phoenix North Happy Valley, Address: 1940 W Pinnacle Peak Rd, Phoenix, AZ 85027, Phone: (623) 434-5556", "Courtyard by Marriott San Jose North/Silicon Valley, Address: 111 Holger Way, San Jose, CA 95134, Phone: (408) 383-3700",  "Fairfield Inn & Suites by Marriott Denver Tech Center North, Address: 5071 S Syracuse St, Denver, CO 80237", "Courtyard by Marriott Dallas Northwest, Address: 2930 Forest Ln, Dallas, TX 75234, Phone: (972) 620-8000", "Embassy Suites by Hilton San Antonio NW I-10, Address: 7750 Briaridge Dr, San Antonio, TX 78230, Phone: (210) 340-5421"]
        confArr = ["92075400", "3112571618", "70770480", "70819449", "70806125", "96954025"]
        
        confirmationLabel.text = confArr[locindex]
        accomodationDetailsLabel.text = accomArr[locindex]
        
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
