//
//  QuestionDetailViewController.swift
//  Gaeggum
//
//  Created by zeroStone ⠀ on 2022/05/23.
//

import UIKit

class QuestionDetailViewController: UIViewController{
    var userInfoDelegate: UserInfoDelegate?
    
    var answerStats : [Stat] = []
    
    var nowTestPaperIndex = 0
    lazy var nowTestPaper : TestPaper = {return dummyTestPaper[nowTestPaperIndex]}()
    var nowUserStat : Stat = Stat(data: 0, system: 0, userFriendly: 0, math: 0, collaboration: 0)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // property 전달 test
//        print(nowTestPaperIndex, nowTestPaper, nowUserStat, separator: "\n")
        
        let testPaperStackView = makeStackView()
        self.view.addSubview(testPaperStackView)
        
        // horizontally, vertically center constraint / 중앙 위치
        NSLayoutConstraint.activate([
            testPaperStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            testPaperStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func makeStackView()->UIStackView {
        lazy var stackView: UIStackView = {
            let stackV = UIStackView()
            stackV.translatesAutoresizingMaskIntoConstraints = false
            stackV.axis = .vertical
            stackV.spacing = 10
            stackV.distribution = .fillEqually
            return stackV
        }()

        let nowTestPaper = dummyTestPaper[nowTestPaperIndex]
        
        let questionText = nowTestPaper.question
        let questionLabel = UILabel()
        questionLabel.text = questionText
        stackView.addArrangedSubview(questionLabel)
        
        for (answerIndex, (answerText,stat)) in nowTestPaper.answer.enumerated() {
            lazy var answerButton: UIButton = {
                let button = UIButton(type: .system)
                button.tag = answerIndex // put button id to recognize question index
                button.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
                button.backgroundColor = .gray
                button.setTitle(answerText, for: .normal)
                button.setTitleColor(.white, for: .normal)
                button.addTarget(self, action: #selector(answerTapped), for: .touchUpInside)
                return button
            }()
            
            stackView.addArrangedSubview(answerButton)
            answerStats.append(stat)
        }
        
        return stackView
        
    }
    
    @IBAction func answerTapped(_ sender: UIButton) {
        let nextTestPaperIndex = self.nowTestPaperIndex + 1
        var nextUserStat : Stat = Stat()
        
        let tappedAnswerStat : Stat = nowTestPaper.answer[sender.tag].1
        nextUserStat.addStat(answerStat: tappedAnswerStat)
        nextUserStat.addStat(answerStat: self.nowUserStat)
        
        if nextTestPaperIndex >= dummyTestPaper.count {
            // 모든 질문 끝났을 때
            userInfoDelegate?.statUpdated(stat: nextUserStat)
            dismiss(animated: true)
        } else {
            // 안 끝났을 때
            let storyboard = UIStoryboard(name: "QuestionDetail", bundle: nil)
            guard let nextQuestionDetailViewController = storyboard.instantiateViewController(withIdentifier: "QuestionDetailVC") as? QuestionDetailViewController else { return }
            
            nextQuestionDetailViewController.nowTestPaperIndex = nextTestPaperIndex
            nextQuestionDetailViewController.nowUserStat = nextUserStat
            
            // 화면 전환 애니메이션 설정
            nextQuestionDetailViewController.modalTransitionStyle = .coverVertical
    //                secondViewController.modalPresentationStyle = .fullScreen
            
            self.navigationController?.pushViewController(nextQuestionDetailViewController, animated: true)
            
        }
    }
        
}

