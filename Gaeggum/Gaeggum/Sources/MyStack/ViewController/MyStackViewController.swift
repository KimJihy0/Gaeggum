//
//  MyStackViewController.swift
//  Gaeggum
//
//  Created by zeroStone ⠀ on 2022/04/22.
//

import UIKit
import SwiftUI
import WebKit

class MyStackViewController : UIViewController {
    
    @IBOutlet weak var algorithmBarView: UIView!
    @IBOutlet weak var projectBarView: UIView!
    @IBOutlet weak var csStudyBarView: UIView!
    
    @IBOutlet weak var bojView: WKWebView!
    @IBOutlet weak var grassView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("My Stack")

        setGraph(40, 50, 10)
        setBoj(of: "hyo0508")
        setGrass(of: "san9w9n")
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
