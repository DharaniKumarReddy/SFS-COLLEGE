//
//  Route.swift
//  SFS COLLEGE
//
//  Created by Dharani Reddy on 24/01/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import Foundation

let Base_Url = "http://sfscollege.in"

enum Route {
    case notification
    case coverPhotos
    case courses
    case news
    case newsImages
    case aboutUs
    case acheivers
    case newsLetter
    case principalDesk
    case ourMagazineList
    case questionPapers
    case semisterPapers
    case papers
    case results
    case managementTeam
    
    var absoluteURL: URL {
        return URL(string: Base_Url + apiPath)!
    }
    
    private var apiPath: String {
        switch self {
        case .notification:
            return "/sfscollege_app/sfs_notification.php"
        case .coverPhotos:
            return "/sfscollege_app/coverphoto.php"
        case .courses:
            return "/sfscollege_app/sfs_course.php"
        case .news:
            return "/sfscollege_app/input_form.php"
        case .newsImages:
            return "/sfscollege_app/sfs_images.php"
        case .aboutUs:
            return "/sfscollege_app/sfs_about.php"
        case .acheivers:
            return "/sfscollege_app/achievers_input.php"
        case .newsLetter:
            return "/sfscollege_app/sfs_newsletter.php"
        case .principalDesk:
            return "/sfscollege_app/sfs_principal.php"
        case .ourMagazineList:
            return "/sfscollege_app/sfs_magazine.php"
        case .questionPapers:
            return "/sfscollege_app/sfs_question.php"
        case .semisterPapers:
            return "/sfscollege_app/sfs_question1.php"
        case .results:
            return "/sfscollege_app/sfs_result.php"
        case .papers:
            return "/sfscollege_app/sfs_question2.php"
        case .managementTeam:
            return "/sfscollege_app/sfs_mgteam.php"
        }
    }
}
