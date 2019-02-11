//
//  ManagementTeamViewController.swift
//  SFS COLLEGE
//
//  Created by Dharani Reddy on 07/02/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class ManagementTeamViewController: UIViewController {

    private var managementTeams: [ManagementTeam] = []
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getManagementTeamList()
        navigationBackWithNoText()
        title = "SFS COLLEGE"
    }
    
    private func getManagementTeamList() {
        APICaller.getInstance().getManagementTeamDetails(onSuccess: { teams in
            self.managementTeams = teams
            self.tableView.reloadData()
        }, onError: {_ in})
    }
}

extension ManagementTeamViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return managementTeams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ManagementTeamTableCell.self)) as? ManagementTeamTableCell
        cell?.loadData(managementTeam: managementTeams[indexPath.row])
        return cell ?? UITableViewCell()
    }
}

class ManagementTeamTableCell: UITableViewCell {
    @IBOutlet private weak var borderView: UIView!
    @IBOutlet private weak var designationLabel: UILabel!
    @IBOutlet private weak var managementNameLabel: UILabel!
    @IBOutlet private weak var managementImageView: UIImageView!
    
    fileprivate func loadData(managementTeam: ManagementTeam?) {
        addShadow()
        managementImageView.downloadImageFrom(link: managementTeam?.image ?? "", contentMode: .scaleAspectFill)
        managementNameLabel.text = managementTeam?.name
        designationLabel.text = managementTeam?.designation
    }
    
    private func addShadow() {
        let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: screenWidth-8, height:95))
        borderView.layer.masksToBounds = false
        borderView.layer.shadowColor = UIColor(red: 191/255, green: 191/255, blue: 191/255, alpha: 1.0).cgColor
        borderView.layer.shadowOffset = CGSize(width: 0, height: 0)
        borderView.layer.shadowOpacity = 0.9
        borderView.layer.shadowPath = shadowPath.cgPath
    }
}
