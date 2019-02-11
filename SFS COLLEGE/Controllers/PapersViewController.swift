//
//  PapersViewController.swift
//  SFS COLLEGE
//
//  Created by Dharani Reddy on 07/02/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class PapersViewController: UIViewController {

    internal var semisterId: String?
    
    private var papers: [Paper] = []
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getPapers()
        navigationBackWithNoText()
        title = "SFS COLLEGE"
        tableView.estimatedRowHeight = 122
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func getPapers() {
        APICaller.getInstance().getPapers(semisterId: semisterId ?? "", onSuccess: { papers in
            self.papers = papers.reversed()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
}

extension PapersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return papers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PaperTableCell.self)) as? PaperTableCell
        cell?.titleLabel.text = papers[indexPath.row].name
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
}

extension PapersViewController: ViewPDFDelegate {
    func loadUrlPDF(id: Int) {
        pushWebViewController(papers[id].pdf)
    }
}

class PaperTableCell: UITableViewCell {
    fileprivate weak var delegate: ViewPDFDelegate?
    
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    @IBAction private func viewButton_Tapped() {
        delegate?.loadUrlPDF(id: tag)
    }
}
