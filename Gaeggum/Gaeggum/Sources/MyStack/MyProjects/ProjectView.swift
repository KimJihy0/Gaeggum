//
//  ProjectView.swift
//  Gaeggum
//
//  Created by Jihyo on 2022/05/12.
//

import Foundation
import UIKit

func toView(_ project: Project) -> UIView {
    
    let newView = UIView()
    
    let line = UIView()
    line.backgroundColor = .darkGray
    newView.addSubview(line)
    line.anchor(top: newView.topAnchor, left: newView.leftAnchor, bottom: newView.bottomAnchor, paddingLeft: 10, width: 2)
    
    let circle = UIView()
    circle.backgroundColor = .white // junk
    circle.borderWidth = 1
    circle.borderColor = .darkGray
    circle.cornerRadius = 3
    newView.addSubview(circle)
    circle.anchor(width: 7, height: 14)
    circle.centerXAnchor.constraint(equalTo: line.centerXAnchor).isActive = true
    circle.centerYAnchor.constraint(equalTo: newView.centerYAnchor).isActive = true
    
    let termLabel = UILabel()
    termLabel.text = toTerm(project.startDate, project.endDate)
    termLabel.textColor = .darkGray
    termLabel.numberOfLines = 2
    newView.addSubview(termLabel)
    termLabel.anchor(top: newView.topAnchor, left: line.rightAnchor, bottom: newView.bottomAnchor, paddingTop: 5, paddingLeft: 15, width: 90)
    
    let contentLabel = UILabel()
    contentLabel.text = project.content
    contentLabel.numberOfLines = 0
    newView.addSubview(contentLabel)
    contentLabel.anchor(top: newView.topAnchor, left: termLabel.rightAnchor, bottom: newView.bottomAnchor, right: newView.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5)
    
    return newView
}

func toTerm(_ startDate: Date, _ endDate: Date?) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.MM"
    
    var term : String
    term = formatter.string(from: startDate) + " ~"
    if let endDate = endDate {
        term = term + "\n" + formatter.string(from: endDate)
    }
    
    return term
}
