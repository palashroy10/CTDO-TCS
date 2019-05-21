//
//  AccomodationViewController.swift
//  Agenda_CTDO
//
//  Created by Palash Roy on 5/21/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class AccomodationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var locationNamesArr: [String] = [String]()
    var locationPDFArr: [Any] = []
    var durationArr: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        locationNamesArr = ["Los Angeles", "Phoenix", "San Jose", "Denver", "Dallas", "San Antonio"]//, "Bengaluru", "Noida"
        durationArr = ["26th May - 28th May", "28th May - 30th May", "30th May - 2nd Jun", "2nd Jun - 3rd Jun", "3rd Jun - 5th Jun", "5th Jun - 9th Jun"]
        
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationNamesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCellIdentifier", for: indexPath) as? LocationTableViewCell
        
        // Configure the cell...
        cell?.locationLabel.text = locationNamesArr[indexPath.row]
        cell?.locationDescLabel.text = durationArr[indexPath.row]
        
        return cell!
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let executiveDetailsVC = storyboard!.instantiateViewController(withIdentifier: "AccomDetailsViewController") as? AccomDetailsViewController
        executiveDetailsVC?.locindex = indexPath.row
//        executiveDetailsVC?.locationPDFName = locationPDFArr[indexPath.row] as! String
//        executiveDetailsVC?.locationName = locationNamesArr[indexPath.row]
        if let executiveDetailsVC = executiveDetailsVC {
            navigationController?.pushViewController(executiveDetailsVC, animated: true)
        }
    }

}
