//
//  Parser.swift
//  SFS COLLEGE
//
//  Created by Dharani Reddy on 24/01/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import Foundation

struct CoverPhoto: Codable {
    var id: String
    var image: String
    var updatedDate: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", image = "img", updatedDate = "updated_date"
    }
}

struct CoverPhotosArray: Codable {
    var photos: [CoverPhoto]
    var success: Int
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case photos = "coverphoto", success = "success", message = "message"
    }
}

struct Course: Codable {
    var id: String
    var image: String
    var title: String
    var description: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", image = "image", title = "title", description = "description"
    }
}

struct CourseList: Codable {
    var message: String
    var success: Int
    var courses: [Course]
    
    private enum CodingKeys: String, CodingKey {
        case message = "message", success = "success", courses = "course"
    }
}

struct News: Codable {
    var id: String
    var largeImage: String
    var smallImage: String
    var title: String
    var date: String
    var description: String
    var updatedDate: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", largeImage = "largeimage", smallImage = "smallimage", title = "title", date = "date1", description = "description", updatedDate = "updated_date"
    }
}

struct NewsArray: Codable {
    var news: [News]
    var success: Int
    
    private enum CodingKeys: String, CodingKey {
        case news = "news", success = "success"
    }
}

struct Notification: Codable {
    var id: String
    var title: String
    var date: String
    var description: String
    var updatedAt: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", title = "title", date = "date", description = "description", updatedAt = "updated_at"
    }
}

struct Notifications: Codable {
    var success: Int
    var message: String
    var notifications: [Notification]
    
    private enum CodingKeys: String, CodingKey {
        case success = "success", message = "message", notifications = "notification"
    }
}

struct NewsImage: Codable {
    var id: String
    var newsId: String
    var image: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", newsId = "news_id", image = "img"
    }
}

struct NewsImages: Codable {
    var newsImages: [NewsImage]
    var success: Int
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case success = "success", message = "message", newsImages = "newsimages"
    }
}

struct AboutUsItem: Codable {
    var id: String
    var image: String
    var title: String
    var content: String
    var updatedDate: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", image = "img", title = "title", content = "content", updatedDate = "updated_date"
    }
}

struct AboutsUsItems: Codable {
    var items: [AboutUsItem]
    var success: Int
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case items = "aboutus", success = "success", message = "message"
    }
}

struct Achiever: Codable {
    var name: String
    var image: String
    var description: String
    var updatedDate: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "name", image = "image", description = "description", updatedDate = "updated_date"
    }
}

struct Achievers: Codable {
    var achievers: [Achiever]
    var success: Int
    
    private enum CodingKeys: String, CodingKey {
        case achievers = "achievers", success = "success"
    }
}

struct NewsLetter: Codable {
    var id: String
    var image: String
    var name: String
    var urlPdf: String
    var updatedDate: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", name = "name", image = "image", urlPdf = "url_pdf", updatedDate = "updated_date"
    }
}

struct NewsLetters: Codable {
    var newsLetters: [NewsLetter]
    var success: Int
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case newsLetters = "newsletter", success = "success", message = "message"
    }
}

struct PrincipalDesk: Codable {
    var id: String
    var image: String
    var content: String
    var updatedDate: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", image = "img", content = "content", updatedDate = "updated_date"
    }
}

struct PrincipalDeskList: Codable {
    var principalDeskList: [PrincipalDesk]
    var success: Int
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case principalDeskList = "principal", success = "success", message = "message"
    }
}

struct Magazine: Codable {
    var id: String
    var image: String
    var title: String
    var urlPdf: String
    var updatedDate: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", image = "image", title = "title", urlPdf = "url_pdf", updatedDate = "updated_date"
    }
}

struct MagazineList: Codable {
    var magazines: [Magazine]
    var success: Int
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case magazines = "magazine", success = "success", message = "message"
    }
}

struct QuestionPaper: Codable {
    var id: String
    var name: String
    var updatedDate: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", name = "name", updatedDate = "updated_date"
    }
}

struct QuestionPapers: Codable {
    var papers: [QuestionPaper]
    var success: Int
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case papers = "question", success = "success", message = "message"
    }
}

struct SemisterPaper: Codable {
    var id: String
    var name: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", name = "name"
    }
}

