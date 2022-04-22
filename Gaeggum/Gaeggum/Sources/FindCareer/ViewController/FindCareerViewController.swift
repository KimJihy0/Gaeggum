//
//  FindCareerViewController.swift
//  Gaeggum
//
//  Created by zeroStone ⠀ on 2022/04/22.
//

import UIKit

class FindCareerViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct Career { //  test
        let id : Int
        let name : String
    }
    
    let data = [Career(id : 1, name : "프론트엔드 개발자"),
                Career(id : 2, name : "백엔드 개발자"),
                Career(id : 3, name : "AI 엔지니어"),
                Career(id : 4, name : "딥러닝 분석가"),
                ]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CareerCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = "cell"
        cell.textLabel?.text = data[indexPath.row].name

        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
