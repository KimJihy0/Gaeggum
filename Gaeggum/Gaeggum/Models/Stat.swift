//
//  Stat.swift
//  Scene1
//
//  Created by zeroStone ⠀ on 2022/04/18.
//

import Foundation

struct Stat : Codable {
    var data: Int = 0           // data
    var system: Int = 0         // system
    var userFriendly : Int = 0  // UI, UX
    var math: Int = 0           // 수학적 능력
    var collaboration : Int = 0 // 협업 능력
    
    mutating func addStat(answerStat: Stat) {
        self.data += answerStat.data
        self.system += answerStat.system
        self.userFriendly += answerStat.userFriendly
        self.math += answerStat.math
        self.collaboration += answerStat.collaboration
    }
    
    func calculateMSE(userStat: Stat) -> Double {
        var sum : Int = 0
        if self.data < userStat.data {
            sum += square(x: self.data - userStat.data)
        }
        if self.system < userStat.system {
            sum += square(x: self.system - userStat.system)
        }
        if self.userFriendly < userStat.userFriendly {
            sum += square(x: self.userFriendly - userStat.userFriendly)
        }
        if self.math < userStat.math {
            sum += square(x: self.math - userStat.math)
        }
        if self.collaboration < userStat.collaboration {
            sum += square(x: self.collaboration - userStat.collaboration)
        }
        
        return Double(sum)/5
    }
    
    func square(x : Int) -> Int{
//        print(x*x)
        return x*x
    }
}
