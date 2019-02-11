//
//  ResultsViewController.swift
//  SFS COLLEGE
//
//  Created by Dharani Reddy on 05/02/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    private var results: [Result] = []
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "SFS COLLEGE"
        navigationBackWithNoText()
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        getResults()
    }
    
    private func getResults() {
        APICaller.getInstance().getResults(onSuccess: { results in
            self.results = results
            self.tableView.reloadData()
        }, onError: {_ in})
    }
}

extension ResultsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ResultsTableCell.self)) as? ResultsTableCell
        cell?.loadData(result: results[indexPath.row])
        cell?.delegate = self
        cell?.tag = indexPath.row
        return cell ?? UITableViewCell()
    }
}

extension ResultsViewController: ViewPDFDelegate {
    func loadUrlPDF(id: Int) {
        pushWebViewController(results[id].pdf)
    }
}

class ResultsTableCell: UITableViewCell {
    fileprivate weak var delegate: ViewPDFDelegate?
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    fileprivate func loadData(result: Result) {
        titleLabel.text = result.name
        descriptionLabel.text = result.description
    }
    
    @IBAction private func viewPdfButton_Tapped() {
        delegate?.loadUrlPDF(id: tag)
    }
}
