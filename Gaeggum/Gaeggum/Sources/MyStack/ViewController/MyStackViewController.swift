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
    
    var bojUsername: String?
    var gitHubUsername: String?
    var projects = [Project]()
    
    var selectedIndex: Int?
    
    @IBOutlet weak var algorithmBarView: UIView!
    @IBOutlet weak var projectBarView: UIView!
    @IBOutlet weak var csStudyBarView: UIView!
    
    @IBOutlet weak var bojView: WKWebView!
    @IBOutlet weak var projectStackView: UIStackView!
    @IBOutlet weak var grassView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("My Stack")
        
        if let savedProjects = Project.loadProjects() {
            projects = savedProjects
        } else {
            projects = Project.loadSampleProjects()
        }

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
        if let handle = bojUsername {
            let width = self.view.frame.width - 40
            let scale = width * 0.00136
            bojView.isHidden = false
            bojView.scrollView.isScrollEnabled = false
            bojView.loadHTMLString(bojStatHtml(scale, handle), baseURL: nil)
        } else {
            bojView.isHidden = true
        }
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
    }
    
    func updateGrass() {
        guard let username = gitHubUsername else { return }
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
        
        present(alert, animated: true)
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
