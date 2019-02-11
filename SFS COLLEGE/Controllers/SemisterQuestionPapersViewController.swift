//
//  SemisterQuestionPapersViewController.swift
//  SFS COLLEGE
//
//  Created by Dharani Reddy on 06/02/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class SemisterQuestionPapersViewController: UIViewController {

    internal var groupId: String?
    
    private var semisterPapers: [SemisterPaper] = []
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getSemisterPapers()
        navigationBackWithNoText()
        title = "SFS COLLEGE"
    }
    
    private func getSemisterPapers() {
        APICaller.getInstance().getSemisterPapers(questionId: groupId ?? "", onSuccess: { papers in
            self.semisterPapers = papers.reversed()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
}

extension SemisterQuestionPapersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return semisterPapers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SemisterQuestionPaperTableCell.self)) as? SemisterQuestionPaperTableCell
        cell?.titleButton.setTitle(semisterPapers[indexPath.row].name, for: .normal)
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
}

extension SemisterQuestionPapersViewController: ViewPDFDelegate {
    func loadUrlPDF(id: Int) {
        let papersViewController = UIStoryboard.loadPapersViewController()
        papersViewController.semisterId = semisterPapers[id].id
        navigationController?.pushViewController(papersViewController, animated: true)
    }
}

class SemisterQuestionPaperTableCell: UITableViewCell {
    fileprivate weak var delegate: ViewPDFDelegate?
    
    @IBOutlet fileprivate weak var titleButton: UIButton!
    
    @IBAction private func titleButton_Tapped() {
        delegate?.loadUrlPDF(id: tag)
    }
}
