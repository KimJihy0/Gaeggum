//
//  QuestionViewController.swift
//  Gaeggum
//
//  Created by zeroStone ⠀ on 2022/05/16.
//

import UIKit

class QuestionViewController: UIViewController{
    var userInfoDelegate: UserInfoDelegate?
    @IBOutlet var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
//        startButton.backgroundColor = .white
//        startButton.setTitleColor(.black, for: .normal)
        
    }
    
    
    @IBAction func startButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "QuestionDetail", bundle: nil)
        guard let questionDetailViewController = storyboard.instantiateViewController(withIdentifier: "QuestionDetailVC") as? QuestionDetailViewController else { return }
        // 화면 전환 애니메이션 설정
        questionDetailViewController.modalTransitionStyle = .coverVertical
        // 전환된 화면이 보여지는 방법 설정 (fullScreen)
//                secondViewController.modalPresentationStyle = .fullScreen
        questionDetailViewController.userInfoDelegate = self.userInfoDelegate
        self.navigationController?.pushViewController(questionDetailViewController, animated: true)
    }
}
