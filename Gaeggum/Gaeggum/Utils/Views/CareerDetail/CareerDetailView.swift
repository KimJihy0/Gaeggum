//
//  CareerDetailView.swift
//  Gaeggum
//
//  Created by 상현 on 2022/05/07.
//


import UIKit
import Charts

class CareerDetailView: UIView {
    
//    @IBOutlet weak var chartView: RadarChartView!
    
    @IBOutlet weak var jobNameLabel: UILabel!
    @IBOutlet weak var jobImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    @IBOutlet weak var taskLabel: UILabel! // new
    @IBOutlet weak var curriculumLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!

//    // 차트 라이브러리 관련 변수
//    let greenDataSet = RadarChartDataSet(
//        entries: [
//            RadarChartDataEntry(value: 5),
//            RadarChartDataEntry(value: 4),
//            RadarChartDataEntry(value: 1),
//            RadarChartDataEntry(value: 1),
//            RadarChartDataEntry(value: 2)
//        ]
//    )
//
//    let blueDataSet = RadarChartDataSet(
//        entries: [
//            RadarChartDataEntry(value: 3),
//            RadarChartDataEntry(value: 5),
//            RadarChartDataEntry(value: 1),
//            RadarChartDataEntry(value: 2),
//            RadarChartDataEntry(value: 1)
//        ]
//    )
    
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
        var jobImage = UIImage(named: career.name)
        if let jobImage = jobImage {} else {
            jobImage = UIImage(named: "AI 엔지니어")
        }
        jobImageView.image = jobImage
        
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
        
//        updateChart()
    }

    
//    func updateChart() {
//        //test
//        let data = RadarChartData(dataSets: [greenDataSet, blueDataSet])
//
//        greenDataSet.colors = [.green]
//        greenDataSet.drawValuesEnabled = false
//        greenDataSet.lineWidth = 2.0
//        blueDataSet.colors = [.blue]
//        blueDataSet.drawValuesEnabled = false
//        blueDataSet.lineWidth = 2.0
//        
//        chartView.data = data
//        chartView.legend.enabled = false
//        chartView.yAxis.axisMinimum = 0
//        chartView.yAxis.axisMaximum = 5
//        chartView.drawWeb = true
//        chartView.webLineWidth = 0
//        chartView.innerWebColor = .lightGray
//        chartView.innerWebLineWidth = 1.0
//        chartView.rotationEnabled = false
//        chartView.highlightPerTapEnabled = false
//        chartView.xAxis.labelFont = .systemFont(ofSize: 10)
//        chartView.xAxis.valueFormatter = XAxisFormatter()
//        
//        chartView.yAxis.drawLabelsEnabled = false
//        
//        
//        
//    }
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

class XAxisFormatter: AxisValueFormatter {
    
    let titles = ["모델 적용력", "끈기와 인내", "트렌디한 논문 습득력", "수학적 지식", "코딩 능력"]
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        titles[Int(value)]
    }
}
