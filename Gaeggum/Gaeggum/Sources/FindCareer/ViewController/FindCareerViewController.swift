//
//  FindCareerViewController.swift
//  Gaeggum
//
//  Created by zeroStone ⠀ on 2022/04/22.
//

import UIKit

class FindCareerViewController: UIViewController {
    var searchFilter: [Career] = []
    @IBOutlet weak var careerTable: UITableView!
    
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
            
        return isActive && isSearchBarHasText
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let vc = segue.destination as?ModalViewController
            if let index = sender as? Int {
                vc?.career = self.isFiltering ? self.searchFilter[index] : dummyCareer[index]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }
    
    func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchBar.placeholder = "직업 찾기"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.automaticallyShowsCancelButton = true
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        searchController.searchResultsUpdater = self

        self.navigationItem.searchController = searchController
    }
}
    
extension FindCareerViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isFiltering ? self.searchFilter.count : dummyCareer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CareerCell", for: indexPath) as! CareerCell

        let currentCareer = isFiltering ? self.searchFilter[indexPath.row] : dummyCareer[indexPath.row]
        
        // Configure the cell...
        cell.careerLabel.text = currentCareer.name

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("--> \(indexPath.row)")
        performSegue(withIdentifier: "showDetail", sender: indexPath.row)
        tableView.deselectRow(at: indexPath , animated: true)
    }
}

extension FindCareerViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.lowercased() else { return }
        
        self.searchFilter = []
        for career in dummyCareer {
            if career.name.localizedCaseInsensitiveContains(text) {
                self.searchFilter.append(career)
            }
        }
        dump(searchFilter)
            
        self.careerTable.reloadData()
    }
}
