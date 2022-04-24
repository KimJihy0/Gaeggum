//
//  Career.swift
//  Scene1
//
//  Created by zeroStone ⠀ on 2022/04/18.
//

import Foundation

struct Career {
    let id : Int
    let name : String
    let task : String
    let curriculum : String
    let abilities : [Ability]
    let tips : String
    var stat : Stat
//    let image : String // image는 DB구축 단계에서 넣어야할 듯
}

let testCareer = Career(
    id: 0,
    name: "AI 엔지니어",
    task: "AI 엔지니어는 데이터를 추출해 머신러닝 모델을 만드는 개발자야. 잘 알려진 모델을 사용해서 서비스를 만드는 ‘소프트웨어 엔지니어', 문제를 해결할 새로운 모델을 구상하는 ‘리서치 엔지니어'로 나뉘어. \n하루 일과\n1. 관련 논문을 읽어\n2. 데이터의 전처리(좋은 데이터만 뽑아내는 것)\n3. 논문과 같은 결과가 나오는지 실험해\n4. 모델 속도를 더 빠르게 만들어(Pruning)\n5. 서비스에 직접 적용해",
    curriculum: "중, 고등학생이라면?\n수학, 특히 미적분 공부 열심히 해\n\n대학생이라면?\n미분적분학, 선형대수, 수치해석, 딥러닝 및 응용 과목을 수강해야해. 딥러닝 해커톤 (PyTorch, Naver AI해커톤)에 참여 하면 좋아.\n\nAI엔지니어도 요즘 입사 전형에 코딩테스트가 꼭 있어. My 스택칸을 눌러 준비방법을 확인해봐",
    abilities: [Ability.patience, Ability.trendyStudy],
    tips: "리서치 엔지니어의 경우 인공지능에 대한 많은 지식이 필요하기 때문에 ‘대학원’은 필수야!",
    stat: Stat(data: 4, system: 2, userFriendly: 0, math: 5, collaboration: 1)
)
