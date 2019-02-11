//
//  APICaller.swift
//  SFS COLLEGE
//
//  Created by Dharani Reddy on 24/01/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import Foundation

typealias OnSuccessResponse = (String) -> Void
typealias OnDestroySuccess = () -> Void
typealias OnCancelSuccess = () -> Void
typealias OnErrorMessage = (String) -> Void

typealias JSONDictionary = [String : AnyObject]

private enum RequestMethod: String, CustomStringConvertible {
    case GET = "GET"
    case PUT = "PUT"
    case POST = "POST"
    case DELETE = "DELETE"
    case PATCH  = "PATCH"
    
    var description: String {
        return rawValue
    }
}

class APICaller {
    let MAX_RETRIES = 2
    
    fileprivate var urlSession: URLSession
    
    class func getInstance() -> APICaller {
        struct Static {
            static let instance = APICaller()
        }
        return Static.instance
    }
    
    fileprivate init() {
        urlSession = APICaller.createURLSession()
    }
    
    fileprivate class func createURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.urlCache = nil
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        //        configuration.httpAdditionalHeaders = [
        //            "Accept"       : "application/json",
        //        ]
        
        return URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    fileprivate func resetURLSession() {
        urlSession.invalidateAndCancel()
        urlSession = APICaller.createURLSession()
    }
    
