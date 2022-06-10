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
    
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    @IBOutlet weak var taskLabel: UILabel! // new
    @IBOutlet weak var curriculumLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!

    let nibName = "CareerDetail"
    var abilityList : [Ability] = []
    
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
            
            setupCollectionView()
        }
        
        func loadViewFromNib() -> UIView? {
            let nib = UINib(nibName: nibName, bundle: nil)
            return nib.instantiate(withOwner: self, options: nil).first as? UIView
        }
    
    func setupCollectionView() {
        let nib = UINib(nibName: "TagCell", bundle: nil)
        tagCollectionView.register(nib, forCellWithReuseIdentifier: "TagCell")
        
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
    
        
        let layout = TagLeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        layout.sectionInset = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        
        tagCollectionView.frame.size.height = (UIScreen.main.bounds.size.width >= 375) ? 40 : 80
        tagCollectionView.collectionViewLayout = layout
        tagCollectionView.backgroundColor = UIColor.white
        tagCollectionView.register(TagCell.classForCoder(), forCellWithReuseIdentifier: "TagCell")
    }
    
    func updateCareer(career: Career){
        jobNameLabel.text = career.name
        jobImageView.image = UIImage(named: "AIEngineer")
        
        taskLabel.numberOfLines = 0
        taskLabel.lineBreakMode = .byCharWrapping
        taskLabel.text = career.task
        
        abilityList = career.abilities
        self.tagCollectionView.reloadData()
        
        curriculumLabel.numberOfLines = 0
        curriculumLabel.lineBreakMode = .byCharWrapping
        curriculumLabel.text = career.curriculum

        tipLabel.numberOfLines = 0
        tipLabel.lineBreakMode = .byCharWrapping
        tipLabel.text = career.tips
    }
}

extension CareerDetailView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // cell 크기 결정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let tagCell = TagCell()
        let label = UILabel()
        label.font = .systemFont(ofSize: tagCell.fontSize)
        label.text = "# " + abilityList[indexPath.item].rawValue
        label.sizeToFit()

        let size = label.frame.size

        return CGSize(width: size.width + 25, height: size.height + 15)
    }

    // cell 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return abilityList.count
    }

    // cell 텍스트 입력
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tagCollectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell

        cell.tagLabel.text = "# " + abilityList[indexPath.item].rawValue
        
        // systemIndigo
        cell.contentView.backgroundColor = UIColor(rgb: 0x19A9DE )
        cell.tagLabel.textColor = UIColor.white
        
        return cell
    }
}
