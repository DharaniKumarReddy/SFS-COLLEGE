//
//  PrincipalDeskViewController.swift
//  SFS COLLEGE
//
//  Created by Dharani Reddy on 31/01/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class PrincipalDeskViewController: UIViewController {

    private var deskItems: [PrincipalDesk] = []
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBackWithNoText()
        title = "SFS COLLEGE"
        getPrincipalDeskItems()
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func getPrincipalDeskItems() {
        APICaller.getInstance().getPrincipalDeskItems(onSuccess: { items in
            self.deskItems = items
            self.tableView.reloadData()
        }, onError: {_ in})
    }
}

extension PrincipalDeskViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deskItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PrincipalDeskTableCell.self)) as? PrincipalDeskTableCell
        cell?.loadData(principal: deskItems[indexPath.row])
        return cell ?? UITableViewCell()
    }
}

class PrincipalDeskTableCell: UITableViewCell {
    @IBOutlet private weak var principalImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    fileprivate func loadData(principal: PrincipalDesk) {
        principalImageView.downloadImageFrom(link: principal.image, contentMode: .scaleAspectFill)
        descriptionLabel.text = principal.content
    }
}
