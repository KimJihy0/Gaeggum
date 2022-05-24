//
//  UserInfo.swift
//  Scene1
//
//  Created by zeroStone ⠀ on 2022/04/18.
//

import Foundation

struct UserInfo {
    var career : Career?
    var stat : Stat
}

func getTestUser()->UserInfo{
    return UserInfo(career: testCareer, stat: Stat(data: 2, system: 3, userFriendly: 0, math: 5, collaboration: 2))

}
