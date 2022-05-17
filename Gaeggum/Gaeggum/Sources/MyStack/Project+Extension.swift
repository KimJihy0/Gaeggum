//
//  Project.swift
//  Gaeggum
//
//  Created by Jihyo on 2022/05/12.
//

import Foundation
import UIKit

extension Project: CustomStringConvertible, Comparable {
    
    var term: String {
        "\(self.startDate.string) ~" + (self.isOnGoing ? "" : "\n\(self.endDate!.string)")
    }
    
    var detailTerm: String {
        if (self.isOnGoing) {
            return "\(self.startDate.year)년 \(self.startDate.month)월부터\n진행 중"
        } else if self.startDate == self.endDate {
            return  "\(self.startDate.year)년 \(self.startDate.month)월"
        } else {
            return "\(self.startDate.year)년 \(self.startDate.month)월부터\n\(self.endDate!.year)년 \(self.endDate!.month)월까지"
        }
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
        termLabel.numberOfLines = 0
        termLabel.anchor(top: projectView.topAnchor, left: line.rightAnchor, bottom: projectView.bottomAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 10, width: 90)

        let contentLabel = UILabel()
        projectView.addSubview(contentLabel)
        contentLabel.text = self.title
        contentLabel.numberOfLines = 0
        contentLabel.anchor(top: projectView.topAnchor, left: termLabel.rightAnchor, bottom: projectView.bottomAnchor, right: projectView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10)

        return projectView
    }
    
    var description: String {
        return """
            title: \(self.title)
            term: \(self.startDate.string) ~ \(isOnGoing ? "" : self.endDate!.string)
            content:
            \(content)
            """
    }
    
    static func == (lhs: Project, rhs: Project) -> Bool {
        return lhs.title == rhs.title &&
        lhs.startDate == rhs.startDate &&
        lhs.endDate == rhs.endDate &&
        lhs.isOnGoing == rhs.isOnGoing &&
        lhs.content == rhs.content
    }
    
    static func < (lhs: Project, rhs: Project) -> Bool {
        return lhs.startDate < rhs.startDate || (lhs.startDate == rhs.startDate && lhs.endDate ?? YearMonth() < rhs.endDate ?? YearMonth())
    }

}
