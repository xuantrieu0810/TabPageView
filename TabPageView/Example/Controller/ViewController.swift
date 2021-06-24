//
//  ViewController.swift
//  TabPageView
//
//  Created by TrieuLe on 6/18/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var buttonGo: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TabPage"
        buttonGo.layer.cornerRadius = buttonGo.frame.height/2
        indicator.color = .red
        indicator.isHidden = true
    }
    
    @IBAction func pressButtonSave(_ sender: Any) {
        indicator.isHidden = false
        indicator.startAnimating()
        let listMenuTitle: [String] = ["MapKit", "Zoom", "List contact qwerty"]
        let listViewController: [UIViewController] = {
            return [
                UIStoryboard(name: "SubMain1", bundle: nil).instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController,
                UIStoryboard(name: "SubMain2", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController,
                UIStoryboard(name: "SubMain3", bundle: nil).instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
            ]
        }()

 
        var tabPageStyle = TabPageStyle(styleTabMenu: .boderRound(barColor: .blue, textColorNormal: .white, textColorSelected: .blue, bgSelected: .white, height: 40), styleTabPage: .standard)
        if let styleTabPage = StylePage(rawValue: UserDefaults.standard.integer(forKey: "tabPageStyle")), let styleTabMenu = StyleMenu(rawValue: UserDefaults.standard.integer(forKey: "tabMenuStyle"))  {
            tabPageStyle = TabPageStyle(styleTabMenu: styleTabMenu, styleTabPage: styleTabPage)
        }
        
        
        
        let vc = UIStoryboard(name: "TabPage", bundle: .main).instantiateViewController(identifier: "TabPage", creator: { coder -> TabPageController? in
            TabPageController(coder: coder, menuTitles: listMenuTitle, viewControllers: listViewController, tabPageStyle: tabPageStyle)
        })
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabPageExample") as! TabPageExampleViewController
        if  let navi = navigationController{
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
                navi.pushViewController(vc, animated: true)
            
            
        }
    }
}

