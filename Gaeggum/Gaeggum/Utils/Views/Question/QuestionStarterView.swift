//
//  QuestionStarter.swift
//  Gaeggum
//
//  Created by zeroStone ⠀ on 2022/05/23.
//

import UIKit

class QuestionStarterView: UIView {
    
    @IBOutlet weak var startButton: UIButton!
    var parentViewController: UIViewController?
    
    let xibName = "QuestionStarter"
    let teamLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "TeamLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit(){
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {


        let storyboard = UIStoryboard(name: "QuestionDetail", bundle: nil)
        guard let secondViewController = storyboard.instantiateViewController(withIdentifier: "QuestionDetailViewController") as? QuestionDetailViewController else { return }
                secondViewController.modalTransitionStyle = .coverVertical
//                secondViewController.modalPresentationStyle = .fullScreen
                parentViewController?.present(secondViewController, animated: true, completion: nil)
    }
    
    
    
//    func addTeamLogoConstraints(){
//        teamLogo.widthAnchor.constraint(equalToConstant: 180).isActive = true
//        teamLogo.heightAnchor.constraint(equalToConstant: 180).isActive = true
//        teamLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        teamLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 28).isActive = true
//    }
//
//    func uploadCroppedTeamLogo(){
//        let sourceImage = UIImage(
//            named: "TeamLogo"
//        )!
//
//        // The shortest side
//        let sideLength = min(
//            sourceImage.size.width,
//            sourceImage.size.height
//        )
//
//        // Determines the x,y coordinate of a centered
//        // sideLength by sideLength square
//        let sourceSize = sourceImage.size
//        let xOffset = (sourceSize.width - sideLength) / 3
//        let yOffset = (sourceSize.height - sideLength) / 3
//
//        // The cropRect is the rect of the image to keep,
//        // in this case centered
//        let cropRect = CGRect(
//            x: xOffset,
//            y: yOffset,
//            width: sideLength,
//            height: sideLength
//        ).integral
//
//        // Center crop the image
//        let sourceCGImage = sourceImage.cgImage!
//        let croppedCGImage = sourceCGImage.cropping(
//            to: cropRect
//        )!
//
//    }
}
