//
//  DashboardViewController.swift
//  SFS COLLEGE
//
//  Created by Dharani Reddy on 22/01/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import WebKit

let screenWidth     = UIScreen.main.bounds.width
let screenHeight    = UIScreen.main.bounds.height
let iPhoneStandard  = screenHeight == 667.0
let iPhoneSE        = screenHeight == 568.0
let iPhone4s        = screenHeight == 480.0

class DashboardViewController: UIViewController, WKUIDelegate {

    // MARK:- Variables
    private var courses: [Course] = []
    private var news: [News] = []
    private var notifications: [Notification] = []
    var webView: WKWebView!
    private var isNotifiedAlertDismissed = true
    private var isShowingNews = false
    private var isShowingNotifications = false
    
    // MARK:- IBOutlets
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var calendarView: UIView!
    @IBOutlet private weak var newsTableView: UITableView!
    @IBOutlet private weak var slidingImageView: UIImageView!
    @IBOutlet private weak var recentNotificationLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var notificationsTableView: UITableView!
    @IBOutlet private weak var indicatorViewLeadingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barStyle = .black
        slideMenuController()?.changeLeftViewWidth(screenWidth-screenWidth/5)
        SlideMenuOptions.contentViewScale = 1.0
        getCoverPhotos()
        getCoursesList()
        getNews()
        getNotification()
        loadWebView()
        newsTableView.estimatedRowHeight = 300
        newsTableView.rowHeight = UITableView.automaticDimension
        notificationsTableView.estimatedRowHeight = 100
        notificationsTableView.rowHeight = UITableView.automaticDimension
        (UIApplication.shared.delegate as? AppDelegate)?.dashboard = self
    }
    
    override func loadView() {
        super.loadView()
        
        webView = WKWebView()
        webView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: getViewHeight())
        calendarView.addSubview(webView)
    }
    
    // MARK:- Private Methods
    private func getNews() {
        APICaller.getInstance().getNews(onSuccess: { news in
            self.news = news.reversed()
            self.newsTableView.reloadData()
        }, onError: {_ in})
    }
    
    private func getNotification() {
        APICaller.getInstance().getNotifiction(onSuccess: { notifications in
            self.notifications = notifications.reversed()
            self.notificationsTableView.reloadData()
            self.recentNotificationLabel.text = self.notifications.first?.title
        }, onError: { _ in })
    }
    
    private func loadWebView() {
        
        let myURL = URL(string:"http://sfscollege.in/sfscollege_app/calender.html")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    private func getCoverPhotos() {
        APICaller.getInstance().getCoverPhotos(onSuccess: { photos in
            self.downloadImages(photos: photos)
        }, onError: { _ in })
    }
    
    private func downloadImages(photos: [CoverPhoto]) {
        var slidePhotos: [UIImage] = []
        for photo in photos {
            photo.image.downloadImage(completion: { image in
                slidePhotos.append(image)
                if photos.count == slidePhotos.count {
                    DispatchQueue.main.async {
                        self.animateImageSlides(images: slidePhotos)
                    }
                }
            })
        }
    }
    
    private func animateImageSlides(images: [UIImage]) {
        slidingImageView.animationImages = images
        slidingImageView.animationDuration = TimeInterval(images.count*2)
        slidingImageView.startAnimating()
    }
    
    private func getCoursesList() {
        APICaller.getInstance().getCoursesList(onSuccess: { courses in
            self.courses = courses
            self.collectionView.reloadData()
        }, onError: { _ in })
    }
    private func animateIndicator(index: CGFloat) {
        UIView.animate(withDuration: 0.3, animations: {
            self.indicatorViewLeadingConstraint.constant = index * (screenWidth/4)
            self.view.layoutIfNeeded()
        })
    }
    
    private func animateScrollView(point: CGPoint) {
        scrollView.setContentOffset(point, animated: true)
    }
    
    private func getViewHeight() -> CGFloat {
        let viewHeight = screenHeight - (UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 20) - 44
        let tabsHeight = (32/404) * viewHeight
        return (viewHeight - tabsHeight)
    }
    
    private func getCollectionViewHeight() -> CGFloat {
        return (80/744) * getViewHeight()
    }
    
    // MARK:- IBActions
    @IBAction private func menuButton_Tapped() {
        (slideMenuController()?.leftViewController as! MenuViewController).shouldAnimate = true
        slideMenuController()?.openLeft()
    }
    
    @IBAction private func recentNotificationButton_Tapped() {
        animateIndicator(index: 3)
        animateScrollView(point: CGPoint(x: 3 * screenWidth, y: 0))
    }
    
    @IBAction private func tabBarButton_Tapped(button: UIButton) {
        let tag = CGFloat(button.tag)
        animateIndicator(index: tag)
        animateScrollView(point: CGPoint(x: tag * screenWidth, y: 0))
        isShowingNews = tag == 1
        isShowingNotifications = tag == 3
    }
    
    @IBAction private func swipeGestureRecognizer(gesture: UISwipeGestureRecognizer) {
        let currentXPoint = scrollView.contentOffset.x
        let xPoint = gesture.direction == .left ? currentXPoint+screenWidth : currentXPoint-screenWidth
        guard xPoint >= 0 && xPoint <= screenWidth*3 else { return }
        animateIndicator(index: xPoint/screenWidth)
        animateScrollView(point: CGPoint(x: xPoint, y: 0))
    }
    
    @IBAction private func socialButton_Tapped(button: UIButton) {
        guard button.tag != 3 else {
            return
        }
        pushWebViewController(["", "https://www.facebook.com/sfscollegebangalore/?hc_ref=SEARCH-", "https://twitter.com/sfscollege"][button.tag])
    }
}

