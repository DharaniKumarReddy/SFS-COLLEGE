//
//  NewsLetterViewController.swift
//  SFS COLLEGE
//
//  Created by Dharani Reddy on 30/01/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class NewsLetterViewController: UIViewController {

    private var newsLetters: [NewsLetter] = []
    private var activityController : UIActivityViewController!
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK:0 Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        getNewsLetters()
        navigationBackWithNoText()
        title = "NEWS LETTER"
    }
    
    // MARK:- Private Methods
    private func getNewsLetters() {
        APICaller.getInstance().getNewsLetter(onSuccess: { letters in
            self.newsLetters = letters
            self.tableView.reloadData()
        }, onError: {_ in})
    }
    
    private func loadActivityController(id: String) {
        let url = URL(string: "http://sfscollege.in/sfscolg_app/news.php?id=\(id)")!
        activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityController.excludedActivityTypes = [.print, .copyToPasteboard, .assignToContact, .saveToCameraRoll, .addToReadingList]
    }
}

extension NewsLetterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsLetters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsLetterTableCell.self)) as? NewsLetterTableCell
        cell?.loadData(letter: newsLetters[indexPath.row])
        cell?.delegate = self
        cell?.pdfDelegate = self
        cell?.tag = indexPath.row
        return cell ?? UITableViewCell()
    }
}

extension NewsLetterViewController: ShareDelegate, ViewPDFDelegate {
    func share(id: Int) {
        loadActivityController(id: newsLetters[id].urlPdf)
        present(activityController, animated: true, completion: nil)
    }
    
    func loadUrlPDF(id: Int) {
        pushWebViewController(newsLetters[id].urlPdf)
    }
}

class NewsLetterTableCell: UITableViewCell {
    fileprivate weak var delegate: ShareDelegate?
    fileprivate weak var pdfDelegate: ViewPDFDelegate?
    @IBOutlet private weak var letterNameLabel: UILabel!
    @IBOutlet private weak var letterImageView: UIImageView!
    
    fileprivate func loadData(letter: NewsLetter) {
        letterNameLabel.text = letter.name
        letterImageView.downloadImageFrom(link: letter.image, contentMode: .scaleAspectFill)
    }
    
    @IBAction private func shareButton_Tapped() {
        delegate?.share(id: tag)
    }
    
    @IBAction private func viewPDFButton_Tapped() {
        pdfDelegate?.loadUrlPDF(id: tag)
    }
}

protocol ViewPDFDelegate: class {
    func loadUrlPDF(id: Int)
}
