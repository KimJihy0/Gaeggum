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
        contentLabel.font = UIFont.systemFont(ofSize: 20)
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
        return lhs.startDate == rhs.startDate && lhs.endDate == rhs.endDate
    }
    
    static func < (lhs: Project, rhs: Project) -> Bool {
        return lhs.startDate < rhs.startDate || (lhs.startDate == rhs.startDate && lhs.endDate ?? YearMonth() < rhs.endDate ?? YearMonth())
    }

}


struct YearMonth: Codable, Comparable {
    
    var year: Int
    var month: Int
    var string: String{
        return String(self.year) + "." + String(format: "%2d", self.month) + "."
    }
    
    init(_ year: Int = Calendar.current.component(.year, from: Date()),
         _ month: Int = Calendar.current.component(.month, from: Date())) {
        self.year = year
        self.month = month
    }
    
    static func < (lhs: YearMonth, rhs: YearMonth) -> Bool {
        return lhs.year < rhs.year || (lhs.year == rhs.year && lhs.month < rhs.month)
    }
}

