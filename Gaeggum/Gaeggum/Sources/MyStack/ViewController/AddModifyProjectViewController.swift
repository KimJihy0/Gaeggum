//
//  AddModifyProjectViewController.swift
//  Gaeggum
//
//  Created by Jihyo on 2022/05/15.
//

import UIKit

class AddModifyProjectViewController: UITableViewController {
    
    var project: Project?
    
    enum Task {
    case create, update
    }
    var task: Task = .create

    let years = Array(1...10000)
    let months = Array(repeating: Array(1...12), count: 10000/12).flatMap { $0 } + Array(1...4)
    
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
            
            projectNavigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveButtonTapped(_:)))
            
            titleTextField.text = project.title
            selectedStartDate = project.startDate
            selectedEndDate = project.endDate ?? YearMonth()
            onGoingSwitch.isOn = project.isOnGoing
            contentTextView.text = project.content
        } else {
            task = .create
            projectNavigationItem.title = "새로운 프로젝트"
            
            projectNavigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped(_:)))
            
            deleteLabel.isHidden = true
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
        startDatePicker.selectRow(selectedStartDate.month + 5003, inComponent: 1, animated: true)
        endDatePicker.selectRow(selectedEndDate.year - 1, inComponent: 0, animated: true)
        endDatePicker.selectRow(selectedEndDate.month + 5003, inComponent: 1, animated: true)
    }
    
    func updateTableView() {
        if onGoingSwitch.isOn {
            isEndDateLabelShown = false
            isEndDatePickerShown = false
        } else {
            isEndDateLabelShown = true
        }
        
        isValidTerm = selectedStartDate <= selectedEndDate || onGoingSwitch.isOn
        
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    @IBAction func onGoingSwitchValueChanged(_ sender: Any) {
        updateTableView()
    }
    
    @IBAction func titleEditingChanged(_ sender: Any) {
        updateSaveButton()
    }
    
    @IBAction func returnPressed(_ sender: Any) {
        titleTextField.resignFirstResponder()
    }
    
    @objc func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard isValidTerm else {
            let alert = UIAlertController(title: "프로젝트를 저장할 수 없음", message: "시작 날짜는 종료 날짜 이전이어야 합니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            present(alert, animated: false)
            return
        }
        
        switch task {
        case .update: performSegue(withIdentifier: "UpdateProjectUnwind", sender: self)
        case .create: performSegue(withIdentifier: "CreateProjectUnwind", sender: self)
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0: return "\(years[row])년"
        case 1: return "\(months[row])월"
        default: return ""
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
        return 100
    }
    
}
