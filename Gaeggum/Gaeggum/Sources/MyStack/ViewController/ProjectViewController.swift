//
//  addProjectViewController.swift
//  Gaeggum
//
//  Created by Jihyo on 2022/05/12.
//

import UIKit

class ProjectViewController: UIViewController {
    
    @IBOutlet weak var navigationTitle: UINavigationItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var isToModify: Bool = false
    var startDate: Date? = nil
    var endDate: Date? = nil
    var content: String? = nil
    var index: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationTitle.title = isToModify ? "프로젝트 편집" : "새로운 프로젝트"
        self.tableView.backgroundColor = .systemGroupedBackground
    }
    
    @IBAction func textEditingChagned(_ sender: Any) {
        let contentCell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! ContentCell
        saveButton.isEnabled = contentCell.contentTextField.hasText
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let startDateCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! DateCell
        let endDateCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! DateCell
        let contentCell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! ContentCell
        
        self.startDate = startDateCell.datePicker.date
        self.endDate = endDateCell.datePicker.date
        self.content = contentCell.contentTextField.text
    }

}

extension ProjectViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isToModify {
            return 3
        } else {
            return 2
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 1
        case 2: return 1
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! DateCell
            cell.titleLabel.text = "시작"
            cell.datePicker.setDate(self.startDate ?? Date(), animated: false)
            cell.selectionStyle = .none
            return cell
        case (0, 1):
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! DateCell
            cell.titleLabel.text = "종료"
            cell.datePicker.setDate(self.endDate ?? Date(), animated: false)
            cell.selectionStyle = .none
            return cell
        case (1, 0):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as! ContentCell
            cell.contentTextField.text = self.content ?? nil
            cell.selectionStyle = .none
            return cell
        case (2, 0):
            let cell = tableView.dequeueReusableCell(withIdentifier: "DeleteCell", for: indexPath) as! DeleteCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}
