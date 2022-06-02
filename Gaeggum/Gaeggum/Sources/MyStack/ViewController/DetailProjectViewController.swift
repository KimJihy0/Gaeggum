//
//  DetailProjectViewController.swift
//  Gaeggum
//
//  Created by Jihyo on 2022/05/16.
//

import UIKit

class DetailProjectViewController: UITableViewController {

    var project: Project?
    
    var projectDelegate: ProjectDelegate?
    
    let maxContentLine: Int = 8
    
    let urlIndexPath = IndexPath(row: 1, section: 0)
    let contentIndexPath = IndexPath(row: 2, section: 0)
    
    @IBOutlet weak var projectNavigationItem: UINavigationItem!
    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var urlTitleLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var contentTitleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if URL(string: urlLabel.text ?? "") != nil {
            let tap = UITapGestureRecognizer(target: self, action: #selector(tap))
            urlLabel.textColor = .link
            urlLabel.isUserInteractionEnabled = true
            urlLabel.addGestureRecognizer(tap)
        } else {
            print("unvalid url")
            urlLabel.textColor = .systemGray
        }
        
        updateProject()
    }
    
    func updateProject() {
        guard let project = project else { return }
        
        projectNavigationItem.title = project.title
        termLabel.text = project.detailTerm
        contentLabel.text = project.content
        urlLabel.text = project.url
        
        urlTitleLabel.isHidden = urlLabel.text == ""
        contentTitleLabel.isHidden = contentLabel.text == ""
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @objc func tap() {
        guard let url = URL(string: urlLabel.text ?? "") else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:])
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == urlIndexPath && urlTitleLabel.isHidden {
            return 0
        }
        if indexPath == contentIndexPath && contentTitleLabel.isHidden {
            return 0
        }
        return tableView.estimatedRowHeight
    }
    
}
    
// MARK: - Navigation

extension DetailProjectViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "EditProjectSegue":
            let navigationController = segue.destination as! UINavigationController
            let destViewController = navigationController.topViewController as! AddModifyProjectViewController
            destViewController.project = self.project
            
        default:
            break
        }
        
    }
    
    @IBAction func unwindToDetailProject(_ unwindSegue: UIStoryboardSegue) {
        
        switch unwindSegue.identifier {
        case "UpdateProjectUnwind":
            let sourceViewController = unwindSegue.source as! AddModifyProjectViewController
            guard let project = sourceViewController.project else { return }
            
            projectDelegate?.projectUpdated(project: project)
            self.project = project
            updateProject()
            
        default:
            break
        }
        
    }

}


