//
//  ViewController.swift
//  Gaeggum
//
//  Created by zeroStone ⠀ on 2022/04/21.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var findCareerView: UIView!
    @IBOutlet weak var myStackView: UIView!
    
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var homeTabBarItem: UITabBarItem!
    
    private var homeViewController: HomeViewController?
    private var findCareerViewController : FindCareerViewController?
    private var myStackViewController : MyStackViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.delegate = self
        setUpTabBarUI()
        setRootViewController(rootViewController: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case MainTab.home.segueIdentifier:
            let navigationController = segue.destination as? UINavigationController
            homeViewController = navigationController?.topViewController as? HomeViewController
        case MainTab.findCareer.segueIdentifier:
            findCareerViewController = segue.destination as? FindCareerViewController
        case MainTab.myStack.segueIdentifier:
            let navigationController = segue.destination as? UINavigationController
            myStackViewController = navigationController?.topViewController as? MyStackViewController
        default:
            break
        }
    }
    
    private func setUpTabBarUI() {
        tabBar.selectedItem = homeTabBarItem
        
        shadowView.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: -1)
        
        tabBar.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        tabBar.translatesAutoresizingMaskIntoConstraints = false
       
        view.bringSubviewToFront(homeView)
        view.bringSubviewToFront(shadowView)
    }
    
    func setTabBarHidden(_ isHidden: Bool) {
        tabBar.isHidden = isHidden
        shadowView.isHidden = isHidden
        tabBar.isTranslucent = isHidden
    }
}

// MARK: UITabBarDelegate
extension MainViewController: UITabBarDelegate {

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case MainTab.home.index:
            view.bringSubviewToFront(homeView)
        case MainTab.findCareer.index:
            view.bringSubviewToFront(findCareerView)
        case MainTab.myStack.index:
            view.bringSubviewToFront(myStackView)
        default:
            break
        }

        view.bringSubviewToFront(shadowView)
    }
}

