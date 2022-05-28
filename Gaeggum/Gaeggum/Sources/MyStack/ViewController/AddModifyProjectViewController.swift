//
//  AddModifyProjectViewController.swift
//  Gaeggum
//
//  Created by Jihyo on 2022/05/15.
//

import UIKit

class AddModifyProjectViewController: UITableViewController {
    
    var project: Project?
    
    enum Task { case create, update }
    var task: Task = .create

    let years = Array(0...9999).map { $0 + 1 }
    let months = Array(0...9999).map { $0 % 12 + 1 }
    
    var selectedStartDate: YearMonth = YearMonth()
    var selectedEndDate: YearMonth = YearMonth()
    
    let startDateLabelIndexPath = IndexPath(row: 1, section: 1)
    let startDatePickerIndexPath = IndexPath(row: 2, section: 1)
    let endDateLabelIndexPath = IndexPath(row: 3, section: 1)
    let endDatePickerIndexPath = IndexPath(row: 4, section: 1)
    let deleteCellIndexPath = IndexPath(row: 0, section: 3)
    
    var isStartDatePickerShown: Bool = false {
        didSet {
            startDatePicker.isHidden = !isStartDatePickerShown
            startDateLabel.textColor = isStartDatePickerShown ? tableView.tintColor : .none
        }
    }
    
    var isEndDatePickerShown: Bool = false {
        didSet {
            endDatePicker.isHidden = !isEndDatePickerShown
            endDateLabel.textColor = isEndDatePickerShown ? tableView.tintColor : .none
        }
    }
    
    var isEndDateLabelShown: Bool = true {
        didSet {
            endDateLabel.isHidden = !isEndDateLabelShown
        }
    }
    
    var isValidTerm: Bool = true {
        didSet {
            isValidTerm ?
            endDateLabel.unstrikethrough(from: endDateLabel.text) :
            endDateLabel.strikethrough(from: endDateLabel.text)
        }
    }
    
    @IBOutlet weak var projectNavigationItem: UINavigationItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var onGoingSwitch: UISwitch!
    @IBOutlet weak var startDatePicker: UIPickerView!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDatePicker: UIPickerView!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var deleteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let project = project {
            task = .update
            projectNavigationItem.title = "프로젝트 수정"
            
            titleTextField.text = project.title
            selectedStartDate = project.startDate
            selectedEndDate = project.endDate ?? YearMonth()
            onGoingSwitch.isOn = project.isOnGoing
            contentTextView.text = project.content
        } else {
            task = .create
            projectNavigationItem.title = "새로운 프로젝트"
        }
        
        updateSaveButton()
        updateDateLabels()
        updateDatePicker()
        updateTableView()
    }
    
    func updateSaveButton() {
        let titleText = titleTextField.text ?? ""
        projectNavigationItem.rightBarButtonItem?.isEnabled = !titleText.isEmpty
    }
    
    func updateDateLabels() {
        startDateLabel.text = selectedStartDate.string
        endDateLabel.text = selectedEndDate.string
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func updateDatePicker() {
        startDatePicker.selectRow(selectedStartDate.year - 1, inComponent: 0, animated: true)
        startDatePicker.selectRow(selectedStartDate.month - 1 + 5000/12*12, inComponent: 1, animated: true)
        endDatePicker.selectRow(selectedEndDate.year - 1, inComponent: 0, animated: true)
        endDatePicker.selectRow(selectedEndDate.month - 1 + 5000/12*12, inComponent: 1, animated: true)
    }
    
    func updateTableView() {
        if onGoingSwitch.isOn {
            isEndDateLabelShown = false
            isEndDatePickerShown = false
        } else {
            isEndDateLabelShown = true
        }
        
        isValidTerm = selectedStartDate <= selectedEndDate || onGoingSwitch.isOn
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func onGoingSwitchValueChanged(_ sender: Any) {
        updateTableView()
    }
    
    @IBAction func titleEditingChanged(_ sender: Any) {
        updateSaveButton()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard isValidTerm else {
            let alert = UIAlertController(title: "프로젝트를 저장할 수 없음", message: "시작 날짜는 종료 날짜 이전이어야 합니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            present(alert, animated: true)
            return
        }
        
        switch task {
        case .update: performSegue(withIdentifier: "UpdateProjectUnwind", sender: self)
        case .create: performSegue(withIdentifier: "CreateProjectUnwind", sender: self)
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
        switch task {
        case .update:
            let title = titleTextField.text ?? ""
            let startDate = selectedStartDate
            let endDate = onGoingSwitch.isOn ? nil : selectedEndDate
            let isOnGoing = onGoingSwitch.isOn
            let content = contentTextView.text ?? ""
            let inputProject = Project(title: title, startDate: startDate, endDate: endDate, isOnGoing: isOnGoing, content: content)
            
            if inputProject == project! {
                dismiss(animated: true)
            } else {
                let alert = UIAlertController(title: nil, message: "이 변경 사항을 폐기하겠습니까?", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "변경 사항 폐기", style: .destructive) { _ in
                    self.dismiss(animated: true)
                })
                alert.addAction(UIAlertAction(title: "계속 편집하기", style: .cancel))
                present(alert, animated: true)
            }
        case .create:
            dismiss(animated: true)
        }
    }
}

// MARK: - Navigation

extension AddModifyProjectViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "UpdateProjectUnwind", "CreateProjectUnwind":
            let title = titleTextField.text ?? ""
            let startDate = selectedStartDate
            let endDate = onGoingSwitch.isOn ? nil : selectedEndDate
            let isOnGoing = onGoingSwitch.isOn
            let content = contentTextView.text ?? ""
            self.project = Project(title: title, startDate: startDate, endDate: endDate, isOnGoing: isOnGoing, content: content)
            
        default:
            break
        }
        
    }

}
    
