//
//  MyStackViewController.swift
//  Gaeggum
//
//  Created by zeroStone on 2022/04/22.
//

import UIKit
import SwiftUI
import Charts
import WebKit

class MyStackViewController : UIViewController, UIGestureRecognizerDelegate {
    
    var projects: [Project] = []
    var userInfo: UserInfo?
    
    var points: [String] = ["알고리즘", "프로젝트"]
    var values: [Double] = [0, 0]
    
    var selectedIndex: Int?
    var bojStatViewHeightConstraint: NSLayoutConstraint?
    
    @IBOutlet weak var algorithmBarView: UIView!
    @IBOutlet weak var projectBarView: UIView!
    @IBOutlet weak var csStudyBarView: UIView!
    
    @IBOutlet weak var chartView: BarChartView!
    @IBOutlet weak var bojView: WKWebView!
    @IBOutlet weak var bojStatView: UIView!
    @IBOutlet weak var bojProblemsView: UIView!
    @IBOutlet weak var projectStackView: UIStackView!
    @IBOutlet weak var grassView: UIView!
    
    @IBOutlet weak var nextTierLabel: UILabel!
    @IBOutlet weak var ratingLineView: UIView!
    @IBOutlet weak var currentRatingView: RoundView!
    @IBOutlet weak var currentTierLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedUserInfo = UserInfo.loadUserInfo() {
            userInfo = savedUserInfo
        } else {
            userInfo = UserInfo.loadTestUser()
        }
        
        if let savedProjects = Project.loadProjects() {
            projects = savedProjects
        } else {
            projects = Project.loadSampleProjects()
        }

        updateGraph()
        updateBoj()
        updateBojStat()
        updateProjects()
        updateGrass()
        updateChart()
    }
    
    func updateGraph() {
        algorithmBarView.anchor(height: values[0] * 2)
        projectBarView.anchor(height: values[1] * 2)
    }
    
    func updateChart() {
        print("values[0]:\(values[0])")
        values[1] = (Double(projects.count) / Double((userInfo?.goalNumProjects)!)) * 100.0
        print("projects.count:\(projects.count)")
        print("userInfo?.goalNumProjects:\(userInfo?.goalNumProjects)")
        print("values[1]:\(values[1])")
        
        values = [52.0, 66.6]
        
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<points.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")

        // 차트 컬러
        chartDataSet.colors = [UIColor(Color("GreenLevel2"))]
        chartDataSet.highlightEnabled = false

        // 데이터 삽입
        let chartData = BarChartData(dataSet: chartDataSet)
        chartView.data = chartData
        
        chartView.xAxis.labelFont = .systemFont(ofSize: 17)
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: points)
        chartView.xAxis.setLabelCount(points.count, force: false)
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.barData?.barWidth = 0.5
        
        
//        chartView.borderLineWidth = 1
//        chartView.borderColor = .lightGray
//        chartView.drawBordersEnabled = true
        
