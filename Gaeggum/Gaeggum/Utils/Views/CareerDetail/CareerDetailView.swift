//
//  CareerDetailView.swift
//  Gaeggum
//
//  Created by 상현 on 2022/05/07.
//

import UIKit

class CareerDetailView: UIView {
    
    @IBOutlet weak var jobNameLabel: UILabel!
    @IBOutlet weak var jobImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    

    @IBOutlet weak var taskLabel: UILabel! // new
    @IBOutlet weak var curriculumLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!

    let nibName = "CareerDetail"
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        
        func commonInit() {
            guard let view = loadViewFromNib() else { return }
            view.frame = self.bounds
            self.addSubview(view)
        }
        
        func loadViewFromNib() -> UIView? {
            let nib = UINib(nibName: nibName, bundle: nil)
            return nib.instantiate(withOwner: self, options: nil).first as? UIView
        }
        
    
    func updateCareer(career: Career){
        jobNameLabel.text = career.name
        jobImageView.image = UIImage(named: "AIEngineer")
        
        taskLabel.numberOfLines = 0
        taskLabel.lineBreakMode = .byCharWrapping
        taskLabel.text = career.task
        
        curriculumLabel.numberOfLines = 0
        curriculumLabel.lineBreakMode = .byCharWrapping
        curriculumLabel.text = career.curriculum

        tipLabel.numberOfLines = 0
        tipLabel.lineBreakMode = .byCharWrapping
        tipLabel.text = career.tips
    }
}