// MARK: - Table view

extension AddModifyProjectViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case startDatePickerIndexPath:
            if !isStartDatePickerShown {
                return 0
            }
        case endDateLabelIndexPath:
            if !isEndDateLabelShown {
                return 0
            }
        case endDatePickerIndexPath:
            if !isEndDatePickerShown {
                return 0
            }
        case deleteCellIndexPath:
            if task == .create {
                return 0
            }
        default:
            break
        }
        return tableView.estimatedRowHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case startDateLabelIndexPath:
            if isStartDatePickerShown {
                isStartDatePickerShown = false
            } else if isEndDatePickerShown {
                isEndDatePickerShown = false
                isStartDatePickerShown = true
            } else {
                isStartDatePickerShown = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case endDateLabelIndexPath:
            if isEndDatePickerShown {
                isEndDatePickerShown = false
            } else if isStartDatePickerShown {
                isStartDatePickerShown = false
                isEndDatePickerShown = true
            } else {
                isEndDatePickerShown = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case deleteCellIndexPath:
            let alert = UIAlertController(title: nil, message: "이 프로젝트를 삭제하겠습니까?", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "프로젝트 삭제", style: .destructive) { _ in
                self.performSegue(withIdentifier: "DeleteProjectUnwind", sender: self)
            })
            alert.addAction(UIAlertAction(title: "취소", style: .cancel))
            present(alert, animated: true)
            
        default:
            break
        }
    }
}

// MARK: - Picker view

extension AddModifyProjectViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return years.count
        case 1: return months.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        switch component {
        case 0:
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .right
            return NSAttributedString(string:"\(years[row])년", attributes: [.paragraphStyle: paragraphStyle])
        case 1:
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            return NSAttributedString(string:"\(months[row])월", attributes: [.paragraphStyle: paragraphStyle])
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch (pickerView, component) {
        case (startDatePicker, 0):
            selectedStartDate.year = years[row]
        case (startDatePicker, 1):
            selectedStartDate.month = months[row]
        case (endDatePicker, 0):
            selectedEndDate.year = years[row]
        case (endDatePicker, 1):
            selectedEndDate.month = months[row]
        default: break
        }
        isValidTerm = selectedStartDate <= selectedEndDate || onGoingSwitch.isOn
        
        updateDateLabels()
        updateSaveButton()
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 110
    }
    
}

// MARK: - Keyboard

extension AddModifyProjectViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.titleTextField.becomeFirstResponder()
    }
    
    @IBAction func returnPressed(_ sender: Any) {
        titleTextField.resignFirstResponder()
    }
    
}
