//
//  NewsDetailedViewController.swift
//  BREADS
//
//  Created by Dharani Reddy on 12/12/18.
//  Copyright © 2018 Integro Infotech. All rights reserved.
//

import UIKit

class NewsDetailedViewController: UIViewController {

    internal var news: News?
    private var activityController : UIActivityViewController!
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        navigationBackWithNoText()
        title = "SFS COLLEGE"
        loadActivityController(id: news?.id ?? "")
    }
    
    private func loadActivityController(id: String) {
        let url = URL(string: "http://sfscollege.in/sfscolg_app/news.php?id=\(id)")!
        activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityController.excludedActivityTypes = [.print, .copyToPasteboard, .assignToContact, .saveToCameraRoll, .addToReadingList]
    }
}

extension NewsDetailedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsDetailedTableCell.self)) as? NewsDetailedTableCell
        cell?.loadNewsInfo(news: news)
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
}

extension NewsDetailedViewController: ShareDelegate {
    func share(id: Int) {
        present(activityController, animated: true, completion: nil)
    }
}

class NewsDetailedTableCell: UITableViewCell {
    fileprivate var delegate: ShareDelegate?
    // MARK:- IBOutlets
    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var newsTitleLabel: UILabel!
    @IBOutlet private weak var newsDescriptionLabel: UILabel!
    @IBOutlet private weak var newsDateLabel: UILabel!
    
    // MARK:- Private Methods
    fileprivate func loadNewsInfo(news: News?) {
        newsImageView.image = #imageLiteral(resourceName: "default_image")
        newsImageView.downloadImageFrom(link: news?.largeImage ?? "", contentMode: .scaleAspectFill)
        newsTitleLabel.text = news?.title
        newsDescriptionLabel.text = news?.description
        newsDateLabel.text = news?.date
        getNewsImages(id: news?.id ?? "")
    }
    
    private func getNewsImages(id: String) {
        APICaller.getInstance().getNewsImages(id: id, onSuccess: { images in
            self.downloadImages(images: images)
        }, onError: {_ in})
    }
    
    private func downloadImages(images: [NewsImage]) {
        var slidePhotos: [UIImage] = []
        for newsImage in images {
            newsImage.image.downloadImage(completion: { image in
                slidePhotos.append(image)
                if images.count == slidePhotos.count {
                    DispatchQueue.main.async {
                        self.animateImageSlides(images: slidePhotos)
                    }
                }
            })
        }
    }
    
    private func animateImageSlides(images: [UIImage]) {
        newsImageView.animationImages = images
        newsImageView.animationDuration = TimeInterval(images.count*2)
        newsImageView.startAnimating()
    }
    
    @IBAction private func shareButton_Tapped() {
        delegate?.share(id: tag)
    }
}

protocol ShareDelegate: class {
    func share(id: Int)
}
