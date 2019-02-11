//
//  AcheiverDetailViewController.swift
//  SFS COLLEGE
//
//  Created by Dharani Reddy on 30/01/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class AcheiverDetailViewController: UIViewController {

    internal var achiever: Achiever?
    @IBOutlet private weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBackWithNoText()
        title = "ACHIEVER"
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension AcheiverDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AchieverDetailTableCell.self)) as? AchieverDetailTableCell
        cell?.loadData(achiever: achiever)
        return cell ?? UITableViewCell()
    }
}

class AchieverDetailTableCell: UITableViewCell {
    @IBOutlet private weak var achieverImageView: UIImageView!
    @IBOutlet private weak var achieverNameLabel: UILabel!
    @IBOutlet private weak var achieverDescriptionLabel: UILabel!
    
    fileprivate func loadData(achiever: Achiever?) {
        achieverImageView.downloadImageFrom(link: achiever?.image ?? "", contentMode: .scaleAspectFill)
        achieverNameLabel.text = achiever?.name
        achieverDescriptionLabel.text = achiever?.description
    }
}
