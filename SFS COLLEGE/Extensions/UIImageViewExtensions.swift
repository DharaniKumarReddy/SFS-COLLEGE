//
//  UIImageViewExtensions.swift
//  BREADS
//
//  Created by Dharani Reddy on 13/12/18.
//  Copyright © 2018 Integro Infotech. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIView.ContentMode) {
        if image == nil {
            image = #imageLiteral(resourceName: "default_image")
        }
        if let url = URL(string: link) {
            URLSession.shared.dataTask( with: url, completionHandler: {
                (data, response, error) -> Void in
                DispatchQueue.main.async {
                    self.contentMode =  contentMode
                    if let data = data {
                        self.image = UIImage(data: data) ?? #imageLiteral(resourceName: "default_image")
                    } else {
                        self.image = #imageLiteral(resourceName: "default_image")
                    }
                }
            }).resume()
        } else {
            image = #imageLiteral(resourceName: "default_image")
        }
    }
}
