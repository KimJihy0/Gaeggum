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
        tagLabel.font = .systemFont(ofSize: fontSize)
        tagLabel.textColor = .gray
        tagLabel.textAlignment = .center
        
        contentView.addSubview(tagLabel)
        
        // cell
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 5
        contentView.backgroundColor = .systemGray5
        
        // contraints
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        tagLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        tagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        tagLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTag()
        
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
}
