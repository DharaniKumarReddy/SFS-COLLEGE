//
//  TopViewController.swift
//  Franziskaner Munchen
//
//  Created by Dharani Reddy on 30/09/18.
//  Copyright © 2018 Integro Infotech. All rights reserved.
//

import Foundation
import UIKit

class TopViewController {
    class func isNotifiedController() -> Bool {
        switch PushNotificationHandler.sharedInstance.notificationType {
        case 1:
            return UIApplication.topViewController() is DashboardViewController
        case 2:
            return UIApplication.topViewController() is DashboardViewController
        case 3:
            return UIApplication.topViewController() is OurMagazineViewController
        case 4:
            return UIApplication.topViewController() is AcheiversViewController
        case 5:
            return UIApplication.topViewController() is NewsLetterViewController
        case 6:
            return UIApplication.topViewController() is CourseDetailViewController
        case 7:
            return UIApplication.topViewController() is ResultsViewController
        case 8:
            return UIApplication.topViewController() is QuestionPapersViewController
        default:
            return UIApplication.topViewController() is DashboardViewController
        }
    }
}