struct SemisterPapers: Codable {
    var success: Int
    var message: String
    var data: [SemisterPaper]
    
    private enum CodingKeys: String, CodingKey {
        case success = "success", message = "message", data = "data"
    }
}

struct Paper: Codable {
    var id: String
    var name: String
    var pdf: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", name = "name", pdf = "pdf"
    }
}
struct Papers: Codable {
    var data: [Paper]
    var success: Int
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case data = "data1", success = "success", message = "message"
    }
}

struct Result: Codable {
    var id: String
    var name: String
    var description: String
    var pdf: String
    var updatedDate: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", name = "name", description = "description", pdf = "pdf", updatedDate = "updated_date"
    }
}

struct Results: Codable {
    var results: [Result]
    var success: Int
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case results = "result", success = "success", message = "message"
    }
}

struct ManagementTeam: Codable {
    var id: String
    var name: String
    var image: String
    var designation: String
    var updatedDate: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", name = "name", image = "image", designation = "designation", updatedDate = "updated_date"
    }
}

struct ManagementTeams: Codable {
    var teams: [ManagementTeam]
    var success: Int
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case teams = "mgteam", success = "success", message = "message"
    }
}

class Parser {
    static let sharedInstance = Parser()
    private init() {}
    
    internal func parseCoverPhotos(_ jsonString: String, onSuccess: ([CoverPhoto]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(CoverPhotosArray.self, from: Data(jsonString.utf8))
            var photosArray: [CoverPhoto] = []
            for photo in decodedData.photos {
                let photo = CoverPhoto(id: photo.id, image: photo.image, updatedDate: photo.updatedDate)
                photosArray.append(photo)
            }
            onSuccess(photosArray)
        } catch {
            print(error)
        }
    }
    
    internal func parseCourseList(_ jsonString: String, onSuccess: ([Course]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(CourseList.self, from: Data(jsonString.utf8))
            var courses: [Course] = []
            for course in decodedData.courses {
                let course = Course(id: course.id, image: course.image, title: course.title, description: course.description)
                courses.append(course)
            }
            onSuccess(courses)
        } catch {
            print(error)
        }
    }
    
    internal func parseNews(_ jsonString: String, onSuccess: ([News]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(NewsArray.self, from: Data(jsonString.utf8))
            var newsArray: [News] = []
            for newsObject in decodedData.news {
                let news = News(id: newsObject.id, largeImage: newsObject.largeImage, smallImage: newsObject.smallImage, title: newsObject.title, date: newsObject.date, description: newsObject.description, updatedDate: newsObject.updatedDate)
                newsArray.append(news)
            }
            onSuccess(newsArray)
        } catch {
            print(error)
        }
    }
    
    internal func parseNotifications(_ jsonString: String, onSuccess: ([Notification]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(Notifications.self, from: Data(jsonString.utf8))
            var notifications: [Notification] = []
            for notification in decodedData.notifications {
                let notificationObject = Notification(id: notification.id, title: notification.title, date: notification.date, description: notification.description, updatedAt: notification.updatedAt)
                notifications.append(notificationObject)
            }
            onSuccess(notifications)
        } catch {
            print(error)
        }
    }
    
    internal func parseNewsImages(_ jsonString: String, onSuccess: ([NewsImage]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(NewsImages.self, from: Data(jsonString.utf8))
            var newsImages: [NewsImage] = []
            for newsImage in decodedData.newsImages {
                let newsImageObject = NewsImage(id: newsImage.id, newsId: newsImage.newsId, image: newsImage.image)
                newsImages.append(newsImageObject)
            }
            onSuccess(newsImages)
        } catch {
            print(error)
        }
    }
    
    internal func parseAboutUsItems(_ jsonString: String, onSuccess: ([AboutUsItem]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(AboutsUsItems.self, from: Data(jsonString.utf8))
            var listItems: [AboutUsItem] = []
            for item in decodedData.items {
                let aboutUsItem = AboutUsItem(id: item.id, image: item.image, title: item.title, content: item.content, updatedDate: item.updatedDate)
                listItems.append(aboutUsItem)
            }
            onSuccess(listItems)
        } catch {
            print(error)
        }
    }
    
