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
        setupSize()
        setupSearchBar()
        setupCollectionView()
        updateTagResults()
    }
    
    func setupSize() {
        tagCollectionView.frame.size.width = UIScreen.main.bounds.size.width
        careerTable.frame.size.width = UIScreen.main.bounds.size.width
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
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        layout.sectionInset = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        
        tagCollectionView.frame.size.height = (UIScreen.main.bounds.size.width >= 400) ? 80 : 120
        tagCollectionView.collectionViewLayout = layout
        tagCollectionView.backgroundColor = UIColor.white
        tagCollectionView.register(TagCell.classForCoder(), forCellWithReuseIdentifier: "TagCell")
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
}
    
extension FindCareerViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.displayCareer = (tagList.count == 0) ? dummyCareer : self.tagFilter
        
        return self.isFiltering ? (self.searchFilter.count + 1) : (displayCareer.count + 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CareerCell", for: indexPath) as! CareerCell

        let cellCount = self.isFiltering ? self.searchFilter.count : displayCareer.count
        if indexPath.row >= cellCount {
            cell.careerLabel.text = nil
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets.init(top: 0, left: 400, bottom: 0, right: 0)
            
            return cell
        }
        
        let currentCareer = isFiltering ? self.searchFilter[indexPath.row] : displayCareer[indexPath.row]
        
        // Configure the cell...
        cell.careerLabel.text = currentCareer.name
        cell.frame.size.width = UIScreen.main.bounds.size.width
        cell.separatorInset = .zero

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellCount = self.isFiltering ? self.searchFilter.count : displayCareer.count
        if indexPath.row >= cellCount {
            return
        }
        
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
        } else {
            tagCollectionView.isHidden = false
            tagCollectionView.frame.size.height = (UIScreen.main.bounds.size.width >= 375) ? 80 : 120
        }
    }
}

extension FindCareerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // cell 크기 결정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tagCell = TagCell()
        let label = UILabel()
        label.font = .systemFont(ofSize: tagCell.fontSize)
        label.text = "# " + dummyTag[indexPath.item].ability.rawValue
        label.sizeToFit()

        let size = label.frame.size

        return CGSize(width: size.width + 25, height: size.height + 15)
    }

    // cell 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyTag.count
    }

    // cell 텍스트 입력
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {        
        let cell = tagCollectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell

        cell.tagLabel.text = "# " + dummyTag[indexPath.item].ability.rawValue
        
        if dummyTag[indexPath.item].selected {
            cell.contentView.backgroundColor = UIColor(rgb: 0x19A9DE )
            cell.tagLabel.textColor = UIColor.white
        } else {
            cell.contentView.backgroundColor = .systemGray5
            cell.tagLabel.textColor = UIColor.gray
        }
        
        return cell
    }
    
    // cell 탭
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(dummyTag[indexPath.item].selected) {
            dummyTag[indexPath.item].selected = false
            var index : Int = 0
            for tag in tagList {
                if tag.ability == dummyTag[indexPath.item].ability {
                    break;
                }
                index += 1
            }
            tagList.remove(at: index)
        } else {
            dummyTag[indexPath.item].selected = true
            tagList.append(dummyTag[indexPath.item])
        }
        
        updateTagResults()
        self.careerTable.reloadData()
        self.tagCollectionView.reloadData()
    }
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
