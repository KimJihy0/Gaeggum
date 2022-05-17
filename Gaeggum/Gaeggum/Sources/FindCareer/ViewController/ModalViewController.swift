//
//  ModalViewController.swift
//  Gaeggum
//
//  Created by 상현 on 2022/05/14.
//

import UIKit

class ModalViewController: UIViewController {
    @IBOutlet weak var careerDetailView: CareerDetailView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var career: Career?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        if let career = career {
            navBar.topItem?.title = career.name
            careerDetailView.updateCareer(career: career)
        }
    }
}
    
