//
//  LocationsViewController.swift
//  Agenda_CTDO
//
//  Created by Palash Roy on 1/10/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class LocationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var locationNamesArr: [String] = [String]()
    var locationPDFArr: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        locationNamesArr = ["Los Angeles", "Phoenix", "Santa Clara", "Denver", "Dallas", "San Antonio", "Guadalajara", "Queretaro", "Mexico City"]//, "Bengaluru", "Noida"
        locationPDFArr = ["los angeles.pdf", "Phoenix_PDF_Exported_01.pdf", "Santa Clara.pdf", "Denver.pdf", "dallas.pdf", "San Antonio.pdf", "Gudaljara.pdf", "Queretaro.pdf", "MexicanCity.pdf"]//"Bengaluru.pdf", "Noida.pdf"
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
        
        return cell!
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let executiveDetailsVC = storyboard!.instantiateViewController(withIdentifier: "LocationDetailsViewController") as? LocationDetailsViewController
        executiveDetailsVC?.locationPDFName = locationPDFArr[indexPath.row] as! String
        executiveDetailsVC?.locationName = locationNamesArr[indexPath.row]
        if let executiveDetailsVC = executiveDetailsVC {
            navigationController?.pushViewController(executiveDetailsVC, animated: true)
        }
    }

}
