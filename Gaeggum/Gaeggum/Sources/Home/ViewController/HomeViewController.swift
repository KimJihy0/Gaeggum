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
}
