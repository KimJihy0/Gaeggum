//
//  Project.swift
//  Gaeggum
//
//  Created by zeroStone ⠀ on 2022/05/14.
//

import Foundation

struct Project: Codable{
    var startDate: Date
    var endDate: Date?
    var title: String? // 추후 지효 컨트롤러 수정 후 optional 뺄 것
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
        let project1 = Project(startDate: Date(), endDate: Date(), content: "소스 개꿈을 만들었다. 참 즐거웠다.")
        let project2 = Project(startDate: Date(), endDate: Date(), content: "하이루")
        let project3 = Project(startDate: Date(), endDate: Date(), content: "룰루랄라")
        return [project1, project2, project3]
    }


}



