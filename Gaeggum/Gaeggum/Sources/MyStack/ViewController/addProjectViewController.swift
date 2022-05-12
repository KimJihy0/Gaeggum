//
//  addProjectViewController.swift
//  Gaeggum
//
//  Created by Jihyo on 2022/05/12.
//

import UIKit

class AddProjectViewController: UIViewController {
    
    @IBOutlet weak var navigationTitle: UINavigationItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    var isToModify : Bool = false
    var startDate: Date? = nil
    var endDate: Date? = nil
    var content: String? = nil
    var index: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isToModify {
            navigationTitle.title = "프로젝트 편집"
        }
        self.tableView.backgroundColor = .systemGray6
    }
    
    @IBAction func textEditingChagned(_ sender: Any) {
        let contentCell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! ContentCell
        if contentCell.contentTextField.hasText {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let startDateCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! DateCell
        let endDateCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! DateCell
        let contentCell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! ContentCell
        
        self.startDate = startDateCell.datePicker.date
        self.endDate = endDateCell.datePicker.date
        self.content = contentCell.contentTextField.text
    }

}

extension AddProjectViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return [2, 1][section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! DateCell
            cell.titleLabel.text = ["시작", "종료"][indexPath.row]
            if indexPath.row == 0 {
                if let startDate = self.startDate {
                    cell.datePicker.setDate(startDate, animated: false)
                }
            } else {
                if let endDate = self.endDate {
                    cell.datePicker.setDate(endDate, animated: false)
                }
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as! ContentCell
            if let content = self.content {
                cell.contentTextField.text = content
            }
            return cell
        }
    }
}
