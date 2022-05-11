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

let projects: [Project] = [
    Project(startDate: Date(), endDate: Date(), content: "test content"),
    Project(startDate: Date(), endDate: Date(), content: "s\ne\n\n\n\n\nc\no\nnd test and very very very long text test more more more more more long text"),
]

class MyStackViewController : UIViewController {
    
    @IBOutlet weak var algorithmBarView: UIView!
    @IBOutlet weak var projectBarView: UIView!
    @IBOutlet weak var csStudyBarView: UIView!
    
    @IBOutlet weak var bojView: WKWebView!
    @IBOutlet weak var projectStackView: UIStackView!
    @IBOutlet weak var grassView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("My Stack")

        setGraph(40, 50, 10)
        setBoj(of: "hyo0508")
        setGrass(of: "san9w9n")
        setProjects()
    }
    
    func setGraph(_ algorithmPercent: Int, _ projectPercent: Int, _ csStudyPercent: Int) {
        let cornerRadius = 5.0
        algorithmBarView.layer.cornerRadius = cornerRadius
        projectBarView.layer.cornerRadius = cornerRadius
        csStudyBarView.layer.cornerRadius = cornerRadius
        
        algorithmBarView.heightAnchor.constraint(equalToConstant: CGFloat(algorithmPercent * 2)).isActive = true
        projectBarView.heightAnchor.constraint(equalToConstant: CGFloat(projectPercent * 2)).isActive = true
        csStudyBarView.heightAnchor.constraint(equalToConstant: CGFloat(csStudyPercent * 2)).isActive = true
    }
    
    func setBoj(of handle: String) {
        let width = self.view.frame.width - 40
        let scale = width * 0.00135897
    
        let html = """
        <html>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=\(scale), maximum-scale=\(scale), minimum-scale=\(scale), user-scalable=0">
            </head>
            <body>
                <img src="https://github-readme-solvedac.hyp3rflow.vercel.app/api/?handle=\(handle)">
            </body>
        </html>
        """
        bojView.scrollView.isScrollEnabled = false
        bojView.loadHTMLString(html, baseURL: nil)
    }
    
    func setProjects() {
        let _ = projects.map {
                self.projectStackView.addArrangedSubview(toView($0))
            }
    }
    
    func toView(_ project: Project) -> UIView {
        
        let superView = UIView()
        
        let line = UIView()
        line.backgroundColor = .darkGray
        superView.addSubview(line)
        line.anchor(top: superView.topAnchor, left: superView.leftAnchor, bottom: superView.bottomAnchor, paddingLeft: 10, width: 2)
        
        let circle = UIView()
        circle.backgroundColor = .white // junk
        circle.borderWidth = 1
        circle.borderColor = .darkGray
        circle.cornerRadius = 3
        superView.addSubview(circle)
        circle.anchor(width: 7, height: 14)
        circle.centerXAnchor.constraint(equalTo: line.centerXAnchor).isActive = true
        circle.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
        
        let termLabel = UILabel()
        termLabel.text = toTerm(project.startDate, project.endDate)
        termLabel.textColor = .darkGray
        termLabel.numberOfLines = 2
        superView.addSubview(termLabel)
        termLabel.anchor(top: superView.topAnchor, left: line.rightAnchor, bottom: superView.bottomAnchor, paddingTop: 5, paddingLeft: 15, width: 90)
        
        let contentLabel = UILabel()
        contentLabel.text = project.content
        print(project.content)
        contentLabel.numberOfLines = 0
        superView.addSubview(contentLabel)
        contentLabel.anchor(top: superView.topAnchor, left: termLabel.rightAnchor, bottom: superView.bottomAnchor, right: superView.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5)
        
        return superView
    }
    func toTerm(_ startDate: Date, _ endDate: Date?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM"
        
        var term : String
        term = formatter.string(from: startDate) + " ~"
        if let endDate = endDate {
            term = term + "\n" + formatter.string(from: endDate)
        }
        
        return term
    }
    
    func setGrass(of username: String) {
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
