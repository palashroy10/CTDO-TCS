//
//  ViewController.swift
//  Agenda_CTDO
//
//  Created by Palash Roy on 1/8/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private var totalPages = 1
    private var pageNum: Int = 0
    private var btnCenter = CGPoint.zero
    private var btnOrigin = CGRect.zero
    var pageIsLoading = false
    @IBOutlet var continueButton: UIButton!
    @IBOutlet var continueImage: UIImageView!
    
    @IBOutlet private weak var backgroundImg: UIImageView!
    @IBOutlet private weak var locationDescLabel: UILabel!
    @IBOutlet private weak var lcoationLabel: UILabel!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private var swipeGesture: UISwipeGestureRecognizer!
    @IBOutlet private var leftGesture: UISwipeGestureRecognizer!
    private var locationNamesArray: [AnyHashable] = []
    private var locationDescArray: [AnyHashable] = []
    private var imagesArray: [AnyHashable] = []
    
    @IBAction private func continueBtnAction(_ sender: Any) {
        
        let navController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NavController") as? NavController
        
        if let navController = navController {
            self.present(navController, animated: true, completion: nil)
            //self.navigationController?.pushViewController(dashboardVC, animated: true)
        }
        
    }
    
    @IBAction private func swipeAction(_ sender: Any) {
        let rp: CGPoint = swipeGesture.location(in: view)
        let lp: CGPoint = leftGesture.location(in: view)
        if continueImage.frame.contains(lp) || continueImage.frame.contains(rp) {
            return
        }
        if (sender as? UISwipeGestureRecognizer) == swipeGesture {
            if pageNum > 0 {
                pageNum = pageNum - 1
            }
        } else if (sender as? UISwipeGestureRecognizer) == leftGesture {
            if pageNum < totalPages {
                pageNum = pageNum + 1
            }
        }
        let btn = UIButton(type: .custom)
        btn.tag = pageNum
        pageControl.currentPage = pageNum
        paginationBtnAction(btn)
        return
    }
    
    @IBAction private func paginationBtnAction(_ sender: AnyObject) {
        let tag: Int = sender.tag
        if tag >= totalPages {
            return
        }
        self.pageNum = tag
        backgroundImg.image = imagesArray[tag] as? UIImage
        lcoationLabel.text = locationNamesArray[tag] as? String
        locationDescLabel.text = locationDescArray[tag] as? String
//        animation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pageIsLoading = false
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//       // super.viewDidAppear(animated)
//        animation()
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.wasDragged(_:)))
        continueImage.addGestureRecognizer(gesture)
        continueImage.isUserInteractionEnabled = true
        gesture.delegate = self
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        btnCenter = continueButton.center
        btnOrigin = continueButton.frame
        locationNamesArray = ["Siruseri", "Synergy Park", "TCS Adibatla"]
        locationDescArray = ["TCS Siruseri IT Park is located near Chennai and the campus spreads across 70 acres of land. It is the largest IT office in Asia built to accomodate 24000 employees.", "TCS Synergy Park is the second TCS campus and the largest TCS facility in Hyderabad built over an area of 50 acres with a capacity of 12,000 people", "TCS Adibatla is close to the new international airport in Hyderabad, is a state of art campus which started its operations in 2014. This facility is built over an area of 75 acres and will have a capacity of 26,000 employees.", "TCS Manila is TCS’s first BPO center in Southeast Asia. This BPO center in the Philippines strengthens TCS's Global Network Delivery Model™"]
        imagesArray = [UIImage(named: "bgSiruseri.png"), UIImage(named: "bgSp.png"), UIImage(named: "bgAdibatla.png")]
        swipeGesture.delegate = self
        pageNum = 0
        //animation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func animation() {
        UIView.animate(withDuration: 4.0, delay: 1.0, options: .curveEaseIn, animations: {
            if self.pageNum < self.totalPages {
                self.pageNum = self.pageNum + 1
            }
            else if self.pageNum > 0 {
                self.pageNum = self.pageNum - 1
            }
            let btn = UIButton(type: .custom)
            btn.tag = self.pageNum
            self.pageControl.currentPage = self.pageNum
            self.perform(#selector(ViewController.paginationBtnAction(_:)), with: btn, afterDelay: 1.0)
        })
        
        
    }
    

    
   @objc func wasDragged(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let translation = gestureRecognizer.translation(in: self.view)
            
            let y = continueButton.center.y
            let x = gestureRecognizer.location(in: continueImage).x + continueImage.frame.width/2
//    print(gestureRecognizer.view!.center.y)
            print(gestureRecognizer.state.rawValue)
            if (x > (continueImage.frame.origin.x + continueButton.frame.width/2)) && (x < continueImage.frame.origin.x + continueImage.frame.width - continueButton.frame.width/2) {
            continueButton.center = CGPoint(x: x, y: y)
                }
            
            
            }
    
    if (gestureRecognizer.state == .ended) {
        
        if continueButton.center.x < continueImage.center.x {
            translateBack()
        } else {
            let endpont: CGPoint = CGPoint(x: continueImage.frame.origin.x + continueImage.frame.width - continueButton.frame.width/2, y: continueButton.center.y)
            translateForth(endpont)
        }
        print("Ended")
    }

    }

    
    
    func translateBack() {
        UIView.animate(withDuration: 0.2, animations: {
            self.btnCenter.y = self.continueButton.center.y
            self.btnCenter.x = self.continueImage.frame.origin.x + (self.continueButton.frame.width/2)
            self.continueButton.center = self.btnCenter
        }, completion: nil)
    }
    
    func translateForth(_ endPont: CGPoint) {
        UIView.animate(withDuration: 0.2, animations: {
            self.continueButton.center = endPont
        }) { (done) in
            self.perform(#selector(self.continueBtnAction(_:)), with: UIButton(), afterDelay: 0.1)
            //self.continueBtnAction(UIButton())
        }
    }
    
    @IBAction func continueSlideSelected(_ sender: Any) {
        if pageIsLoading == false {
            UIView.animate(withDuration: 0.5, animations: {
                self.continueButton.frame = CGRect(x: self.continueImage.frame.origin.x + self.continueImage.frame.size.width - self.continueButton.frame.size.width, y: self.continueButton.frame.origin.y, width: self.continueButton.frame.size.width, height: self.continueButton.frame.size.height)
            }) { finished in
                self.continueBtnAction(sender)
                self.pageIsLoading = true
            }
        }
    }
}