extension DashboardViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let course = courses[indexPath.row]
        let width = max(50, course.title.widthWithConstrainedHeight(height: 70, font: UIFont(name: "Helvetica Neue", size: 17)!)+25)
        let height = getCollectionViewHeight()
        return CGSize(width: max(width, height), height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell
         = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CourseCollectionCell.self), for: indexPath) as? CourseCollectionCell
        cell?.titleLabel.text = courses[indexPath.row].title
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = UIStoryboard.loadCourseDetailViewController()
        detailViewController.course = courses[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

class CourseCollectionCell: UICollectionViewCell {
    @IBOutlet fileprivate weak var titleLabel: UILabel!
}

// MARK:- News, Notifications
extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == newsTableView ? news.count : notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == newsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsTableCell.self)) as? NewsTableCell
            cell?.loadData(news: news[indexPath.row])
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NotificationTableCell.self)) as? NotificationTableCell
            cell?.loadData(notification: notifications[indexPath.row])
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == newsTableView {
            let newsDetailedController = UIStoryboard.loadNewsDetailViewController()
            newsDetailedController.news = news[indexPath.row]
            navigationController?.pushViewController(newsDetailedController, animated: true)
        } else {
            let notificationDetailedViewController = UIStoryboard.loadNotificationDetailViewController()
            notificationDetailedViewController.notification = notifications[indexPath.row]
            navigationController?.pushViewController(notificationDetailedViewController, animated: true)
        }
    }
}

class NewsTableCell: UITableViewCell {
    // MARK:- IBOutlets
    @IBOutlet private weak var titleLbel: UILabel!
    @IBOutlet private weak var newsDateLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var newsImageView: UIImageView!
    
    fileprivate func loadData(news: News) {
        titleLbel.text = news.title
        descriptionLabel.text = news.description
        newsDateLabel.text = news.date
        newsImageView.downloadImageFrom(link: news.largeImage, contentMode: .scaleAspectFill)
    }
}

class NotificationTableCell: UITableViewCell {
    // MARK:- IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var notificationDateLabel: UILabel!
    
    fileprivate func loadData(notification: Notification) {
        titleLabel.text = notification.title
        descriptionLabel.text = notification.description
        notificationDateLabel.text = notification.date
    }
}

