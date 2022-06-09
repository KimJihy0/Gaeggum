//
//  QuestionViewController.swift
//  Gaeggum
//
//  Created by zeroStone ⠀ on 2022/05/16.
//

import UIKit

class QuestionViewController: UIViewController{
    var userInfoDelegate: UserInfoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let starterView = QuestionStarterView()
        starterView.parentViewController = self
        
        self.view.addSubview(starterView)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
