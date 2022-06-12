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
        question: "주소창에 \"www.naver.com\"을 치면 나는 ...asdfasdfasdfasdfasdfasdf",
        answer: [("A. 네트워크 상에서 어떤 식으로 데이터가 오고 가는지 궁금해!",
                  Stat(data: 1, system: 1, userFriendly: 0, math: 0, collaboration: 0)),
                 ("B. 화면에 나오는 UI 구성을 어떻게 더 쓰기 쉽게 바꿀지 궁금해!ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ",
                  Stat(data: 0, system: 1, userFriendly: 1, math: 0, collaboration: 0)),
                 ("C. 둘 다 노잼 ㅋ. 차라리 딴 거 할래",
                  Stat(data: 0, system: 0, userFriendly: 0, math: 0, collaboration: 0)),
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
