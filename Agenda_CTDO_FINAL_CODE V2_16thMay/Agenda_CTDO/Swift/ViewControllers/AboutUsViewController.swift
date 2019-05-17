//
//  AboutUsViewController.swift
//  Agenda_CTDO
//
//  Created by Palash Roy on 1/9/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var titlesArray: [String] = [String]()
    private var descArray: [String] = [String]()
    private var imagesArray: [UIImage] = [UIImage]()
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    
    @IBAction private func downloadBtnAction(_ sender: Any) {
    }
    
    @IBAction private func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func segmentBarAction(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        titlesArray = ["About TATA", "About TCS"] //TCS Pune, TCS Mexico, TCS Cincinnati(New PDF), "USAA TCS operating locations"
        
        imagesArray = [UIImage(named: "TATA.png"), UIImage(named: "TATA.png")] as! [UIImage]//, UIImage(named: "TATA.png")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AboutUSCellIdentifier", for: indexPath) as? AboutUsTableViewCell
        
        // Configure the cell...
        cell?.cellImgVw.image = imagesArray[indexPath.row]
        cell?.titleLabel.text = titlesArray[indexPath.row]
        
        return cell!
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        let aboutUsDetailsVC = storyboard!.instantiateViewController(withIdentifier: "AboutUSDetailViewController") as? AboutUSDetailViewController
        aboutUsDetailsVC?.selectedIndex = indexPath.row
        if let aboutUsDetailsVC = aboutUsDetailsVC {
            navigationController?.pushViewController(aboutUsDetailsVC, animated: true)
        }
    }
    
    
}
