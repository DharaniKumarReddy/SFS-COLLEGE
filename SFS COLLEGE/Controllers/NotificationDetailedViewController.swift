//
//  NotificationDetailedViewController.swift
//  SFS COLLEGE
//
//  Created by Dharani Reddy on 28/01/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class NotificationDetailedViewController: UIViewController {

    internal var notification: Notification?
    private var activityController : UIActivityViewController!
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBackWithNoText()
        title = "SFS COLLEGE"
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        loadActivityController(id: notification?.id ?? "")
    }
    
    private func loadActivityController(id: String) {
        let url = URL(string: "http://sfscollege.in/sfscollege_app/notificationshare.php?id=\(id)")!
        activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityController.excludedActivityTypes = [.print, .copyToPasteboard, .assignToContact, .saveToCameraRoll, .addToReadingList]
    }
}

extension NotificationDetailedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NotificationDetailedTableCell.self)) as? NotificationDetailedTableCell
        cell?.loadNotification(notification: notification)
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
}

extension NotificationDetailedViewController: ShareDelegate {
    func share(id: Int) {
        present(activityController, animated: true, completion: nil)
    }
}

class NotificationDetailedTableCell: UITableViewCell {
    fileprivate var delegate: ShareDelegate?
    @IBOutlet private weak var notificationTitleLabel: UILabel!
    @IBOutlet private weak var notificationDescriptionLabel: UILabel!
    @IBOutlet private weak var notificationDateLabel: UILabel!
    
    fileprivate func loadNotification(notification: Notification?) {
        notificationTitleLabel.text = notification?.title
        notificationDescriptionLabel.text = notification?.description
        notificationDateLabel.text = notification?.date
    }
    
    @IBAction private func shareButton_Tapped() {
        delegate?.share(id: tag)
    }
}
