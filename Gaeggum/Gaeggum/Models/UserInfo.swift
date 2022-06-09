//
//  UserInfo.swift
//  Scene1
//
//  Created by zeroStone ⠀ on 2022/04/18.
//

import Foundation

struct UserInfo : Codable {
    var career : Career?
    var stat : Stat?
    var gitID : String?
    var bojID : String?
    
    mutating func updateStat(newStat: Stat) {
        self.stat = newStat
        updateCareer()
    }
    
    mutating func updateCareer() {
        self.career = findBestCareer()
    }
    
    private func findBestCareer() -> Career {
        var bestIndex : Int = -1
        var bestMSE : Double = Double.greatestFiniteMagnitude
        dummyCareer.enumerated().forEach { (index, eachCareer) in
            let tempMSE : Double = eachCareer.stat.calculateMSE(compare: self.stat!)
            
//            print("여기에요", index, eachCareer.name, eachCareer.stat, tempMSE )
            if bestMSE > tempMSE {
                bestIndex = index
                bestMSE = tempMSE
            }
        }
        let bestCareer : Career = dummyCareer[bestIndex]
        return bestCareer
        
    }
    
    //localDB 저장
    static let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentDirectory.appendingPathComponent("userinfo").appendingPathExtension("plist")
    
    static func loadUserInfo() -> UserInfo? {
        guard let codedUserInfo = try? Data(contentsOf: archiveURL) else {
            return nil
        }
        
        //decoding
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(UserInfo.self, from: codedUserInfo)
    }
    
    static func saveUserInfo(_ userInfo: UserInfo) {
        //encoding
        let propertyListEncoder = PropertyListEncoder()
        let encodedUserInfo = try? propertyListEncoder.encode(userInfo)

        try? encodedUserInfo?.write(to: archiveURL, options: .noFileProtection)
    }

    static func loadTestUser() -> UserInfo {
        return UserInfo(career: testCareer, stat: Stat(data: 2, system: 3, userFriendly: 0, math: 5, collaboration: 2))
    }
}
