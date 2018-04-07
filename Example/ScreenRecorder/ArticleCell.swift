//
//  ArticleCell.swift
//  ScreenRecorder_Example
//
//  Created by Mikayel Aghasyan on 4/6/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import SwiftyJSON

class ArticleCell: UITableViewCell {
    var article: JSON! {
        didSet {
            self.textLabel?.text = article["title"].string
            self.detailTextLabel?.text = article["description"].string
        }
    }
}
