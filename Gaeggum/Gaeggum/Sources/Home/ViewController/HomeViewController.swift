//
//  HomeViewController.swift
//  Gaeggum
//
//  Created by zeroStone ⠀ on 2022/04/22.
//

import UIKit

class HomeViewController : UIViewController {
    @IBOutlet weak var jobNameLabel: UILabel!
    @IBOutlet weak var jobImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var curriculumLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateCareer(career : getTestUser().career!)
    }
    
    func updateCareer(career: Career){
        jobNameLabel.text = career.name
        jobImageView.image = UIImage(named: "AIEngineer")
        taskLabel.text = career.task
        
        curriculumLabel.text = career.curriculum
        tipLabel.text = career.tips
    }
    @IBAction func moveVC(_ sender: Any) {
        print("heyhey")
        guard let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "QuestionVC") as? UIViewController else { return }
                // 화면 전환 애니메이션 설정
                secondViewController.modalTransitionStyle = .coverVertical
                // 전환된 화면이 보여지는 방법 설정 (fullScreen)
                secondViewController.modalPresentationStyle = .fullScreen
                self.present(secondViewController, animated: true, completion: nil)
    }
    
}
