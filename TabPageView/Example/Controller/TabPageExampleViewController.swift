//
//  TabViewExampleViewController.swift
//  TabPageView
//
//  Created by TrieuLe on 6/23/21.
//

import UIKit

class TabPageExampleViewController: TabPageController {
    
    @IBOutlet weak var textview: UITextView!
    let defaultIndex = 0
    let listMenuTitle: [String] = ["MapKit", "Zoom", "List contact qwerty"]
    let listViewController: [UIViewController] = {
        return [
            UIStoryboard(name: "SubMain1", bundle: nil).instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController,
            UIStoryboard(name: "SubMain2", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController,
            UIStoryboard(name: "SubMain3", bundle: nil).instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
        ]
    }()
//        .underline(barColor: .white, textColorNormal: .darkGray, textColorSelected: .blue, widthLine: 2.0, height: 40.0)
    let tabPageStyle = TabPageStyle(styleTabMenu: .boderRound(barColor: .blue, textColorNormal: .white, textColorSelected: .blue, bgSelected: .lightGray, height: 40), styleTabPage: .standard)
    
    
//    init?(coder: NSCoder, tabPages: String) {
//        self.tabPageModel = tabPages
//        super.init(coder: coder)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        textview.text = tabPageModel?.description
        // Do any additional setup after loading the view.
        self.delegate = self
        self.dataSource = self
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TabPageExampleViewController: TabPageControllerDelegate, TabPageControllerDataSource {
    
    func viewControllers(forTabPageController tabPageController: TabPageController) -> [UIViewController] {
        return listViewController
    }
    
    func menuTitles(forTabPageController tabPageController: TabPageController) -> [String] {
        return listMenuTitle
    }
    
    func defaultPageIndex(forTabPageController tabPageController: TabPageController) -> Int {
        return defaultIndex
    }
    
    

    
}
