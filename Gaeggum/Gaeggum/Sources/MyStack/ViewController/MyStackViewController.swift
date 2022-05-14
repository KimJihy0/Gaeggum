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
    
    var bojUserName: String = "hyo0508"
    var gitHubUserNmae: String = "hyo0508"
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
        updateBoj(of: bojUserName)
        updateGrass(of: gitHubUserNmae)
        updateProjects(projects)
    }
    
    func updateGraph(_ algorithmPercent: CGFloat, _ projectPercent: CGFloat, _ csStudyPercent: CGFloat) {
        algorithmBarView.anchor(height: algorithmPercent * 2)
        projectBarView.anchor(height: projectPercent * 2)
        csStudyBarView.anchor(height: csStudyPercent * 2)
    }
    
    func updateBoj(of handle: String) {
        let width = self.view.frame.width - 40
        let scale = width * 0.00136
        bojView.scrollView.isScrollEnabled = false
        bojView.loadHTMLString(bojStatHtml(scale, handle), baseURL: nil)
    }
    
    func updateProjects(_ projects: [Project]) {
        projectStackView.arrangedSubviews.forEach { (view) in
            projectStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        projects.enumerated().forEach { (index, project) in
            let projectView = project.view
            projectView.tag = index
            projectView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(didLongPressView(_:))))
            self.projectStackView.addArrangedSubview(projectView)
        }
    }
    
    func updateGrass(of username: String) {
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
        updateProjects(projects)
    }
    
    @IBAction func saveProject(_ unwindSegue: UIStoryboardSegue) {
        let src = unwindSegue.source as! ProjectViewController
        if let index = src.index {
            projects[index] = Project(startDate: src.startDate!, endDate: src.endDate!, content: src.content!)
        } else {
            projects.append(Project(startDate: src.startDate!, endDate: src.endDate!, content: src.content!))
        }
        updateProjects(projects)
    }
    
}
