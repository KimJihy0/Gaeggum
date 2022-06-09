//
//  HomeViewController.swift
//  Gaeggum
//
//  Created by zeroStone ⠀ on 2022/04/22.
//

import UIKit

class HomeViewController : UIViewController {
    @IBOutlet weak var careerDetailView: CareerDetailView!
    
    // 추후에 바로 career 가져오는 것으로 바꿀 것
    // 검사지 끝나고 -> updateStat하면 자동 updateCareer -> 여기선 바로 career 가져오기 -> updateUI
    var userInfo: UserInfo = UserInfo.loadTestUser()
    var career: Career = testCareer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        updateUserInfo()
        updateCareerView()
        
    }
    
    fileprivate func updateUserInfo() {
        if let savedUserInfo = UserInfo.loadUserInfo() {
            userInfo = savedUserInfo
        }
        
        //test UserInfo MSE Algorithm
        userInfo.updateCareer()
        if let myCareer = userInfo.career{
            career = myCareer
        }
    }
    
    func updateCareerView() {
        careerDetailView.updateCareer(career: career)
    }
    
    @IBAction func moveVC(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Question", bundle: nil)
        guard let secondViewController = storyboard.instantiateViewController(withIdentifier: "QuestionNC") as? UINavigationController else { return }
        // 화면 전환 애니메이션 설정
        secondViewController.modalTransitionStyle = .coverVertical
        // 전환된 화면이 보여지는 방법 설정 (fullScreen)
//        secondViewController.modalPresentationStyle = .fullScreen
        self.present(secondViewController, animated: true, completion: nil)
    }
    
}

protocol UserInfoDelegate {
    func statUpdated(stat: Stat)
}

extension HomeViewController: UserInfoDelegate {
    
    func statUpdated(stat: Stat) {
        print("스탯 업데이트", stat)
        userInfo.updateStat(newStat: stat)
        updateUserInfo()
        UserInfo.saveUserInfo(userInfo)
        updateCareerView()
    }
    
}
