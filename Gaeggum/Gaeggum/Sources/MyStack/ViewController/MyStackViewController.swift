//
//  MyStackViewController.swift
//  Gaeggum
//
//  Created by zeroStone ⠀ on 2022/04/22.
//

import UIKit
import SwiftUI
import WebKit

struct Project {
    var startDate: Date
    var endDate: Date?
    var content: String
}


var bojUserName: String = "hyo0508"
var gitHubUserNmae: String = "san9w9n"

class MyStackViewController : UIViewController, UIGestureRecognizerDelegate {
    
    var projects: [Project] = [
        Project(startDate: Date(), endDate: Date(), content: "test content"),
        Project(startDate: Date(), endDate: Date(), content: "s\ne\n\n\n\n\nc\no\nnd test and very very very long text test more more more more more long text"),
    ]
    var index: Int? = nil
    
    @IBOutlet weak var algorithmBarView: UIView!
    @IBOutlet weak var projectBarView: UIView!
    @IBOutlet weak var csStudyBarView: UIView!
    
    @IBOutlet weak var bojView: WKWebView!
    @IBOutlet weak var projectStackView: UIStackView!
    @IBOutlet weak var grassView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("My Stack")

        updateGraph(40, 50, 10)
        updateBoj(of: bojUserName)
        updateGrass(of: gitHubUserNmae)
        updateProjects(projects)
    }
    
    func updateGraph(_ algorithmPercent: Int, _ projectPercent: Int, _ csStudyPercent: Int) {
        let cornerRadius = 5.0
        algorithmBarView.layer.cornerRadius = cornerRadius
        projectBarView.layer.cornerRadius = cornerRadius
        csStudyBarView.layer.cornerRadius = cornerRadius
        
        algorithmBarView.heightAnchor.constraint(equalToConstant: CGFloat(algorithmPercent * 2)).isActive = true
        projectBarView.heightAnchor.constraint(equalToConstant: CGFloat(projectPercent * 2)).isActive = true
        csStudyBarView.heightAnchor.constraint(equalToConstant: CGFloat(csStudyPercent * 2)).isActive = true
    }
    
    func updateBoj(of handle: String) {
        let width = self.view.frame.width - 40
        let scale = width * 0.00135897
        bojView.scrollView.isScrollEnabled = false
        bojView.loadHTMLString(toHtml(scale, handle), baseURL: nil)
    }
    
    func updateProjects(_ projects: [Project]) {
        projectStackView.arrangedSubviews.forEach { (view) in
            projectStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        let projectViews = projects.map {
            toView($0)
        }
        
        for (index, element) in projectViews.enumerated() {
            let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didTapView(_:)))
            element.tag = index
            self.projectStackView.addArrangedSubview(element)
            element.addGestureRecognizer(longPressGestureRecognizer)
        }
        
    }
    
    @objc func didTapView(_ sender: UILongPressGestureRecognizer) {
        self.index = sender.view!.tag
        performSegue(withIdentifier: "ModifySegue", sender: nil)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ModifySegue" {
            let src = segue.source as! MyStackViewController
            let dest = segue.destination as! AddProjectViewController
            dest.isToModify = true
            dest.startDate = src.projects[self.index!].startDate
            dest.endDate = src.projects[self.index!].endDate
            dest.content = src.projects[self.index!].content
            dest.index = src.index
        } else {
            let dest = segue.destination as! AddProjectViewController
            dest.isToModify = false
            dest.startDate = nil
            dest.endDate = nil
            dest.content = nil
            dest.index = nil
        }
    }
    
    @IBAction func unwindToMyStack(_ unwindSegue: UIStoryboardSegue) {
//        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
    @IBAction func saveProject(_ sender: UIStoryboardSegue) {
        if let from = sender.source as? AddProjectViewController {
            if let index = from.index {
                projects[index] = Project(startDate: from.startDate!, endDate: from.endDate!, content: from.content!)
                updateProjects(projects)
            } else {
                projects.append(Project(startDate: from.startDate!, endDate: from.endDate!, content: from.content!))
                updateProjects(projects)
            }
        }
    }
}
