	//
//  ScheduleViewController.swift
//  Agenda_CTDO
//
//  Created by Palash Roy on 1/8/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

//  Converted to Swift 4 by Swiftify v4.2.28993 - https://objectivec2swift.com/
class ScheduleViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate {
    private var dateSelectedIndex: Int = 0
    private var selectedMainRowIndex: Int = 0
    private var selectedIndexPath: IndexPath? //To collapse or display selected cell
    
    private var finalScheduleArray: ScheduleData = ScheduleData()
    private var selectedDateSchedule: ScheduleElement?
    @IBOutlet private weak var selectedDateLabel: UILabel!
    @IBOutlet private weak var selectedMonthLabel: UILabel!
    @IBOutlet private weak var selectedDayLabel: UILabel!
    @IBOutlet private weak var scheduleTableView: UITableView!
    @IBOutlet private weak var companyLogoImgVw: UIImageView!
    @IBOutlet private weak var locationNameLabel: UILabel!
    
    @IBAction private func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var scheduleDateScroller: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getDataFromServer()
        selectedIndexPath = IndexPath(row: 0, section: -1)
        
        scheduleTableView.estimatedRowHeight = 80
        scheduleTableView.rowHeight = UITableView.automaticDimension
    }
    
    func getDataFromServer() {
        
        let spinner = UIActivityIndicatorView(style: .gray)
        let viewBounds: CGRect = view.bounds
        spinner.center = CGPoint(x: viewBounds.midX, y: viewBounds.midY)
        view.addSubview(spinner) // spinner is not visible until started
        
        spinner.startAnimating()
        
        
        let url = URL.init(string: "https://jsonblob.com/api/jsonBlob/947129f3-7631-11e9-98f7-f7440034a19e")
        
        let task = URLSession.shared.scheduleTask(with: url!) { scheduleArray, response, error in
            if  scheduleArray != nil {
                DispatchQueue.main.async {
                    self.finalScheduleArray = scheduleArray!
                    spinner.stopAnimating()
                    self.view.isUserInteractionEnabled = true
                    self.scheduleDateScroller.isHidden = false
                    //self.scheduleDateScroller.reloadData()
                    self.dateCellClicked(at: 0)
                    
                }
             }
           }
           task.resume()
    }
    
    
    //Collection view3 delegates & datasources
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return finalScheduleArray.count
    }
    
    static let collectionViewCellIdentifier = "datecell"
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleViewController.collectionViewCellIdentifier, for: indexPath) as? CollectionViewCell
        if dateSelectedIndex == indexPath.row {
            cell?.backgroundColor = UIColor(red: 0.98, green: 0.78, blue: 0.0, alpha: 1.0)
        } else {
            cell?.backgroundColor = UIColor.clear
        }
        let mainData = finalScheduleArray[indexPath.row] as? ScheduleElement
        
        if let day = mainData?.day, let date = mainData?.date
        {
            cell?.dateLabel.text = date
            cell?.dayLabel.text = String(day.prefix(1))
        }
        
        cell?.tag = indexPath.row
        // return the cell
        return cell!
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // top, left, bottom, right
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        
        cell?.backgroundColor = UIColor(red: 0.98, green: 0.78, blue: 0.0, alpha: 1.0)

        selectedIndexPath = IndexPath(row: 0, section: -1)
        let mainData = finalScheduleArray[indexPath.row] as? ScheduleElement
        dateSelectedIndex = indexPath.row
        selectedMonthLabel.text = mainData?.month
        selectedDateLabel.text = mainData?.date
        selectedDayLabel.text = mainData?.day
        locationNameLabel.text = mainData?.place
        
        dateCellClicked(at: dateSelectedIndex)
        scheduleDateScroller.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        cell?.backgroundColor = UIColor.clear
        selectedIndexPath = IndexPath(index: -1)
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        var rowCount: Int = 0
        rowCount = selectedDateSchedule?.schedule.count ?? 0
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount: Int = 1
        if selectedIndexPath?.section == section {
            let scheduleData = selectedDateSchedule?.schedule[section]

            if scheduleData?.name.count != 0 && scheduleData?.desc.count != 0 {
                rowCount = rowCount + 3
            } else if scheduleData?.name.count != 0 {
                rowCount = rowCount + 2 // one header and 3 details like 1.descriptions 2. clock.
            } else if scheduleData?.desc.count != 0 {
                rowCount = rowCount + 2 // one header and 3 details like 1.descriptions 2. clock.
            } else {
                rowCount = rowCount + 1 // one header and 3 details like 1.descriptions 2. clock, 3. presenter 4. meeting location
            }
        } else {
            rowCount = 1
        }
        return rowCount
    }
    
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        var rowHeight: CGFloat = 45
        let padding: CGFloat = 40
        let lFont = UIFont(name: "Avenir-Medium", size: 14.0)
        //        if (indexPath.section == 0) {
        //            rowHeight = 60;
        //        }
        //        else  {
        let scheduleData = selectedDateSchedule?.schedule[indexPath.section]
        if indexPath.row == 0 {
            var labelHeight: CGFloat = getLabelHeight(for: lFont, forWidth: 200, andText: scheduleData?.meeting)
            rowHeight = labelHeight + padding
            if rowHeight <= 45 {
                rowHeight = 45
            }
        }
        if selectedIndexPath?.section == indexPath.section {
            if indexPath.row == 1 {
                var labelHeight: CGFloat = getLabelHeight(for: lFont, forWidth: 220, andText: scheduleData?.place)
                rowHeight = labelHeight + padding
                if rowHeight <= 45 {
                    rowHeight = 45
                }
            } else if indexPath.row == 2 {
                var labelHeight: CGFloat = 0.0
                if scheduleData?.name.count != 0 {
                    labelHeight = getLabelHeight(for: lFont, forWidth: 220, andText: scheduleData?.name)
                } /*else if scheduleData?.desc.count != 0 {
                    labelHeight = getLabelHeight(for: lFont, forWidth: 220, andText: scheduleData?.desc)
                }*/
                rowHeight = labelHeight + padding + 20
                if rowHeight <= 45 {
                    rowHeight = 45
                }
            } else if indexPath.row == 3 {
                var labelHeight: CGFloat = getLabelHeight(for: lFont, forWidth: 220, andText: scheduleData?.desc)
                rowHeight = labelHeight + padding
                if rowHeight <= 45 {
                    rowHeight = 45
                }
            }
        }
        //        }
        return rowHeight
    }
    
    func getLabelHeight(for font: UIFont?, forWidth width: CGFloat, andText text: String?) -> CGFloat {
        let constraint = CGSize(width: width, height: 9999)
        var size: CGSize
        
        let context = NSStringDrawingContext()
        var boundingBox: CGSize? = nil
        if let font = font {
            boundingBox = text?.boundingRect(with: constraint, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: context).size
        }
        
        size = CGSize(width: ceil((boundingBox?.width)!), height: ceil((boundingBox?.height)!))
        
        return size.height
    }
    
     */
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var identifierString: String? = nil
        
        if indexPath.row == 0 {
            identifierString = "ScheduleCellIdentifier"
        } else {
            identifierString = "ScheduleDescriptionCell"
        }
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifierString ?? "", for: indexPath)
        cell.tag = indexPath.section
        
        let scheduleData = selectedDateSchedule?.schedule[indexPath.section]
        
        if indexPath.row == 0 {
            if selectedIndexPath?.section == indexPath.section {
                (cell as? ScheduleTableViewCell)?.backgroundColor = UIColor(red: 243.0 / 255.0, green: 243.0 / 255.0, blue: 243.0 / 255.0, alpha: 1.0)
            } else {
                (cell as? ScheduleTableViewCell)?.backgroundColor = UIColor.clear
            }
            (cell as? ScheduleTableViewCell)?.timeLabel.text = scheduleData?.time
            (cell as? ScheduleTableViewCell)?.timeLabel.isHidden = (cell as? ScheduleTableViewCell)?.timeLabel.text?.isEmpty ?? true
            (cell as? ScheduleTableViewCell)?.meetingLabel.text = scheduleData?.meeting

            if (scheduleData?.type == .travel) {
                (cell as? ScheduleTableViewCell)?.iconImageView.image = UIImage(named: "pickup")
            } else if (scheduleData?.type == .food) {
                (cell as? ScheduleTableViewCell)?.iconImageView.image = UIImage(named: "Food")
            } else if (scheduleData?.type == .reception) {
                (cell as? ScheduleTableViewCell)?.iconImageView.image = UIImage(named: "reception")
            } else if (scheduleData?.type == .meeting) {
                (cell as? ScheduleTableViewCell)?.iconImageView.image = UIImage(named: "team")
            } else {
                (cell as? ScheduleTableViewCell)?.iconImageView.image = UIImage(named: "Genaral")
            }
        } else {
            if selectedIndexPath?.section == indexPath.section {
                (cell as? ScheduleDescriptionTableViewCell)?.backgroundColor = UIColor(red: 243.0 / 255.0, green: 243.0 / 255.0, blue: 243.0 / 255.0, alpha: 1.0)
            } else {
                (cell as? ScheduleDescriptionTableViewCell)?.backgroundColor = UIColor.clear
            }
//            let scheduleData = selectedDateSchedule?.schedule![indexPath.section] as? ScheduleData
            var presenter = "Presenter"
            let mainData = finalScheduleArray[dateSelectedIndex] as? ScheduleElement
            if (scheduleData?.type == .food) || (mainData?.logo == "IBM") || scheduleData?.name.contains("USAA Executives") ?? false {
                presenter = "Participants"
            }

            switch indexPath.row {
            // Asked to remove time row
            case 1:
                (cell as? ScheduleDescriptionTableViewCell)?.meetingNameLabel.text = "Location"
                (cell as? ScheduleDescriptionTableViewCell)?.meetingDescriptionLabel.text = scheduleData?.place
                ((cell as? ScheduleDescriptionTableViewCell))?.iconImageView.image = (UIImage(named: "eventLocation"))
            case 4:
                if scheduleData?.name.count != 0 {
                    (cell as? ScheduleDescriptionTableViewCell)?.meetingNameLabel.text = presenter
                    (cell as? ScheduleDescriptionTableViewCell)?.meetingDescriptionLabel.text = scheduleData?.name
                    ((cell as? ScheduleDescriptionTableViewCell))?.iconImageView.image = (UIImage(named: "participants"))
                } /*else if scheduleData?.desc.count != 0 {
                    (cell as? ScheduleDescriptionTableViewCell)?.meetingNameLabel.text = "Description"
                    (cell as? ScheduleDescriptionTableViewCell)?.meetingDescriptionLabel.text = scheduleData?.desc
                    ((cell as? ScheduleDescriptionTableViewCell))?.iconImageView.image = (UIImage(named: "team"))
                }*/
            case 2:
                (cell as? ScheduleDescriptionTableViewCell)?.meetingNameLabel.text = "Description"
                (cell as? ScheduleDescriptionTableViewCell)?.meetingDescriptionLabel.text = scheduleData?.desc
                ((cell as? ScheduleDescriptionTableViewCell))?.iconImageView.image = (UIImage(named: "team"))
            default:
                break
            }
        }
        return cell
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndexPath?.section == indexPath.section {
            var cell: UITableViewCell? = nil
            if let selectedIndexPath = selectedIndexPath {
                cell = scheduleTableView.cellForRow(at: selectedIndexPath)
            }
            (cell as? ScheduleTableViewCell)?.backgroundColor = UIColor.clear
            selectedIndexPath = IndexPath(row: 0, section: -1)
        } else {
            selectedIndexPath = indexPath
        }
        tableView.reloadData()
    }
    
    func dateCellClicked(at index: Int) {
        let mainData : ScheduleElement = finalScheduleArray[index]
        if (mainData.logo == "TCS") {
            companyLogoImgVw.image = UIImage(named: "TATAlogo.png")
        } else if (mainData.logo == "IBM") {
            companyLogoImgVw.image = UIImage(named: "IBMlogo.png")
        } else if (mainData.logo == "HCL") {
            companyLogoImgVw.image = UIImage(named: "HCLlogo.png")
        } else {
            companyLogoImgVw.image = UIImage(named: "TATAlogo.png")
        }
        
        ////
        selectedMonthLabel.text = mainData.month
        selectedDateLabel.text = mainData.date
        selectedDayLabel.text = mainData.day
        locationNameLabel.text = mainData.place
        
        //dateCellClicked(at: dateSelectedIndex)
        scheduleDateScroller.reloadData()
        
        ////
        
        
        //let cell: UICollectionViewCell? = scheduleDateScroller.cellForItem(at: IndexPath(row: index, section: 0))
        
        //if cell != nil {
            selectedDateSchedule = finalScheduleArray[index]
        //}
        scheduleTableView.setContentOffset(CGPoint(x: 0, y: 0 - scheduleTableView.contentInset.top), animated: false)
        scheduleTableView.reloadData()
    }
}