// MARK:- Push Notifications
extension DashboardViewController {
    /**
     Before notification going to invoke its controller, basic checks needs to be verified and notificaton will be fired.
     */
    internal func postRemoteNotification() {
        
        // Check Notification is recieved while app is foreground
        if isNotifiedAlertDismissed {
            self.isNotifiedAlertDismissed = false
            // Pop's up the alertview and notifiy user to whether he/she wants to reach notified controller
            guard TopViewController.isNotifiedController() && isNewsOrNotifications() else {
                showAlertViewController(PushNotificationHandler.sharedInstance.notificationTitle, message: truncateCharactersInNotificationMessage(PushNotificationHandler.sharedInstance.notificationMessage as NSString), cancelButton: "Close", destructiveButton: "", otherButtons: "Open", onDestroyAction: {
                    self.isNotifiedAlertDismissed = true
                    PushNotificationHandler.sharedInstance.isNotificationReachedItsDestination = true
                    self.presentNotifiedViewController()
                }, onCancelAction: {
                    self.isNotifiedAlertDismissed = true
                    // Making sure app is reached its destination view controller, so that future notifications will show
                    PushNotificationHandler.sharedInstance.isNotificationReachedItsDestination = true
                })
                return
            }
            isNotifiedAlertDismissed = true
            PushNotificationHandler.sharedInstance.isNotificationReachedItsDestination = true
        } else if isNotifiedAlertDismissed {
            
            //Looks for destined notification controller
            presentNotifiedViewController()
        } else {
            // Making sure app is reached its destination view controller, so that future notifications will show
            PushNotificationHandler.sharedInstance.isNotificationReachedItsDestination = true
        }
    }
    /**
     To confirm whether notification reached its destined controller.
     */
    private func isNotificationYetToReachItsDestination() {
        if PushNotificationHandler.sharedInstance.isPushNotificationRecieved {
            postRemoteNotification()
        }
    }
    
    private func isNewsOrNotifications() -> Bool {
        if PushNotificationHandler.sharedInstance.notificationType == 1 {
            return isShowingNews
        } else if PushNotificationHandler.sharedInstance.notificationType == 2 {
            return isShowingNotifications
        }
        return true
    }
    
    internal func presentNotifiedViewController() {
        //1 News
        //2 Notifications
        //3 Magazine
        //4 Acheivers
        //5 News Letter
        //6 Course
        //7 Results
        //8 Questions
        
        print(PushNotificationHandler.sharedInstance.notificationType)
        PushNotificationHandler.sharedInstance.isPushNotificationRecieved = false
        let type = PushNotificationHandler.sharedInstance.notificationType
        switch type {
        case 1:
            loadTabBars(1)
        case 2:
            loadTabBars(3)
        case 3:
            let magazineViewController = UIStoryboard.loadMagazineViewController()
            navigationController?.pushViewController(magazineViewController, animated: true)
        case 4:
            let acheiversViewController = UIStoryboard.loadAcheiversViewController()
            navigationController?.pushViewController(acheiversViewController, animated: true)
        case 5:
            let newsLetterViewController = UIStoryboard.loadNewsLetterViewController()
            navigationController?.pushViewController(newsLetterViewController, animated: true)
        case 6:
            let courseDetailViewController = UIStoryboard.loadCourseDetailViewController()
            navigationController?.pushViewController(courseDetailViewController, animated: true)
        case 7:
            let resultsViewController = UIStoryboard.loadResultsViewController()
            navigationController?.pushViewController(resultsViewController, animated: true)
        case 8:
            let questionPaperViewController = UIStoryboard.loadQuestionPapersViewController()
            navigationController?.pushViewController(questionPaperViewController, animated: true)
        default:
            break
        }
    }
    
    private func loadTabBars(_ type: CGFloat) {
        animateIndicator(index: type)
        animateScrollView(point: CGPoint(x: type * screenWidth, y: 0))
    }
}
