//
//  OurMagazineViewController.swift
//  SFS COLLEGE
//
//  Created by Dharani Reddy on 31/01/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class OurMagazineViewController: UIViewController {

    private var magazines: [Magazine] = []
    
    @IBOutlet private weak var tableView: UITableView!
    private var activityController : UIActivityViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBackWithNoText()
        title = "SFS COLLEGE"
        getMagazineList()
    }
    
    // MARK:- Private Methods
    private func getMagazineList() {
        APICaller.getInstance().getOurCollegeMagazines(onSuccess: { magazines in
            self.magazines = magazines.reversed()
            self.tableView.reloadData()
        }, onError: { _ in})
    }
    
    private func loadActivityController(id: String) {
        let url = URL(string: "http://sfscollege.in/sfscolg_app/news.php?id=\(id)")!
        activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityController.excludedActivityTypes = [.print, .copyToPasteboard, .assignToContact, .saveToCameraRoll, .addToReadingList]
    }
}

extension OurMagazineViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: String(describing: MagazineTableCell.self)) as? MagazineTableCell
        cell?.loadData(magazine: magazines[indexPath.row])
        cell?.delegate = self
        cell?.pdfDelegate = self
        cell?.tag = indexPath.row
        return cell ?? UITableViewCell()
    }
}

extension OurMagazineViewController: ShareDelegate, ViewPDFDelegate {
    func share(id: Int) {
        loadActivityController(id: magazines[id].urlPdf)
        present(activityController, animated: true, completion: nil)
    }
    
    func loadUrlPDF(id: Int) {
        pushWebViewController(magazines[id].urlPdf)
    }
}

class MagazineTableCell: UITableViewCell {
    fileprivate weak var delegate: ShareDelegate?
    fileprivate weak var pdfDelegate: ViewPDFDelegate?
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var magazineImageView: UIImageView!
    
    fileprivate func loadData(magazine: Magazine) {
        titleLabel.text = magazine.title
        magazineImageView.downloadImageFrom(link: magazine.image, contentMode: .scaleAspectFill)
    }
    
    @IBAction private func shareButton_Tapped() {
        delegate?.share(id: tag)
    }
    
    @IBAction private func viewPDFButton_Tapped() {
        pdfDelegate?.loadUrlPDF(id: tag)
    }
}
