//
//  TagCell.swift
//  Gaeggum
//
//  Created by 상현 on 2022/06/02.
//

import UIKit

class TagCell: UICollectionViewCell {
    let fontSize : CGFloat = 13
    var tagLabel : UILabel = UILabel()
    
    func setupTag(){
        // label
        tagLabel.backgroundColor = UIColor.red
        tagLabel.font = .systemFont(ofSize: fontSize)
        tagLabel.textColor = .gray
        tagLabel.textAlignment = .center
        tagLabel.text = "test"
        
        contentView.addSubview(tagLabel)
        
        // cell
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 5
        contentView.backgroundColor = .systemGray5
        
        // contraints
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        tagLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor,constant: 30).isActive = true // ---- 1
        tagLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 40).isActive = true // ---- 2
        tagLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -40).isActive = true // ---- 3
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTag()
        
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
}
