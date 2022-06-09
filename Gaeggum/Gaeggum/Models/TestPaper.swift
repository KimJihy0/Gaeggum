//
//  Question.swift
//  Gaeggum
//
//  Created by zeroStone ⠀ on 2022/05/24.
//

import Foundation

struct TestPaper{
    let question: String
    let answer: [(String, Stat)]
}

let dummyTestPaper = [
    TestPaper(
        question: "Q1",
        answer: [("A1-1",Stat(data: 2, system: 2, userFriendly: 0, math: 0, collaboration: 0)),
                 ("A1-2",Stat(data: 0, system: 1, userFriendly: 5, math: 0, collaboration: 0)),
                 ("A1-3",Stat(data: 0, system: 0, userFriendly: 1, math: 0, collaboration: 0)),
                ]
    ),
    TestPaper(
        question: "Q2",
        answer: [("A2-1",Stat(data: 1, system: 0, userFriendly: 0, math: 0, collaboration: 0)),
                 ("A2-2",Stat(data: 0, system: 1, userFriendly: 0, math: 0, collaboration: 0)),
                 ("A2-3",Stat(data: 0, system: 0, userFriendly: 1, math: 0, collaboration: 0)),
                ]
    ),
    TestPaper(
        question: "Q3",
        answer: [("A3-1",Stat(data: 1, system: 0, userFriendly: 0, math: 0, collaboration: 0)),
                 ("A3-2",Stat(data: 0, system: 1, userFriendly: 0, math: 0, collaboration: 0)),
                 ("A3-3",Stat(data: 0, system: 0, userFriendly: 1, math: 0, collaboration: 0)),
                ]
    ),
                 
                                 
]
