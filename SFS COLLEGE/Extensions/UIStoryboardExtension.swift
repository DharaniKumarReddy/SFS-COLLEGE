//
//  UIStoryboardExtension.swift
//  BREADS
//
//  Created by Dharani Reddy on 12/12/18.
//  Copyright © 2018 Integro Infotech. All rights reserved.
//

import Foundation
import UIKit

fileprivate enum Storyboard : String {
    case main = "Main"
    // add enum case for each storyboard in your project
}

fileprivate extension UIStoryboard {
    
    static func loadFromMain(_ identifier: String) -> UIViewController {
        return load(from: .main, identifier: identifier)
    }
    
    // optionally add convenience methods for other storyboards here ...
    
    // ... or use the main loading method directly when
    // instantiating view controller from a specific storyboard
    static func load(from storyboard: Storyboard, identifier: String) -> UIViewController {
        let uiStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return uiStoryboard.instantiateViewController(withIdentifier: identifier)
    }
}

// MARK: App View Controllers

extension UIStoryboard {
    class func loadNewsDetailViewController() -> NewsDetailedViewController {
        return loadFromMain(String(describing: NewsDetailedViewController.self)) as! NewsDetailedViewController
    }
    
    class func loadNotificationDetailViewController() -> NotificationDetailedViewController {
        return loadFromMain(String(describing: NotificationDetailedViewController.self)) as! NotificationDetailedViewController
    }
    
    class func loadWebViewController() -> WebViewController {
        return loadFromMain(String(describing: WebViewController.self)) as! WebViewController
    }
    
    class func loadAcheiverDetailViewController() -> AcheiverDetailViewController {
        return loadFromMain(String(describing: AcheiverDetailViewController.self)) as! AcheiverDetailViewController
    }
    
    class func loadCourseDetailViewController() -> CourseDetailViewController {
        return loadFromMain(String(describing: CourseDetailViewController.self)) as! CourseDetailViewController
    }
    
    class func loadQuestionPapersViewController() -> QuestionPapersViewController {
        return loadFromMain(String(describing: QuestionPapersViewController.self)) as! QuestionPapersViewController
    }
    
    class func loadSemisterQuestionViewController() -> SemisterQuestionPapersViewController {
        return loadFromMain(String(describing: SemisterQuestionPapersViewController.self)) as! SemisterQuestionPapersViewController
    }
    
    class func loadPapersViewController() -> PapersViewController {
        return loadFromMain(String(describing: PapersViewController.self)) as! PapersViewController
    }
    
    class func loadManagementTeamViewController() -> ManagementTeamViewController {
        return loadFromMain(String(describing: ManagementTeamViewController.self)) as! ManagementTeamViewController
    }
    
    class func loadMagazineViewController() -> OurMagazineViewController {
        return loadFromMain(String(describing: OurMagazineViewController.self)) as! OurMagazineViewController
    }
    
    class func loadAcheiversViewController() -> AcheiversViewController {
        return loadFromMain(String(describing: AcheiversViewController.self)) as! AcheiversViewController
    }
    
    class func loadNewsLetterViewController() -> NewsLetterViewController {
        return loadFromMain((String(describing: NewsLetterViewController.self))) as! NewsLetterViewController
    }
    
    class func loadResultsViewController() -> ResultsViewController {
        return loadFromMain(String(describing: ResultsViewController.self)) as! ResultsViewController
    }
}
