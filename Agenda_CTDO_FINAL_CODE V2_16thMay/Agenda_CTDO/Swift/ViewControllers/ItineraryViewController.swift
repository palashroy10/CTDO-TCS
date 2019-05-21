//
//  ItineraryViewController.swift
//  Agenda_CTDO
//
//  Created by Palash Roy on 1/10/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class ItineraryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var peopleArray: [AnyHashable] = []
    private var peopleImageArray: [AnyHashable] = []
    private var peopleDesignationArray: [AnyHashable] = []
    private var itinerayArray: [AnyHashable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        peopleArray = ["BOM - FRA ", "LAX - PHX", "PHX - SJC", "SFO - DEN", "SAT - GDL", "GDL - QRO"]
        //peopleImageArray = ["James.png", "Paul.png", "Imogene.png"]
        itinerayArray = ["JOHNSINDHU SAJI 26MAY2019 BOM FRA.pdf", "JOHNSINDHU SAJI 28MAY2019 LAX PHX.pdf", "JOHNSINDHU SAJI 30MAY2019 PHX SJC.pdf", "JOHNSINDHU SAJI 02JUN2019 SFO DEN.pdf", "JOHNSINDHU SAJI 09JUN2019 SAT GDL.pdf", "SINDHU SAJI JOHN 110619.pdf"]
        peopleDesignationArray = ["26th May, 2019", "28th May, 2019", "30th May, 2019", "02nd June, 2019", "09th June, 2019", "11th June, 2019"]
    }
    
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItineraryViewCellIdentifier", for: indexPath) as? ItineraryTableViewCell
        
        // Configure the cell...
        cell?.titleLabel.text = peopleArray[indexPath.row] as? String
        //cell?.cellImgVw.image = UIImage(named: peopleImageArray[indexPath.row] as? String ?? "")
        cell?.titleDescLabel.text = peopleDesignationArray[indexPath.row] as? String
        
        
        return cell!
    }
    
    // MARK: - Table view delegate
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        tableView.deselectRow(at: indexPath, animated: false)
        let executiveDetailsVC = storyboard!.instantiateViewController(withIdentifier: "ItineraryDetailsViewController") as? ItineraryDetailsViewController
        executiveDetailsVC?.personPDFName = itinerayArray[indexPath.row] as! String
        //executiveDetailsVC?.pfImageName = peopleImageArray[indexPath.row] as! String
        executiveDetailsVC?.pName = peopleArray[indexPath.row] as! String
        executiveDetailsVC?.pDesignation = peopleDesignationArray[indexPath.row] as! String
        if let executiveDetailsVC = executiveDetailsVC {
            navigationController?.pushViewController(executiveDetailsVC, animated: true)
        }
        
    }
    
    /*
     #pragma mark - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

