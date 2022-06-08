//
//  FindCareerViewController.swift
//  Gaeggum
//
//  Created by zeroStone ⠀ on 2022/04/22.
//

import UIKit

class FindCareerViewController: UIViewController {
    var tagList: [Hashtag] = []
    
    var searchFilter: [Career] = []
    var tagFilter: [Career] = []
    
    var displayCareer : [Career] = []
    
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
        setupTagEditButton()
        setupCollectionView()
        testCollectionView()
        updateTagResults()
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
    
        
        let layout = TagLeftAlignedCollectionViewFlowLayout()
        // let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        layout.sectionInset = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        
        tagCollectionView.frame.size.height = 40
        tagCollectionView.collectionViewLayout = layout
        tagCollectionView.backgroundColor = UIColor.white
        tagCollectionView.register(TagCell.classForCoder(), forCellWithReuseIdentifier: "TagCell")
    }
    
    func setupTagEditButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "•••", style: .plain, target: nil, action: nil)
        
        let tagEdit = UIAction(title: "태그 편집", image: nil, handler: { _ in print("태그 편집") })
        let test = UIAction(title: "test") {
            (action) in
            if self.tagList.count == 0 {
                self.testCollectionView()
                self.updateTagResults()
                self.tagCollectionView.reloadData()
                self.careerTable.reloadData()
            }
        }
        
        self.navigationItem.rightBarButtonItem?.menu = UIMenu(title: "타이틀", image: nil, identifier: nil, options: .displayInline, children: [tagEdit, test])
    }
    
    func updateTagResults() {
        self.tagFilter = []
        
        if tagList.count == 0 {
            dump(tagFilter)
            
            return
        }
        
        for career in dummyCareer {
            for tag in tagList {
                if career.abilities.contains(tag.ability) {
                    self.tagFilter.append(career)
                    break;
                }
            }
        }
        dump(tagFilter)
    }
    
    func testCollectionView() {
        for i in 0...2 {
            tagList.append(dummyTag[i])
        }
    }
}
    
extension FindCareerViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  self.displayCareer = (tagList.count == 0) ? dummyCareer : self.tagFilter
        if(tagList.count == 0) {
            self.displayCareer = dummyCareer
            tagCollectionView.isHidden = true
            tagCollectionView.frame.size.height = 0
        } else {
            self.displayCareer = self.tagFilter
            tagCollectionView.isHidden = false
            tagCollectionView.frame.size.height = 40
        }
        
        return self.isFiltering ? self.searchFilter.count : displayCareer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CareerCell", for: indexPath) as! CareerCell

        print(displayCareer[0])
        let currentCareer = isFiltering ? self.searchFilter[indexPath.row] : displayCareer[indexPath.row]
        
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
        
        if(isFiltering) {
            tagCollectionView.isHidden = true
            tagCollectionView.frame.size.height = 0
        }
        /*
        tagCollectionView.isHidden = isFiltering ? true : false
        tagCollectionView.frame.size.height = isFiltering ? 0 : tagCollectionView.frame.size.height
         */
    }
}

extension FindCareerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // cell 크기 결정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tagCell = TagCell()
        let label = UILabel()
        label.font = .systemFont(ofSize: tagCell.fontSize)
        label.text = "# " + tagList[indexPath.item].ability.rawValue
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

        cell.tagLabel.text = "# " + tagList[indexPath.item].ability.rawValue

        return cell
    }
    
    // cell 탭
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /*
        let cell = tagCollectionView.cellForItem(at: indexPath)!
        
        if cell.backgroundColor == tagList[indexPath.item].tagColor { cell.layer.borderColor = UIColor.systemGray5.cgColor}
        else { cell.layer.borderColor = tagList[indexPath.item].tagColor.cgColor }
        */
        
        collectionView.deleteItems(at: [IndexPath(row: indexPath.item, section: 0)])
        tagList.remove(at: indexPath.item)
        
        updateTagResults()
        self.careerTable.reloadData()
        
        print("You selected cell #\(indexPath.item)!")
    }
}
