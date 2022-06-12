//
//  QuestionHeaderView.swift
//  Gaeggum
//
//  Created by zeroStone ⠀ on 2022/06/10.
//

import UIKit

class QuestionHeaderView : UIView {
    @IBOutlet weak var indexLabel : UILabel!
    @IBOutlet weak var progressBar : UIProgressView!
    @IBOutlet weak var questionLabel : UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var questionStackView : UIStackView!
    
    let nibName = "QuestionHeader"
    
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
    
    func updateQuestionHeader(index: Int, dummyArrayLength: Int, questionText: String) {
        
        questionStackView.layer.borderWidth = 3
        questionStackView.layer.borderColor = UIColor.systemGray.cgColor
        
        //indexLabel 수정
        var tmpText : String = "문제 "
        if index<10 {
            tmpText += "0"+String(index)+"."
        } else {
            tmpText += String(index)+"."
        }
        indexLabel.numberOfLines = 0
        indexLabel.lineBreakMode = .byCharWrapping
        indexLabel.text = tmpText
        
        //progressView 수정
        progressBar.progress = Float(index) / Float(dummyArrayLength)
        progressBar.clipsToBounds = true
        progressBar.layer.cornerRadius = 8
        progressBar.clipsToBounds = true
        progressBar.layer.sublayers![1].cornerRadius = 8// 뒤에 있는 회색 track
        progressBar.subviews[1].clipsToBounds = true
        
        //questionLabel 수정
        questionLabel.numberOfLines = 0
        questionLabel.lineBreakMode = .byCharWrapping
        questionLabel.text = questionText
    }
    
}