//        chartView.backgroundColor = .systemGray6
        
        chartView.legendRenderer.legend?.enabled = false
        
        chartView.highlightFullBarEnabled = false
        
        //        chartView.
        
        chartView.rightAxis.enabled = false
        
        chartView.animate(yAxisDuration: 2.0)
        
        chartView.leftAxis.axisMinimum = 0
        chartView.leftAxis.axisMaximum = 100
        
        chartView.doubleTapToZoomEnabled = false
        
        // ????
        
        chartView.leftAxis.enabled = false
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.drawBarShadowEnabled = true
        
        chartView.barData?.setDrawValues(false)
    }
    
    func updateBoj() {
        guard let bojUsername = userInfo?.bojID else {
            bojView.isHidden = true
            return
        }
        bojView.isHidden = false
        
        let width = self.view.frame.width - 40
        let scale = width * 0.00136
        bojView.scrollView.isScrollEnabled = false
        bojView.loadHTMLString(BojStat.bojStatHtml(scale, bojUsername), baseURL: nil)
    }
    
    func updateBojStat() {
        guard let bojUsername = userInfo?.bojID else {
            bojStatView.isHidden = true
            return
        }
        bojStatView.isHidden = false
        
        let url = URL(string: "https://solved.ac/api/v3/user/show?handle=\(bojUsername)")!
        let data = try! String(contentsOf: url).data(using: .utf8)!
        let stat = try! JSONDecoder().decode(BojStat.self, from: data)
        
        nextTierLabel.text = Tier(value: stat.tier + 1).toString() + " 승급까지 - " + String(Tier(value: stat.tier + 1).rating - stat.rating)
        currentTierLabel.text = Tier(value: stat.tier).toString() + " " + String(stat.rating)
        
        let lineHeight = ratingLineView.frame.height
        let percent = CGFloat(stat.rating - Tier(value: stat.tier).rating) / CGFloat(Tier(value: stat.tier+1).rating - Tier(value: stat.tier).rating)
        print("------dfsdfadfasdf-------")
        print(percent)
        values[0] = percent * 100
        print(values[0])
        currentRatingView.anchor(bottom: ratingLineView.bottomAnchor, paddingBottom: lineHeight * percent)
        
        let controller = UIHostingController(rootView: ProblemStatView(username: bojUsername))
        addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        bojProblemsView.addSubview(controller.view)
        controller.didMove(toParent: self)
        NSLayoutConstraint.activate([
            controller.view.heightAnchor.constraint(equalTo: bojProblemsView.heightAnchor),
            controller.view.widthAnchor.constraint(equalTo: bojProblemsView.widthAnchor),
        ])
    }
    
    func updateProjects() {
        projects.sort(by: <)
        projectStackView.arrangedSubviews.forEach { (view) in
            projectStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        projects.enumerated().forEach { (index, project) in
            let projectView = project.view
            projectView.tag = index
            projectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView(_:))))
            projectStackView.addArrangedSubview(projectView)
        }
        
        updateChart()
    }
    
    func updateGrass() {
        print(userInfo)
        guard let username = userInfo?.gitID else {
            print("------------------------------")
            return }
        print("username:\(username)")
        let controller = UIHostingController(rootView: GrassView(username: username))
        addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        grassView.addSubview(controller.view)
        controller.didMove(toParent: self)
        NSLayoutConstraint.activate([
            controller.view.heightAnchor.constraint(equalTo: grassView.heightAnchor),
            controller.view.widthAnchor.constraint(equalTo: grassView.widthAnchor),
        ])
    }
    
    @IBAction func createBoj(_ sender: Any) {
        let alert = UIAlertController(title: "solved.ac 계정 추가", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "백준 아이디를 입력하세요"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Add", style: .default) {_ in
            self.userInfo?.bojID = alert.textFields?[0].text
            
            if BojStat.isValid(handle: (self.userInfo?.bojID)!) {
                UserInfo.saveUserInfo(self.userInfo!)
                self.updateBoj()
                self.updateBojStat()
                self.updateChart()
            } else {
                self.userInfo?.bojID = nil
                let invalidAlert = UIAlertController(title: "오류", message: "solved.ac에 등록되지 않은 아이디입니다.", preferredStyle: .alert)
                invalidAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(invalidAlert, animated: false)
            }
        })
        
        present(alert, animated: true)
    }
    
    @IBAction func createGrass(_ sender: Any) {
        let alert = UIAlertController(title: "GitHub 계정 추가", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "GitHub 아이디를 입력하세요"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Add", style: .default) {_ in
            self.userInfo?.gitID = alert.textFields?[0].text
            if Contribution.isValid(gitUsername: (self.userInfo?.gitID)!) {
                UserInfo.saveUserInfo(self.userInfo!)
                self.updateGrass()
            } else {
                self.userInfo?.gitID = nil
                let invalidAlert = UIAlertController(title: "오류", message: "GitHub에 등록되지 않은 아이디입니다.", preferredStyle: .alert)
                invalidAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(invalidAlert, animated: false)
            }
        })
        
        present(alert, animated: true)
    }
    
    @IBAction func setGoalNumProjects(_ sender: Any) {
        let alert = UIAlertController(title: "목표 프로젝트 개수 설정", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.keyboardType = .numberPad
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Done", style: .default) {_ in
            guard let num = Int(alert.textFields?[0].text ?? "") else { return }
            self.userInfo?.goalNumProjects = num
            UserInfo.saveUserInfo(self.userInfo!)
            self.updateChart()
        })
        
        present(alert, animated: true)
    }
                        
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ShowProjectSegue", sender: sender.view!.tag)
    }
}

// MARK: - Navigation

extension MyStackViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "ShowProjectSegue":
            let destViewController = segue.destination as! DetailProjectViewController
            destViewController.projectDelegate = self
            
            guard let index = sender as? Int else { return }
            selectedIndex = index
            destViewController.project = projects[index]
            
        default: break
        }
        
    }
    
    @IBAction func unwindToMyStack(_ unwindSegue: UIStoryboardSegue) {
        
        switch unwindSegue.identifier {
        case "CreateProjectUnwind":
            let sourceViewController = unwindSegue.source as! AddModifyProjectViewController
            guard let project = sourceViewController.project else { return }
            
            projects.append(project)
            updateProjects()
            Project.saveProjects(projects)
            
        case "DeleteProjectUnwind":
            guard let index = selectedIndex else { return }
            projects.remove(at: index)
            updateProjects()
            Project.saveProjects(projects)
            
        default: break
        }
        
    }
    
}

// MARK: - Delegation

protocol ProjectDelegate {
    func projectUpdated(project: Project)
}

extension MyStackViewController: ProjectDelegate {
    
    func projectUpdated(project: Project) {
        guard let index = selectedIndex else { return }
        projects[index] = project
        updateProjects()
        Project.saveProjects(projects)
    }
    
}