    fileprivate func createRequest(_ requestMethod: RequestMethod, _ route: Route, params: JSONDictionary? = nil) -> URLRequest {
        let request = NSMutableURLRequest(url: route.absoluteURL as URL)
        request.httpMethod = requestMethod.rawValue
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        if let params = params {
            switch requestMethod {
            case .GET, .DELETE:
                var queryItems: [URLQueryItem] = []
                
                for (key, value) in params {
                    queryItems.append(URLQueryItem(name: "\(key)", value: "\(value)"))
                }
                
                if queryItems.count > 0 {
                    var components = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)
                    components?.queryItems = queryItems
                    request.url = components?.url
                }
                
            case .POST, .PUT, .PATCH:
                var bodyParams = ""
                for (key, value) in params {
                    bodyParams += "\(key)=" + "\(value)"
                }
                let postData = bodyParams.data(using: String.Encoding.ascii, allowLossyConversion: true)!
                //let body = try JSONSerialization.data(withJSONObject: params, options: [])
                request.httpBody = postData
            }
        }
        return request as URLRequest
    }
    
    fileprivate func enqueueRequest(_ requestMethod: RequestMethod, _ route: Route, params: JSONDictionary? = nil, retryCount: Int = 0, onSuccessResponse: @escaping (String) -> Void, onErrorMessage: @escaping OnErrorMessage) {
        
        let urlRequest = createRequest(requestMethod, route, params: params)
        print("URL-> \(urlRequest)")
        let dataTask = urlSession.dataTask(with: urlRequest, completionHandler: { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                var statusCode = httpResponse.statusCode
                var responseString:String = ""
                if let responseData = data {
                    responseString = NSString(data: responseData, encoding: String.Encoding.utf8.rawValue) as String? ?? ""
                }else {
                    statusCode = 450
                }
                print(responseString)
                switch statusCode {
                case 200...299:
                    // Success Response
                    
                    onSuccessResponse(responseString)
                    
                    
                default:
                    // Failure Response
                    let errorMessage = "Error Code: \(statusCode)"
                    onErrorMessage(errorMessage)
                }
                
            } else if let error = error {
                var errorMessage: String
                switch error._code {
                case NSURLErrorNotConnectedToInternet:
                    errorMessage = "Net Lost"//Constant.ErrorMessage.InternetConnectionLost
                case NSURLErrorNetworkConnectionLost:
                    if retryCount < self.MAX_RETRIES {
                        self.enqueueRequest(requestMethod, route, params: params, retryCount: retryCount + 1, onSuccessResponse: onSuccessResponse, onErrorMessage: onErrorMessage)
                        return
                        
                    } else {
                        errorMessage = error.localizedDescription
                    }
                default:
                    errorMessage = error.localizedDescription
                }
                onErrorMessage(errorMessage)
                
            } else {
                assertionFailure("Either an httpResponse or an error is expected")
            }
        })
        dataTask.resume()
    }
    
    internal func getCoverPhotos(onSuccess: @escaping ([CoverPhoto]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .coverPhotos, params: ["updated_date" : "2016-12-20 02:02:52" as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseCoverPhotos(response, onSuccess: { photos in
                onSuccess(photos)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getCoursesList(onSuccess: @escaping ([Course]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .courses, params: ["updated_date" : "2016-12-20 02:02:52" as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseCourseList(response, onSuccess: { courses in
                onSuccess(courses)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getNews(onSuccess: @escaping ([News]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .news, params: ["updated_date" : "2016-12-20 02:02:52" as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseNews(response, onSuccess: { news in
                onSuccess(news)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getNewsImages(id: String, onSuccess: @escaping ([NewsImage]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(
            .POST, .newsImages, params: ["news_id" : id as AnyObject], onSuccessResponse: { response in
                Parser.sharedInstance.parseNewsImages(response, onSuccess: { newsImages in
                    onSuccess(newsImages)
                })
        }, onErrorMessage: {_ in})
    }
    
    internal func getNotifiction(onSuccess: @escaping ([Notification]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .notification, params: ["updated_date" : "2016-12-20 02:02:52" as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseNotifications(response, onSuccess: { notifications in
                onSuccess(notifications)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getAboutUsListItems(onSuccess: @escaping ([AboutUsItem]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .aboutUs, params: ["updated_date" : "2017-03-28 04:12:56" as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseAboutUsItems(response, onSuccess: { items in
                onSuccess(items)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getAcheivers(onSuccess: @escaping ([Achiever]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .acheivers, params: ["updated_date" : "2017-03-28 04:12:56" as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseAcheivers(response, onSuccess: { acheivers in
                onSuccess(acheivers)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getNewsLetter(onSuccess: @escaping ([NewsLetter]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .newsLetter, params: ["updated_date" : "2017-03-28 04:12:56" as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseNewsLetters(response, onSuccess: { letters in
                onSuccess(letters)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getPrincipalDeskItems(onSuccess: @escaping ([PrincipalDesk]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .principalDesk, params: ["updated_date" : "2017-03-28 04:12:56" as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parsePrincipalDeskItems(response, onSuccess: { items in
                onSuccess(items)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getOurCollegeMagazines(onSuccess: @escaping ([Magazine]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .ourMagazineList, params: ["updated_date" : "2017-03-28 04:12:56" as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseMagazineList(response, onSuccess: { magazines in
                onSuccess(magazines)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getQuestionPapers(onSuccess: @escaping ([QuestionPaper]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(
            .POST, .questionPapers, params: ["updated_date" : "2017-11-12 01:11:25" as AnyObject], onSuccessResponse: { response in
                Parser.sharedInstance.parseQuestionPapers(response, onSuccess: { papers in
                onSuccess(papers)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getSemisterPapers(questionId: String, onSuccess: @escaping ([SemisterPaper]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .semisterPapers, params: ["q_id" : questionId as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseSemisterpapers(response, onSuccess: { papers in
                onSuccess(papers)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getPapers(semisterId: String, onSuccess: @escaping ([Paper]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .papers, params: ["q_id" : semisterId as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parsePapers(response, onSuccess: { papers in
                onSuccess(papers)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getResults(onSuccess: @escaping ([Result]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(
            .POST, .results, params: ["updated_date" : "2017-11-14 01:48:30" as AnyObject], onSuccessResponse: { response in
                Parser.sharedInstance.parseResults(response, onSuccess: { results in
                    onSuccess(results)
                })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
    
    internal func getManagementTeamDetails(onSuccess: @escaping ([ManagementTeam]) -> Void, onError: @escaping OnErrorMessage) {
        enqueueRequest(.POST, .managementTeam, params: ["updated_date" : "2017-03-28 04:12:56" as AnyObject], onSuccessResponse: { response in
            Parser.sharedInstance.parseManagementTeams(response, onSuccess: { teams in
                onSuccess(teams)
            })
        }, onErrorMessage: { error in
            onError(error)
        })
    }
}
