//
//  AcheiversViewController.swift
//  SFS COLLEGE
//
//  Created by Dharani Reddy on 30/01/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class AcheiversViewController: UIViewController {

    // MARK:- Variables
    private var achievers: [Achiever] = []
    
    // MARK:- IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAcheivers()
        navigationBackWithNoText()
        title = "ACHIEVERS"
    }
    
    // MARK:- Private Methods
    private func getAcheivers() {
        APICaller.getInstance().getAcheivers(onSuccess: { achievers in
            self.achievers = achievers.reversed()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
}

extension AcheiversViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return achievers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AcheiverTableCell.self)) as? AcheiverTableCell
        cell?.loadData(achiever: achievers[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let acheiverDetailedViewController = UIStoryboard.loadAcheiverDetailViewController()
        acheiverDetailedViewController.achiever = achievers[indexPath.row]
        navigationController?.pushViewController(acheiverDetailedViewController, animated: true)
    }
}

class AcheiverTableCell: UITableViewCell {
    @IBOutlet private weak var acheiverImageView: UIImageView!
    @IBOutlet private weak var acheiverNameLabel: UILabel!
    @IBOutlet private weak var acheiverDescriptionLabel: UILabel!
    
    fileprivate func loadData(achiever: Achiever) {
        acheiverImageView.downloadImageFrom(link: achiever.image, contentMode: .scaleAspectFill)
        acheiverNameLabel.text = achiever.name
        acheiverDescriptionLabel.text = achiever.description
    }
}
