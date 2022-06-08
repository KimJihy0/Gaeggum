//
//  HomeViewController.swift
//  Gaeggum
//
//  Created by zeroStone ⠀ on 2022/04/22.
//

import UIKit

class HomeViewController : UIViewController {
    @IBOutlet weak var careerDetailView: CareerDetailView!
    
    var career: Career = testCareer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
//        if let career = career {
//            careerDetailView.updateCareer(career: career)
//        }
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
