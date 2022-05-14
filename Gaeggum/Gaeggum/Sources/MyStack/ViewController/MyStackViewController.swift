//
//  MyStackViewController.swift
//  Gaeggum
//
//  Created by zeroStone on 2022/04/22.
//

import UIKit
import SwiftUI
import WebKit

class MyStackViewController : UIViewController, UIGestureRecognizerDelegate {
    
    var bojUsername: String? = nil
    var gitHubUsername: String? = nil
    var projects: [Project] = [
        Project(startDate: Date(), endDate: Date(), content: "test content"),
        Project(startDate: Date(), endDate: Date(), content: "s\ne\n\n\n\n\nc\no\nnd test and very very very long text test more more more more more long text"),
    ]
    
    @IBOutlet weak var algorithmBarView: UIView!
    @IBOutlet weak var projectBarView: UIView!
    @IBOutlet weak var csStudyBarView: UIView!
    
    @IBOutlet weak var bojView: WKWebView!
    @IBOutlet weak var projectStackView: UIStackView!
    @IBOutlet weak var grassView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("My Stack")

        updateGraph(90, 80, 70)
        updateBoj()
        updateGrass()
        updateProjects()
    }
    
    func updateGraph(_ algorithmPercent: CGFloat, _ projectPercent: CGFloat, _ csStudyPercent: CGFloat) {
        algorithmBarView.anchor(height: algorithmPercent * 2)
        projectBarView.anchor(height: projectPercent * 2)
        csStudyBarView.anchor(height: csStudyPercent * 2)
    }
    
    func updateBoj() {
        guard let handle = self.bojUsername else {
            bojView.isHidden = true
            return
        }
        let width = self.view.frame.width - 40
        let scale = width * 0.00136
        bojView.isHidden = false
        bojView.scrollView.isScrollEnabled = false
        bojView.loadHTMLString(bojStatHtml(scale, handle), baseURL: nil)
    }
    
    func updateProjects() {
        projectStackView.arrangedSubviews.forEach { (view) in
            projectStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        self.projects.enumerated().forEach { (index, project) in
            let projectView = project.view
            projectView.tag = index
            projectView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(didLongPressView(_:))))
            self.projectStackView.addArrangedSubview(projectView)
        }
    }
    
    func updateGrass() {
        guard let username = self.gitHubUsername else {
            return
        }
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
            self.bojUsername = alert.textFields?[0].text
            
            if isValid(handle: self.bojUsername!) {
                self.updateBoj()
            } else {
                self.bojUsername = nil
                let invalidAlert = UIAlertController(title: "오류", message: "solved.ac에 등록되지 않은 아이디입니다.", preferredStyle: .alert)
                invalidAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(invalidAlert, animated: false)
            }
            
        })
        
        present(alert, animated: false)
    }
    
    @IBAction func createGrass(_ sender: Any) {
        let alert = UIAlertController(title: "GitHub 계정 추가", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "GitHub 아이디를 입력하세요"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Add", style: .default) {_ in
            self.gitHubUsername = alert.textFields?[0].text
            
            if isValid(gitUsername: self.gitHubUsername!) {
                self.updateGrass()
            } else {
                self.gitHubUsername = nil
                let invalidAlert = UIAlertController(title: "오류", message: "GitHub에 등록되지 않은 아이디입니다.", preferredStyle: .alert)
                invalidAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(invalidAlert, animated: false)
            }
            
        })
        
        present(alert, animated: false)
    }
}

extension MyStackViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let src = segue.source as! MyStackViewController
        let dest = segue.destination as! ProjectViewController
        switch segue.identifier {
        case "ModifySegue":
            let index = sender as! Int
            dest.isToModify = true
            dest.startDate = src.projects[index].startDate
            dest.endDate = src.projects[index].endDate
            dest.content = src.projects[index].content
            dest.index = index
        case "AddSegue":
            dest.isToModify = false
            dest.startDate = nil
            dest.endDate = nil
            dest.content = nil
            dest.index = nil
        default: break
        }
    }
    
    @objc func didLongPressView(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            performSegue(withIdentifier: "ModifySegue", sender: sender.view!.tag)
        }
    }
    
    @IBAction func unwindToMyStack(_ unwindSegue: UIStoryboardSegue) {
//        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
    @IBAction func deleteProject(_ unwindSegue: UIStoryboardSegue) {
        let src = unwindSegue.source as! ProjectViewController
        if let index = src.index {
            projects.remove(at: index)
        }
        updateProjects()
    }
    
    @IBAction func saveProject(_ unwindSegue: UIStoryboardSegue) {
        let src = unwindSegue.source as! ProjectViewController
        if let index = src.index {
            projects[index] = Project(startDate: src.startDate!, endDate: src.endDate!, content: src.content!)
        } else {
            projects.append(Project(startDate: src.startDate!, endDate: src.endDate!, content: src.content!))
        }
        updateProjects()
    }
    
}
