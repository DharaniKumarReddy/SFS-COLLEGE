//
//  MenuViewController.swift
//  SFS COLLEGE
//
//  Created by Dharani Reddy on 22/01/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit
import CoreLocation

class MenuViewController: UIViewController {

    let imageWidth: CGFloat = (iPhoneStandard || iPhoneSE || iPhone4s) ? 924 : 1242
    
    // MARK:- IBOutlets
    @IBOutlet private weak var landscapeImageLeadingConstraint: NSLayoutConstraint!
    
    // MARK:- Variables
    internal var shouldAnimate = false
    private var isAnimating = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        shouldAnimate = false
    }
    
    // MARK:- Private Methods
    private func animation() {
        guard (shouldAnimate && landscapeImageLeadingConstraint.constant == 0 && !isAnimating) else {
            return
        }
        isAnimating = true
        UIView.animate(withDuration: 50, animations: {
            self.landscapeImageLeadingConstraint.constant = -self.imageWidth+screenWidth-screenWidth/5
            self.view.layoutIfNeeded()
        }, completion: { _ in
            guard self.landscapeImageLeadingConstraint.constant == -self.imageWidth+screenWidth-screenWidth/5 else {
                self.isAnimating = false
                return }
            UIView.animate(withDuration: 50, animations: {
                self.landscapeImageLeadingConstraint.constant = 0
                self.view.layoutIfNeeded()
            }, completion: { _ in
                self.isAnimating = false
                guard (self.landscapeImageLeadingConstraint.constant == 0 && self.shouldAnimate) else {
                    return }
                self.animation()
            })
        })
    }
    
    private func pushWebController(urlString: String) {
        slideMenuController()?.closeLeft()
        let webViewController = UIStoryboard.loadWebViewController()
        webViewController.webUrlString = urlString
        (slideMenuController()?.mainViewController as! UINavigationController).pushViewController(webViewController, animated: true)
    }
    
    private func callNumber(number: String) {
        if let url = URL(string: "telprompt:\(number)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            }
        }
    }
    
    private func openMaps() {
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            let url = URL(string: "comgooglemaps://?daddr=sfs+degree+college+bangalore&center=12.8321916,77.6122687&directionsmode=driving&zoom=17")!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            let url = URL(string: "http://maps.apple.com/maps?daddr=sfs+degree+college+bangalore&center=12.8321916,77.6122687&directionsmode=driving&zoom=17")!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    // MARK:- IBActions
    @IBAction private func managementTeamButton_Tapped() {
        slideMenuController()?.closeLeft()
        let managementTeamViewController = UIStoryboard.loadManagementTeamViewController()
        (slideMenuController()?.mainViewController as! UINavigationController).pushViewController(managementTeamViewController, animated: true)
    }
    
    @IBAction private func staffDirectoryButton_Tapped() {
        pushWebController(urlString: "http://sfscollege.in/sfscollege_app/staff.html")
    }
    
    @IBAction private func enquiryButton_Tapped() {
        pushWebController(urlString: "http://sfscollege.in/sfscollege_app/parents_enquiry.html")
    }
    
    @IBAction private func callButton_Tapped() {
        let callAlert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let firstNumberAction = UIAlertAction(title: "+91-8027834611", style: .default, handler: { _ in
            self.callNumber(number: "+91-8027834611")
        })
        let secondNumberAction = UIAlertAction(title: "+91-8027836165", style: .default, handler: { _ in
            self.callNumber(number: "+91-8027836165")
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        callAlert.addAction(firstNumberAction)
        callAlert.addAction(secondNumberAction)
        callAlert.addAction(cancelAction)
        present(callAlert, animated: true, completion: nil)
    }
    
    @IBAction private func emailButton_Tapped() {
        let email = "principal@sfscollege.in"
        if let url = URL(string: "mailto:\(email)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            }
        }
    }
    
    @IBAction private func getAddressButton_Tapped() {
        let mapsAlert = UIAlertController(title: "Electronic City, Bangalore - 560 100, Karnataka, INDIA.", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "GO TO MAP", style: .default, handler: { _ in
            self.openMaps()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        mapsAlert.addAction(action)
        mapsAlert.addAction(cancelAction)
        present(mapsAlert, animated: true, completion: nil)
    }
    
    @IBAction private func websiteButton_Tapped() {
        if let url = URL(string: "http://sfscollege.in/home.html") {
            UIApplication.shared.open(url, options: [:])
        }
    }
}


// Helper function inserted by Swift 4.2 migrator.
internal func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
