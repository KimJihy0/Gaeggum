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
        question: "주소창에 \"www.naver.com\"을 치면 나는...",
        answer: [("네트워크 상에서 어떤 식으로 데이터가 오고 가는지 궁금해!",
                  Stat(data: 2, system: 2, userFriendly: 0, math: 0, collaboration: 0)),
                 ("화면에 나오는 UI 구성을 어떻게 더 쓰기 쉽게 바꿀지 궁금해!",
                  Stat(data: 0, system: 1, userFriendly: 2, math: 0, collaboration: 0)),
                 ("둘 다 노잼 ㅋ. 차라리 딴 거 할래",
                  Stat(data: 0, system: 0, userFriendly: 0, math: 0, collaboration: 0)),
                ]
    ),
    TestPaper(
        question: "딥러닝 기술을 사용해보고 싶어서 팀을 꾸렸는데 나는 어떤 역할을 맡으면 좋을까?",
        answer: [("이론적인 부분이 궁금해. 좋은 모델을 만드는 법을 탐구하고, 논문을 찾아보는 나.. 좀 멋있을지도..?",Stat(data: 2, system: 2, userFriendly: 0, math: 3, collaboration: 1)),
                 ("실용적인 게 좋아. 좋은 모델이 나오면, 그걸 사용해서 실제 서비스에 사용해볼래",Stat(data: 1, system: 1, userFriendly: 1, math: 0, collaboration: 0)),
                 ("데이터 모으는 게 너무 재밌어. 오염된 데이터들을 제거하고, 좋은 데이터를 취합하는 역할을 할래",Stat(data: 2, system: 1, userFriendly: 0, math: 3, collaboration: 1)),
                 ("굳이 인공지능 팀 만들어야돼? 재미음서.",Stat(data: 0, system: 0, userFriendly: 1, math: 0, collaboration: 0)),
                ]
    ),
    TestPaper(
        question: "학기가 시작해서 수강신청을 해야해! 어떤 과목이 제일 끌리는 것 같아?",
        answer: [("데이터 사이언스 : 빅데이터를 분류하는 알고리즘도 배우고, 이를 활용해 추천 시스템을 만들고 싶어.",Stat(data: 1, system: 0, userFriendly: 0, math: 0, collaboration: 0)),
                 ("소프트웨어 공학 : 프로젝트를 어떻게 하면 효율적으로 운영할 지, 좋은 SW란 무엇인지 알아보고 싶어",Stat(data: 0, system: 1, userFriendly: 1, math: 0, collaboration: 2)),
                 ("컴퓨터 구조론 : 컴퓨터 하드웨어가 어떻게 구성되어있는지, CPU 내 연산은 어떻게 이뤄지는지 궁금해",Stat(data: 1, system: 2, userFriendly: 0, math: 0, collaboration: 0)),
                 ("컴퓨터 그래픽스 : 영화나 게임 산업 등에서 캐릭터의 움직임을 훨씬 자연스럽게 만드는 법을 배우고 싶어",Stat(data: 0, system: 0, userFriendly: 0, math: 2, collaboration: 0)),
                 ("전과를 택하겠습니다.",Stat(data: 0, system: 0, userFriendly: 0, math: 0, collaboration: 0)),

                ]
    ),
    TestPaper(
        question: "어떤 플랫폼의 서비스를 만들어보고 싶어?",
        answer: [("나는 웹 서비스! 접근성이 좋게 하는 것이 최고지 ㅎㅎ \n요즘 웹이 대세 아냐?",Stat(data: 1, system: 0, userFriendly: 1, math: 0, collaboration: 0)),
                 ("나는 모바일 서비스! 웹앱이 대세라지만 결국 네이티브로 모바일 리소스를 쓸려면 앱개발도 필요하다구~",Stat(data: 0, system: 0, userFriendly: 1, math: 0, collaboration: 0)),
                 ("나는 ioT를 이용해서 사람들의 생활 전반적인 곳에 편의를 주고 싶어",Stat(data: 0, system: 2, userFriendly: 0, math: 0, collaboration: 0)),
                ]
    ),
    TestPaper(
        question: "평소에 개발을 좋아하고, 디버깅하는 데 거리낌이 없니?",
        answer: [("응! 에러가 나도 논리적 오류를 찾아가는 과정이 재밌어 ㅎㅎ",Stat(data: 1, system: 1, userFriendly: 0, math: 0, collaboration: 0)),
                 ("아니.. 이런 거 왜 배워야하는 지 잘 모르겠고 어렵기만 해",Stat(data: -1, system: -1, userFriendly: 0, math: 0, collaboration: 0)),
                ]
    ),
    TestPaper(
        question: "스타트업들을 소개해줄게. 이중 어떤 회사 아이덴티티가 가장 끌려?",
        answer: [("보이저엑스 : 인공지능 기반 스타트업. NLP를 활용해 영상편집 앱 브루, 딥러닝을 이용해 스캐너 등을 만들어",Stat(data: 1, system: 0, userFriendly: 0, math: 1, collaboration: 0)),
                 ("크래프톤 : 게임회사. 배틀그라운드를 만들기도 했지. 탄도 계산 등이 실제와 흡사해서 호평받았어.",Stat(data: 0, system: 1, userFriendly: 0, math: 1, collaboration: 0)),
                 ("두나무 : 비트코인 거래소인 업비트를 만든 회사야. 실시간 거래 데이터를 안정성 있게 보장해야해.",Stat(data: 1, system: 1, userFriendly: 0, math: 0, collaboration: 0)),
                 ("되는 시간 : 사람들의 약속을 간편하게 만들기 위한 스케줄러를 만들어. 프론트 직무가 중요시 돼.",Stat(data: 0, system: 0, userFriendly: 2, math: 0, collaboration: 1)),
                ]
    ),
    TestPaper(
        question: "수학 공부가 재밌니?",
        answer: [("응! 효율적인 알고리즘을 찾으려면 수학적 이해는 필수지.",Stat(data: 1, system: 0, userFriendly: 0, math: 1, collaboration: 0)),
                 ("아니! 컴퓨터에만 관심있는데 수학이 왜 필요해?",Stat(data: 0, system: 0, userFriendly: 0, math: -1, collaboration: 0)),
                ]
    ),
    
                 
                                 
]
