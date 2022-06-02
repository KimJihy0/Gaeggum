//
//  FindCareerViewController.swift
//  Gaeggum
//
//  Created by zeroStone ⠀ on 2022/04/22.
//

import UIKit

class FindCareerViewController: UIViewController {
    var searchFilter: [Career] = []
    var tagList: [Hashtag] = []
    
    @IBOutlet weak var careerTable: UITableView!
    @IBOutlet weak var tagCollectionView: UICollectionView!

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
        setupCollectionView()
        testCollectionView()
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
    
    func setupCollectionView() {
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
    
        
        // let layout = TagLeftAlignedCollectionViewFlowLayout()
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        layout.sectionInset = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        
        tagCollectionView.frame.size.height = 40
        tagCollectionView.collectionViewLayout = layout
        tagCollectionView.backgroundColor = UIColor.white
        tagCollectionView.register(TagCell.classForCoder(), forCellWithReuseIdentifier: "TagCell")
    }
    
    func testCollectionView() {
        for i in 0...4 {
            tagList.append(dummyTag[4])
        }
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

extension FindCareerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // cell 크기 결정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tagCell = TagCell()
        let label = UILabel()
        label.font = .systemFont(ofSize: tagCell.fontSize)
        label.text = tagList[indexPath.item].ability.rawValue
        label.sizeToFit()

        let size = label.frame.size

        return CGSize(width: size.width + 16, height: size.height + 10)
    }

    // cell 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }

    // cell 텍스트 입력
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tagCollectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell

        // cell.backgroundColor = UIColor.lightGray
        // cell.tagLabel.text = tagList[indexPath.item].ability.rawValue

        return cell
    }
    
    // cell 탭
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            // handle tap events
            print("You selected cell #\(indexPath.item)!")
        }

}
