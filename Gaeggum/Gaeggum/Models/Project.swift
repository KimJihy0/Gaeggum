//
//  Project.swift
//  Gaeggum
//
//  Created by zeroStone ⠀ on 2022/05/14.
//

import Foundation
import UIKit

struct Project: Codable {
    var title: String
    var startDate: YearMonth
    var endDate: YearMonth?
    var isOnGoing: Bool
    var content: String

    static let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentDirectory.appendingPathComponent("projects").appendingPathExtension("plist")
    
    static func loadProjects() -> [Project]? {
        guard let codedProjects = try? Data(contentsOf: archiveURL) else {
            return nil
        }
        
        //decoding
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<Project>.self, from: codedProjects)
    }
    
    static func saveProjects(_ projects: [Project]) {
        //encoding
        let propertyListEncoder = PropertyListEncoder()
        let encodedProjects = try? propertyListEncoder.encode(projects)

        try? encodedProjects?.write(to: archiveURL, options: .noFileProtection)
    }

    static func loadSampleProjects() -> [Project] {
        let project1 = Project(title: "소프트웨어스튜디오", startDate: YearMonth(2022, 3), isOnGoing: true, content: "소스 개꿈을 만들었다. 참 즐거웠다.")
        let project2 = Project(title: "코카콜라 맛있다", startDate: YearMonth(), endDate: YearMonth(), isOnGoing: false, content: "하이루")
        let project3 = Project(title: "프로젝트명3", startDate: YearMonth(1999, 5), isOnGoing: true, content: "룰루랄라")
        return [project1, project2, project3]
    }
}

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
    
    static func < (lhs: Project, rhs: Project) -> Bool {
        return lhs.startDate < rhs.startDate || (lhs.startDate == rhs.startDate && lhs.endDate ?? YearMonth() < rhs.endDate ?? YearMonth())
    }

}
