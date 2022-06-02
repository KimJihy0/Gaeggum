//
//  Hashtag.swift
//  Gaeggum
//
//  Created by 상현 on 2022/06/02.
//

import Foundation
import UIKit

let colorList = [
    UIColor.red,
    UIColor.orange,
    UIColor.yellow,
    UIColor.green,
    UIColor.cyan,
    UIColor.blue,
    UIColor.purple,
    UIColor.brown,
    UIColor.lightGray,
    UIColor.magenta
]

struct Hashtag {
    let ability : Ability
    let tagColor : UIColor
    var selected : Bool
}


let dummyTag = updateDummyTag()

func updateDummyTag() -> [Hashtag] {
    var returnValue : [Hashtag] = []
    
    var index = 0
    Ability.allCases.forEach {
        let tag = Hashtag(
            ability: $0,
            tagColor: colorList[index],
            selected: false
        )
        index += 1
        returnValue.append(tag)
    }
    
    return returnValue
}

