//
//  CourseDetailViewController.swift
//  SFS COLLEGE
//
//  Created by Dharani Reddy on 04/02/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class CourseDetailViewController: UIViewController {

    internal var course: Course?
    private var activityController : UIActivityViewController!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "SFS COLLEGE"
        navigationBackWithNoText()
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableView.automaticDimension
        loadActivityController(id: course?.id ?? "")
    }
    
    private func loadActivityController(id: String) {
        let url = URL(string: "http://sfscollege.in/sfscollege_app/courseshare.php?id=\(id)")!
        activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityController.excludedActivityTypes = [.print, .copyToPasteboard, .assignToContact, .saveToCameraRoll, .addToReadingList]
    }
    
    private func apply() {
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
    
    private func callNumber(number: String) {
        if let url = URL(string: "telprompt:\(number)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            }
        }
    }
}

extension CourseDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CourseDetailTableCell.self)) as? CourseDetailTableCell
        cell?.loadData(course: course)
        cell?.delegate = self
        cell?.applyDelegate = self
        return cell ?? UITableViewCell()
    }
}

extension CourseDetailViewController: ShareDelegate, ViewPDFDelegate {
    func share(id: Int) {
        present(activityController, animated: true, completion: nil)
    }
    
    func loadUrlPDF(id: Int) {
        apply()
    }
}

class CourseDetailTableCell: UITableViewCell {
    fileprivate var delegate: ShareDelegate?
    fileprivate var applyDelegate: ViewPDFDelegate?
    
    @IBOutlet private weak var courseImageView: UIImageView!
    @IBOutlet private weak var courseTitleLabel: UILabel!
    @IBOutlet private weak var courseDescriptionLabel: UILabel!
    
    fileprivate func loadData(course: Course?) {
        courseImageView.downloadImageFrom(link: course?.image ?? "", contentMode: .scaleAspectFill)
        courseTitleLabel.text = course?.title
        courseDescriptionLabel.text = course?.description
    }
    
    @IBAction private func shareButton_Tapped() {
        delegate?.share(id: tag)
    }
    
    @IBAction private func applyButton_Tapped() {
        applyDelegate?.loadUrlPDF(id: tag)
    }
}
