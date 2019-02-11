//
//  QuestionPapersViewController.swift
//  SFS COLLEGE
//
//  Created by Dharani Reddy on 05/02/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class QuestionPapersViewController: UIViewController {

    private var questionPapers: [QuestionPaper] = []
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getQuestionPapers()
        navigationBackWithNoText()
        title = "SFS COLLEGE"
    }
    
    private func getQuestionPapers() {
        APICaller.getInstance().getQuestionPapers(onSuccess: { papers in
            self.questionPapers = papers.reversed()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
}

extension QuestionPapersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionPapers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: QuestionPaperTableCell.self)) as? QuestionPaperTableCell
        cell?.titleButton.setTitle(questionPapers[indexPath.row].name, for: .normal)
        cell?.tag = indexPath.row
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
}
extension QuestionPapersViewController: ViewPDFDelegate {
    func loadUrlPDF(id: Int) {
        let semisterQuestionController = UIStoryboard.loadSemisterQuestionViewController()
        semisterQuestionController.groupId = questionPapers[id].id
        navigationController?.pushViewController(semisterQuestionController, animated: true)
    }
}

class QuestionPaperTableCell: UITableViewCell {
    fileprivate weak var delegate: ViewPDFDelegate?
    
    @IBOutlet fileprivate weak var titleButton: UIButton!
    
    @IBAction private func titleButton_Tapped() {
        delegate?.loadUrlPDF(id: tag)
    }
}
