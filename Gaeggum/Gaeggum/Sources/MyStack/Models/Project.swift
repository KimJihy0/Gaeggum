//
//  Project.swift
//  Gaeggum
//
//  Created by Jihyo on 2022/05/12.
//

import Foundation
import UIKit

struct Project {
    var startDate: Date
    var endDate: Date?
    var content: String
    var term: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM"
        var term = formatter.string(from: startDate) + " ~"
        if let endDate = endDate {
            term = term + "\n" + formatter.string(from: endDate)
        }
        return term
    }
    var view: UIView {
        let projectView = UIView()
        
        let line = UIView()
        projectView.addSubview(line)
        line.backgroundColor = .darkGray
        line.anchor(top: projectView.topAnchor, left: projectView.leftAnchor, bottom: projectView.bottomAnchor, paddingLeft: 10, width: 2)
        
        let circle = RoundView()
        projectView.addSubview(circle)
        circle.backgroundColor = .white
        circle.borderWidth = 1
        circle.borderColor = .darkGray
        circle.cornerRadius = 3
        circle.anchor(width: 7, height: 14, centerX: line.centerXAnchor, centerY: projectView.centerYAnchor)
        
        let termLabel = UILabel()
        projectView.addSubview(termLabel)
        termLabel.text = self.term
        termLabel.textColor = .darkGray
        termLabel.numberOfLines = 2
        termLabel.anchor(top: projectView.topAnchor, left: line.rightAnchor, bottom: projectView.bottomAnchor, paddingTop: 5, paddingLeft: 15, width: 90)
        
        let contentLabel = UILabel()
        projectView.addSubview(contentLabel)
        contentLabel.text = self.content
        contentLabel.numberOfLines = 0
        contentLabel.anchor(top: projectView.topAnchor, left: termLabel.rightAnchor, bottom: projectView.bottomAnchor, right: projectView.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5)
        
        return projectView
    }
}
