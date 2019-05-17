//
//  ExecutiveViewController.swift
//  Agenda_CTDO
//
//  Created by Palash Roy on 1/9/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class ExecutiveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var selectedIndexPath: IndexPath?
    var completeDataArray: PeopleArray?
    private var personDetailsArray: [Person]?
    @IBOutlet private weak var personsTableView: UITableView!
//    private var personData: PersonData?
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    
    @IBAction private func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func segmentBarAction(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            if let get = completeDataArray?.usaaPeople {
                personDetailsArray = get
            }
        case 1:
            if let get = completeDataArray?.tcsPeople {
                personDetailsArray = get
            }
        
        
        default:
            break
        }
        personsTableView.reloadData()
        let top = IndexPath(row: NSNotFound, section: 0)
        personsTableView.scrollToRow(at: top, at: .top, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if selectedIndexPath != nil {
            if let selectedIndexPath = selectedIndexPath {
                personsTableView.deselectRow(at: selectedIndexPath, animated: false)
            }
        }
        let top = IndexPath(row: NSNotFound, section: 0)
        personsTableView.scrollToRow(at: top, at: .top, animated: false)
    }
    
    func getDataFromServer() {
        
        let spinner = UIActivityIndicatorView(style: .gray)
        let viewBounds: CGRect = view.bounds
        spinner.center = CGPoint(x: viewBounds.midX, y: viewBounds.midY)
        view.addSubview(spinner) // spinner is not visible until started
        
        spinner.startAnimating()
        
        
        let url = URL.init(string: "https://jsonblob.com/api/jsonBlob/777db006-13d8-11e9-aac5-a7c88a1ea6ca")
        
        let task = URLSession.shared.personTask(with: url!) { peopleArray, response, error in
            if peopleArray != nil {
                DispatchQueue.main.async {
                    self.completeDataArray = peopleArray
                    spinner.stopAnimating()
                    self.personDetailsArray = self.completeDataArray?.usaaPeople
                    self.personsTableView.reloadData()
                }
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
//         To read values from URLs:
        
           getDataFromServer()
        
        segmentControl.selectedSegmentIndex = 0
        //segmentBarAction(segmentControl)
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if personDetailsArray != nil {
            return personDetailsArray!.count
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExecutiveCellIdentifier", for: indexPath) as? ExecutiveTableViewCell
        
        let person: Person = personDetailsArray![indexPath.row]
        
        // Configure the cell...
        cell?.cellImgVw.image = UIImage(named: person.smallImg ) //_imagesArray[indexPath.row];
        cell?.titleLabel.text = person.name //[NSString stringWithFormat:@"%@\n%@",person.name,person.designation];//_titlesArray[indexPath.row];
        cell?.titleDescLabel.text = person.designation //_descArray[indexPath.row];
        
        return cell!
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        let executiveDetailsVC = storyboard!.instantiateViewController(withIdentifier: "ExecutiveDetailsViewController") as? ExecutiveDetailsViewController
        executiveDetailsVC?.person = personDetailsArray![indexPath.row] as! Person
        if let executiveDetailsVC = executiveDetailsVC {
            navigationController?.pushViewController(executiveDetailsVC, animated: true)
        }
    }

}