    internal func parseAcheivers(_ jsonString: String, onSuccess: ([Achiever]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(Achievers.self, from: Data(jsonString.utf8))
            var acheivers: [Achiever] = []
            for acheiver in decodedData.achievers {
                let acheiverObject = Achiever(name: acheiver.name, image: acheiver.image, description: acheiver.description, updatedDate: acheiver.updatedDate)
                acheivers.append(acheiverObject)
            }
            onSuccess(acheivers)
        } catch {
            print(error)
        }
    }
    
    internal func parseNewsLetters(_ jsonString: String, onSuccess: ([NewsLetter]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(NewsLetters.self, from: Data(jsonString.utf8))
            var newsLetters: [NewsLetter] = []
            for letter in decodedData.newsLetters {
                let newsLetter = NewsLetter(id: letter.id, image: letter.image, name: letter.name, urlPdf: letter.urlPdf, updatedDate: letter.updatedDate)
                newsLetters.append(newsLetter)
            }
            onSuccess(newsLetters)
        } catch {
            print(error)
        }
    }
    
    internal func parsePrincipalDeskItems(_ jsonString: String, onSuccess: ([PrincipalDesk]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(PrincipalDeskList.self, from: Data(jsonString.utf8))
            var deskItems: [PrincipalDesk] = []
            for deskItem in decodedData.principalDeskList {
                let principalDesk = PrincipalDesk(id: deskItem.id, image: deskItem.image, content: deskItem.content, updatedDate: deskItem.content)
                deskItems.append(principalDesk)
            }
            onSuccess(deskItems)
        } catch {
            print(error)
        }
    }
    
    internal func parseMagazineList(_ jsonString: String, onSuccess: ([Magazine]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(MagazineList.self, from: Data(jsonString.utf8))
            var magazines: [Magazine] = []
            for magazine in decodedData.magazines {
                let magazineItem = Magazine(id: magazine.id, image: magazine.image, title: magazine.title, urlPdf: magazine.urlPdf, updatedDate: magazine.updatedDate)
                magazines.append(magazineItem)
            }
            onSuccess(magazines)
        } catch {
            print(error)
        }
    }
    
    internal func parseQuestionPapers(_ jsonString: String, onSuccess: ([QuestionPaper]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(QuestionPapers.self, from: Data(jsonString.utf8))
            var papers: [QuestionPaper] = []
            for paper in decodedData.papers {
                let questionPaper = QuestionPaper(id: paper.id, name: paper.name, updatedDate: paper.updatedDate)
                papers.append(questionPaper)
            }
            onSuccess(papers)
        } catch {
            print(error)
        }
    }
    
    internal func parseResults(_ jsonString: String, onSuccess: ([Result]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(Results.self, from: Data(jsonString.utf8))
            var results: [Result] = []
            for result in decodedData.results {
                let resultObject = Result(id: result.id, name: result.name, description: result.description, pdf: result.pdf, updatedDate: result.updatedDate)
                results.append(resultObject)
            }
            onSuccess(results)
        } catch {
            print(error)
        }
    }
    
    internal func parseSemisterpapers(_ jsonString: String, onSuccess: ([SemisterPaper]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(SemisterPapers.self, from: Data(jsonString.utf8))
            var semisterPapers: [SemisterPaper] = []
            for paper in decodedData.data {
                let semisterPaper = SemisterPaper(id: paper.id, name: paper.name)
                semisterPapers.append(semisterPaper)
            }
            onSuccess(semisterPapers)
        } catch {
            print(error)
        }
    }
    
    internal func parsePapers(_ jsonString: String, onSuccess: ([Paper]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(Papers.self, from: Data(jsonString.utf8))
            var papers: [Paper] = []
            for paper in decodedData.data {
                let paperObject = Paper(id: paper.id, name: paper.name, pdf: paper.pdf)
                papers.append(paperObject)
            }
            onSuccess(papers)
        } catch {
            print(error)
        }
    }
    
    internal func parseManagementTeams(_ jsonString: String, onSuccess: ([ManagementTeam]) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(ManagementTeams.self, from: Data(jsonString.utf8))
            var teams: [ManagementTeam] = []
            for team in decodedData.teams {
                let managementTeam = ManagementTeam(id: team.id, name: team.name, image: team.image, designation: team.designation, updatedDate: team.updatedDate)
                teams.append(managementTeam)
            }
            onSuccess(teams)
        } catch {
            print(error)
        }
    }
}
