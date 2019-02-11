//
//  AboutUsViewController.swift
//  SFS COLLEGE
//
//  Created by Dharani Reddy on 29/01/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    // MARK:- Variables
    private var aboutUsList: [AboutUsItem] = []
    
    // MARK:- IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        getAboutUsList()
        navigationBackWithNoText()
        title = "ABOUT US"
        tableView.estimatedRowHeight = 350
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    // MARK:- Private Methods
    private func getAboutUsList() {
        APICaller.getInstance().getAboutUsListItems(onSuccess: { items in
            self.aboutUsList = items
            self.tableView.reloadData()
        }, onError: {_ in})
    }
}

extension AboutUsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aboutUsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AboutUsTableCell.self)) as? AboutUsTableCell
        cell?.loadData(item: aboutUsList[indexPath.row])
        return cell ?? UITableViewCell()
    }
}

class AboutUsTableCell: UITableViewCell {
    @IBOutlet private weak var aboutUsImageView: UIImageView!
    @IBOutlet private weak var aboutUsTitleLabel: UILabel!
    @IBOutlet private weak var aboutUsDescriptionLabel: UILabel!
    
    fileprivate func loadData(item: AboutUsItem) {
        aboutUsImageView.downloadImageFrom(link: item.image, contentMode: .scaleAspectFill)
        aboutUsTitleLabel.text = item.title
        aboutUsDescriptionLabel.text = item.content
    }
}
