//
//  Project.swift
//  Gaeggum
//
//  Created by zeroStone ⠀ on 2022/05/14.
//

import Foundation

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

