//
//  AnswerView.swift
//  Gaeggum
//
//  Created by zeroStone ⠀ on 2022/06/10.
//

import UIKit

class AnswerView : UIView {
    
    @IBOutlet var answerStackView: UIStackView!
    @IBOutlet var answerLabel: UILabel!
    
    
    let nibName = "Answer"
    
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
    
    func updateAnswer(answerText:String) {
        //answerLabel 수정
        answerLabel.numberOfLines = 0
        answerLabel.lineBreakMode = .byCharWrapping
        answerLabel.text = answerText
    }
}
