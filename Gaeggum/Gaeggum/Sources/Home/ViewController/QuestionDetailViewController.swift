//
//  QuestionDetailViewController.swift
//  Gaeggum
//
//  Created by zeroStone ⠀ on 2022/05/23.
//

import UIKit

class QuestionDetailViewController: UIViewController{
    var testPaperIndex = 0
    var userStat : Stat = Stat(data: 0, system: 0, userFriendly: 0, math: 0, collaboration: 0)
    
    var answerStats : [Stat] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

        let nowTestPaper = dummyTestPaper[testPaperIndex]
        
        let questionText = nowTestPaper.question
        let questionLabel = UILabel()
        questionLabel.text = questionText
        stackView.addArrangedSubview(questionLabel)
        
        for (answerText,stat) in nowTestPaper.answer {
            lazy var answerButton: UIButton = {
                let button = UIButton(type: .system)
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
    
    @IBAction func answerTapped(_ sender: Any) {
        let nextTestPaperIndex = self.testPaperIndex + 1
        var nextUserStat : Stat = Stat()
        nextUserStat.addStat(answerStat: self.userStat)
        
        if nextTestPaperIndex >= dummyTestPaper.count {
            
        } else {
            let storyboard = UIStoryboard(name: "QuestionDetail", bundle: nil)
            guard let nextQuestionDetailViewController = storyboard.instantiateViewController(withIdentifier: "QuestionDetailVC") as? QuestionDetailViewController else { return }
            
            nextQuestionDetailViewController.testPaperIndex = nextTestPaperIndex
            nextQuestionDetailViewController.userStat = nextUserStat
            
            // 화면 전환 애니메이션 설정
            nextQuestionDetailViewController.modalTransitionStyle = .coverVertical
            // 전환된 화면이 보여지는 방법 설정 (fullScreen)
    //                secondViewController.modalPresentationStyle = .fullScreen
            
            self.navigationController?.pushViewController(nextQuestionDetailViewController, animated: true)
            
        }
    }
        
}

