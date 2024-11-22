//
//  TabbarViewController.swift
//  MovieApp-Programmatic
//
//  Created by Samet Korkmaz on 19.11.2024.
//

import UIKit
import Foundation

class TabbarViewController: UITabBarController {
    
    let btnMiddle : UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        btn.setTitle("", for: .normal)
        btn.backgroundColor = UIColor(named: "tigaPickColor")
        btn.layer.cornerRadius = 30
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.loodos.cgColor
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowOffset = CGSize(width: 4, height: 4)
        // UIImageView ekleyip, scaleAspectFill yapıyoruz
        btn.setImage(UIImage(named: "loodosLogo"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill // Görselin dolmasını sağlıyoruz
        btn.clipsToBounds = true // Görselin dışarı taşmaması için
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnMiddle.addTarget(self, action: #selector(tigaButtonTapped), for: .touchUpInside)
        addSomeTabItems()
        btnMiddle.frame = CGRect(x: Int(self.tabBar.bounds.width)/2 - 35, y: -34, width: 70, height: 70)
    }
    override func loadView() {
        super.loadView()
        self.tabBar.addSubview(btnMiddle)
        setupCustomTabbar()
    }
    
    @objc func tigaButtonTapped() {
        let web_VC = WebViewController()
        web_VC.modalPresentationStyle = .fullScreen
        present(web_VC, animated: true, completion: nil) 
    }
    
    func setupCustomTabbar(){
        tabBar.unselectedItemTintColor = .gray
        // Arka planı tamamen şeffaf yap
        tabBar.backgroundImage = UIImage() // Arka plan resmi olmadan şeffaflık
        tabBar.backgroundColor = UIColor.lightGray.withAlphaComponent(0.0)
        let path : UIBezierPath = getPathForTabBar()
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 5
        shape.strokeColor = UIColor.loodos.cgColor
        shape.fillColor = UIColor.loodos.cgColor
        self.tabBar.layer.insertSublayer(shape, at: 0)
        self.tabBar.itemWidth = 40
        self.tabBar.itemPositioning = .centered
        self.tabBar.itemSpacing = 180
        self.tabBar.tintColor = UIColor(.white)
    }
    
    func addSomeTabItems() {
        let vc1 = UINavigationController(rootViewController: SearchViewController())
        let vc2 = UINavigationController(rootViewController: BookmarkViewController())
        
        vc1.title = "Search"
        vc2.title = "Bookmark"
        setViewControllers([vc1, vc2], animated: true)
        guard let items = tabBar.items else { return}
        items[0].image = UIImage(systemName: "magnifyingglass")
        items[1].image = UIImage(systemName: "bookmark.fill")
    }
    
    func getPathForTabBar() -> UIBezierPath {
        let frameWidth = self.tabBar.bounds.width
        let frameHeight = self.tabBar.bounds.height + 100
        let holeWidth = 150
        let holeHeight = 50
        let leftXUntilHole = Int(frameWidth/2) - Int(holeWidth/2)
        
        let path : UIBezierPath = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: leftXUntilHole , y: 0))
        path.addCurve(to: CGPoint(x: leftXUntilHole + (holeWidth/3), y: holeHeight/2), controlPoint1: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*6,y: 0), controlPoint2: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*8, y: holeHeight/2))
        
        path.addCurve(to: CGPoint(x: leftXUntilHole + (2*holeWidth)/3, y: holeHeight/2), controlPoint1: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2/5, y: (holeHeight/2)*6/4), controlPoint2: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2 + (holeWidth/3)/3*3/5, y: (holeHeight/2)*6/4))
        
        path.addCurve(to: CGPoint(x: leftXUntilHole + holeWidth, y: 0), controlPoint1: CGPoint(x: leftXUntilHole + (2*holeWidth)/3,y: holeHeight/2), controlPoint2: CGPoint(x: leftXUntilHole + (2*holeWidth)/3 + (holeWidth/3)*2/8, y: 0)) // part III
        path.addLine(to: CGPoint(x: frameWidth, y: 0))
        path.addLine(to: CGPoint(x: frameWidth, y: frameHeight))
        path.addLine(to: CGPoint(x: 0, y: frameHeight))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.close()
        return path
    }
}
