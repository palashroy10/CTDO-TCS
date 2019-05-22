//
//  DashboardViewController.swift
//  Agenda_CTDO
//
//  Created by Palash Roy on 1/8/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

@available(iOS 12.0, *)
class DashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var selectedIndexPath: IndexPath?
    
    @IBOutlet private weak var dashboardTV: UITableView!
    private var titlesArray: [Any] = []
    private var descArray: [Any] = []
    private var imagesArray: [UIImage]? = [UIImage]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        if selectedIndexPath != nil {
            if let selectedIndexPath = selectedIndexPath {
                dashboardTV.deselectRow(at: selectedIndexPath, animated: false)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.isHidden = true
        
        titlesArray = ["Schedule", "Itinerary", "Accomodation", "Locations", ]//Encumberence//"About Us","Executive","Feedback", "Relationship"
        descArray = ["List of agenda items", "Travel documents", "US Accomodation details", "Visit locations details and culture"]//"Travel documents ", "USAA and TCS executives profile","Overview of TATA & TCS, its businesses, values and commitments",  "USAA-TCS relationship details"
        imagesArray = [UIImage(named: "alarmClock.png"), UIImage(named: "Itinerary.png"), UIImage(named: "hotel.png"), UIImage(named: "Location.png")] as? [UIImage]//, UIImage(named: "AboutUs.png"), UIImage(named: "Executive.png"),, UIImage(named: "Feedback.png"), UIImage(named: "relationship.png"), UIImage(named: "translate")
        
        //4th place for itin
    }
    
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardCellIdentifier", for: indexPath) as? DashboardTableViewCell
        
        // Configure the cell...
        cell?.cellImgVw.image = imagesArray![indexPath.row] as? UIImage
        cell?.titleLabel.text = titlesArray[indexPath.row] as? String
        cell?.titleDescLabel.text = descArray[indexPath.row] as? String
        
        return cell!
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        selectedIndexPath = indexPath
        switch indexPath.row {
        case 0:
            let scheduleVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScheduleViewController") as? ScheduleViewController
            
            if let scheduleVC = scheduleVC {
                navigationController?.pushViewController(scheduleVC, animated: true)
            }
//        case 1:
//            let aboutUsVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController
//
//            if let aboutUsVC = aboutUsVC {
//                navigationController?.pushViewController(aboutUsVC, animated: true)
//            }
//        case 2:
//            let executiveVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ExecutiveViewController") as? ExecutiveViewController
//
//            if let executiveVC = executiveVC {
//                navigationController?.pushViewController(executiveVC, animated: true)
//            }
        case 1:
            let itineraryVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ItineraryViewController") as? ItineraryViewController

            if let itineraryVC = itineraryVC {
                navigationController?.pushViewController(itineraryVC, animated: true)
            }
        case 2:
            let accoVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AccomodationViewController") as? AccomodationViewController
            
            if let accoVC = accoVC {
                navigationController?.pushViewController(accoVC, animated: true)
            }
        case 3:
            let locationsVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LocationsViewController") as? LocationsViewController

            if let locationsVC = locationsVC {
                navigationController?.pushViewController(locationsVC, animated: true)
            }
        /*case 3:
            let feedbackVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FeedbackViewController") as? FeedbackViewController
            
            if let feedbackVC = feedbackVC {
                navigationController?.pushViewController(feedbackVC, animated: true)
            }
        case 4:
            let relationsVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RelationsViewController") as? RelationsViewController
            
            if let relationsVC = relationsVC {
                navigationController?.pushViewController(relationsVC, animated: true)
            }*/
//        case 7:
//            let quickGlanceVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "QuickGlanceViewController") as? QuickGlanceViewController
//
//            if let quickGlanceVC = quickGlanceVC {
//                navigationController?.pushViewController(quickGlanceVC, animated: true)
//            }
//        case 5:
//        let translateVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TranslateViewController") as? TranslateViewController
//        
//        if let translateVC = translateVC {
//            navigationController?.pushViewController(translateVC, animated: true)
//            }
        default:
            break
        }
        
    }
    
    @IBAction func callButtonSelected(_ sender: Any) {
        let executiveVC = storyboard!.instantiateViewController(withIdentifier: "HelpViewController") as? HelpViewController
        if let executiveVC = executiveVC {
            navigationController?.pushViewController(executiveVC, animated: true)
        }
    }
    
    @IBAction func homeBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
}
