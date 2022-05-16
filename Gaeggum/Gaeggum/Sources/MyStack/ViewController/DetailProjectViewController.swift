//
//  DetailProjectViewController.swift
//  Gaeggum
//
//  Created by Jihyo on 2022/05/16.
//

import UIKit

class DetailProjectViewController: UITableViewController {

    var project: Project?
    
    let maxContentLine: Int = 8
    
    let contentIndexPath = IndexPath(row: 1, section: 0)
    let fullContentIndexPath = IndexPath(row: 2, section: 0)
    
    var projectDelegate: ProjectDelegate?
    
    @IBOutlet weak var projectNavigationItem: UINavigationItem!
    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var contentTitleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var fullContentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateProject()
    }
    
    func updateProject() {
        guard let project = project else { return }
        
        projectNavigationItem.title = project.title
        if (project.isOnGoing) {
            termLabel.text = "\(project.startDate.year)년 \(project.startDate.month)월부터\n진행 중"
        } else if project.startDate == project.endDate {
            termLabel.text = "\(project.startDate.year)년 \(project.startDate.month)월"
        } else {
            termLabel.text = "\(project.startDate.year)년 \(project.startDate.month)월부터\n\(project.endDate!.year)년 \(project.endDate!.month)월까지"
        }
        contentLabel.text = project.content
        
        if contentLabel.text == "" {
            contentTitleLabel.isHidden = true
        }
        
        if (contentLabel.countCurrentLines() <= maxContentLine) {
            fullContentLabel.isHidden = true
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == contentIndexPath && contentTitleLabel.isHidden {
            return 0
        }
        if indexPath == fullContentIndexPath && fullContentLabel.isHidden {
            return 0
        }
        return tableView.estimatedRowHeight
    }
    
}
    
// MARK: - Navigation

extension DetailProjectViewController {
    
    @IBAction func unwindToDetailProject(_ unwindSegue: UIStoryboardSegue) {
        switch unwindSegue.identifier {
            
        case "UpdateProjectUnwind":
            let sourceViewController = unwindSegue.source as! AddModifyProjectViewController
            
            self.project = sourceViewController.project
            updateProject()
            
            if let delgate = projectDelegate, let project = self.project {
                delgate.projectUpdated(project: project)
            }
            
        default:
            break
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            
        case "EditProjectSegue":
            let destViewController = segue.destination as! AddModifyProjectViewController
            destViewController.project = self.project
            
        default:
            break
        }
        
    }

}


