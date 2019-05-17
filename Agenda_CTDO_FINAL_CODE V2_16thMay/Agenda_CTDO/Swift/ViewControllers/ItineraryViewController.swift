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
        
        peopleArray = ["James Syring ", "Paul Miller", "Imogene Goodman"]
        peopleImageArray = ["James.png", "Paul.png", "Imogene.png"]
        itinerayArray = ["Itinerary_MILLER_PAUL_EKAIBY.pdf", "Itinerary_MILLER_PAUL_EKAIBY.pdf", "Itinerary_MILLER_PAUL_EKAIBY.pdf"]
        peopleDesignationArray = ["SVP, Enterprise Operations Support", "Director Global Service Delivery", "Enterprise Event Planner"]
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
        cell?.titleLabel.text = peopleArray[indexPath.row] as! String
        cell?.cellImgVw.image = UIImage(named: peopleImageArray[indexPath.row] as? String ?? "")
        
        
        return cell!
    }
    
    // MARK: - Table view delegate
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        tableView.deselectRow(at: indexPath, animated: false)
        let executiveDetailsVC = storyboard!.instantiateViewController(withIdentifier: "ItineraryDetailsViewController") as? ItineraryDetailsViewController
        executiveDetailsVC?.personPDFName = itinerayArray[indexPath.row] as! String
        executiveDetailsVC?.pfImageName = peopleImageArray[indexPath.row] as! String
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

