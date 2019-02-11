//
//  UIHelper.swift
//  SFS COLLEGE
//
//  Created by Dharani Reddy on 24/01/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import Foundation
import UIKit

class WhiteBorderView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        whiteBorderView(self, border: 1.0)
    }
}

class BlueBorderView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        blueBorderView(self, border: 1.0)
    }
}

class SemiBoldTitleLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        font = UIFont.systemFont(ofSize: ["Low" : 14, "Medium" : 15, "High" : 16][getDeviceRange()] ?? 16, weight: .semibold)
    }
}

class TitleLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        font = UIFont.systemFont(ofSize: ["Low" : 14, "Medium" : 15, "High" : 16][getDeviceRange()] ?? 16)
    }
}

class DescriptionLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        font = UIFont.systemFont(ofSize: ["Low" : 12, "Medium" : 13, "High" : 14][getDeviceRange()] ?? 14)
    }
}

class RoundedImageView: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 80
        blueBorderView(self, border: 4.0)
    }
}

private func getDeviceRange() -> String {
    switch UIScreen.main.bounds.width {
    case 375:
        return "Medium"
    case 0...374:
        return "Low"
    default:
        return "High"
    }
}

private func whiteBorderView(_ view: UIView, border: CGFloat) {
    view.layer.borderWidth = 1.0
    view.layer.borderColor = UIColor.white.cgColor
}

class BlueBorderButon: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        blueBorderView(self, border: 1.0)
    }
}

private func blueBorderView(_ view: UIView, border: CGFloat) {
    view.layer.borderWidth = border
    view.layer.borderColor = UIColor(displayP3Red: 2/255, green: 79/255, blue: 140/255, alpha: 1.0).cgColor
}
