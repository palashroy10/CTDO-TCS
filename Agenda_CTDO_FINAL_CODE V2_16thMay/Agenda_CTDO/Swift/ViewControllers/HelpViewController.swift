//
//  HelpViewController.swift
//  Agenda_CTDO
//
//  Created by Palash Roy on 1/10/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var tcsNamesArray: [String] = [String]()
    private var ibmNamesArray: [String] = [String]()
    private var hclNamesArray: [String] = [String]()
    private var tcsMobNumArray: [String] = [String]()
    private var ibmMobNumArray: [String] = [String]()
    private var hclMobNumArray: [String] = [String]()
    private var personDetailsArray: [String] = [String]()
    private var personMobileNumArray: [Any] = []
    @IBOutlet private weak var helpTableView: UITableView!
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    
    @IBAction private func helpSegmentBarAction(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            personDetailsArray = tcsNamesArray
            personMobileNumArray = tcsMobNumArray
        case 1:
            personDetailsArray = ibmNamesArray
            personMobileNumArray = ibmMobNumArray
        case 2:
            personDetailsArray = hclNamesArray
            personMobileNumArray = hclMobNumArray
        default:
            break
        }
        helpTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tcsNamesArray = ["Los Angeles", "Phoenix", "Santa Clara", "Denver", "Dallas", "San Antonio", "Guadalajara", "Queretaro", "Mexico City"]
        ibmNamesArray = ["Girish Ratnam", "Vikram Tare", "Anand Nair"]
        hclNamesArray = ["Rajesh Srivastava", "Seshagiri Vardhanapu", "Aiyappan Sundarraj"]
        tcsMobNumArray = ["Byju Kollon", "Shantaram", "Rakesh Kumar", "Pushkar Bharadwaj", "Ajit Mishra", "Shital Samant", "", "", "Ashul"]
        ibmMobNumArray = ["+(91) 9176071235", "+(91) 8888816978", "+1 (210) 540-6791"]
        hclMobNumArray = ["+1 (214) 531-8956", "+1 (973) 652-7098", "+1 (210) 551-1543"]
        
        segmentControl.selectedSegmentIndex = 0
        helpSegmentBarAction(segmentControl)
    }
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personDetailsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HelpTableViewCellIdentifier", for: indexPath) as? HelpTableViewCell
        cell?.nameLabel.text = personDetailsArray[indexPath.row]
        cell?.mobileNumLabel.text = (personMobileNumArray[indexPath.row] as! String)
        cell?.callBtn.tag = indexPath.row
        return cell!
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func callOperation(_ sender: Any) {
        performCallOperation(sender as? UIButton)
    }
    
    func performCallOperation(_ sender: UIButton?) {
        
        var contactNo = ""
        
        if segmentControl.selectedSegmentIndex == 0 {
            switch sender?.tag {
            case 0?:
                contactNo = "dummy"
            case 1?:
                contactNo = "dummy"
            case 2?:
                contactNo = "dummy"
            case 3?:
                contactNo = "dummy"
            case 4?:
                contactNo = "15135057517"
            case 5?:
                contactNo = "12106249179"
            case 6?:
                contactNo = "dummy"
            case 7?:
                contactNo = "dummy"
            case 8?:
                contactNo = "dummy"
            default:
                break
            }
        } else if segmentControl.selectedSegmentIndex == 1 {
            switch sender?.tag {
            case 0?:
                contactNo = "919176071235"
            case 1?:
                contactNo = "918888816978"
            case 2?:
                contactNo = "12105406791"
            default:
                break
            }
        } else if segmentControl.selectedSegmentIndex == 2 {
            switch sender?.tag {
            case 0?:
                contactNo = "12145318956"
            case 1?:
                contactNo = "19736527098"
            case 2?:
                contactNo = "12105511543"
            default:
                break
            }
        }
        let telNo = "telprompt:\(contactNo)"
        if let url = URL(string: telNo) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
        }
    }
}

