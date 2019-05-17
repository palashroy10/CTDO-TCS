//
//  QuickGlanceViewController.swift
//  Agenda_CTDO
//
//  Created by Palash Roy on 1/10/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class QuickGlanceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBAction private func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet private weak var quickGlanceWebVw: UIWebView!
    private var peopleArray: [AnyHashable] = []
    private var peopleImageArray: [AnyHashable] = []
    private var itinerayArray: [AnyHashable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        peopleArray = ["CSR Activity", "Townhalls", "TCS Adibatla Inauguration"]
        peopleImageArray = ["csr.png", "townhall.png", "inauguration.png"]
        itinerayArray = ["QuickGlanceCSR.pdf", "QuickGlanceTownhall.pdf", "QuickGlanceInauguration.pdf"]
        
//            if let pdf = Bundle.main.url(forResource: "QuickGlance", withExtension: "pdf", subdirectory: nil, localization: nil)  {
//                let req = URLRequest(url: pdf)
//                //            yourWebViewOutletName.loadRequest(req as URLRequest)
//                    //quickGlanceWebVw.loadRequest(req)
//                
//            }
        
    }
    
    
    /*
     #pragma mark - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuickGlanceTableViewCellIdentifier", for: indexPath) as? QuickGlanceTableViewCell
        
        // Configure the cell...
        cell?.titleLabel.text = (peopleArray[indexPath.row] as! String)
        cell?.cellImgVw.image = UIImage(named: peopleImageArray[indexPath.row] as? String ?? "")
        
        
        return cell!
    }
    
    // MARK: - Table view delegate
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        tableView.deselectRow(at: indexPath, animated: false)
        let quickGlanceDetailsVC = storyboard!.instantiateViewController(withIdentifier: "QuickGlanceDetailsViewController") as? QuickGlanceDetailsViewController
        quickGlanceDetailsVC?.personPDFName = itinerayArray[indexPath.row] as! String
        quickGlanceDetailsVC?.titleLabelString = peopleArray[indexPath.row] as! String
        if let quickGlanceDetailsVC = quickGlanceDetailsVC {
            navigationController?.pushViewController(quickGlanceDetailsVC, animated: true)
        }
        
    }
}
