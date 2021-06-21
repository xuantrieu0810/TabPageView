//
//  SettingTabPageViewController.swift
//  TabPageView
//
//  Created by TrieuLe on 6/18/21.
//

import UIKit

class SettingTabPageViewController: UIViewController {
    
    static let identifier = "SettingTabPage"
    var styleScroll: StyleScroll = .standard {
        didSet {
            if styleScroll == .standard {
                (self.view.viewWithTag(10) as? UIButton)?.setImage(UIImage(named: "checked"), for: .normal)
                (self.view.viewWithTag(11) as? UIButton)?.setImage(UIImage(named: "unchecked"), for: .normal)
            } else {
                (self.view.viewWithTag(11) as? UIButton)?.setImage(UIImage(named: "checked"), for: .normal)
                (self.view.viewWithTag(10) as? UIButton)?.setImage(UIImage(named: "unchecked"), for: .normal)
            }
            
        }
    }
    var styleMenuTitle: StyleMenu = .boderRound {
        didSet {
            if styleMenuTitle == .boderRound {
                (self.view.viewWithTag(20) as? UIButton)?.setImage(UIImage(named: "checked"), for: .normal)
                (self.view.viewWithTag(21) as? UIButton)?.setImage(UIImage(named: "unchecked"), for: .normal)
            } else {
                (self.view.viewWithTag(21) as? UIButton)?.setImage(UIImage(named: "checked"), for: .normal)
                (self.view.viewWithTag(20) as? UIButton)?.setImage(UIImage(named: "unchecked"), for: .normal)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Custom style TabPage"
    }
    
    @IBAction func styleScrollChanage(_ sender: UIButton) {
        styleScroll = sender.tag == 10 ? .standard : .infinite
    }
    
    @IBAction func styleTitleChange(_ sender: UIButton) {
        styleMenuTitle = sender.tag == 20 ? .boderRound : .underLine
    }
    
    @IBAction func pressButtonSave(_ sender: Any) {
        print("scroll: \(styleScroll) -- title: \(styleMenuTitle)")
        if let navigationController = self.navigationController {
            self.navigationController!.viewControllers.removeAll(where: { (vc) in
                vc.isKind(of: RootTabPageViewController.self) || vc.isKind(of: SettingTabPageViewController.self)
            })

            if let vc = UIStoryboard(name: "TabPage", bundle: nil).instantiateViewController(withIdentifier: RootTabPageViewController.identifier) as? RootTabPageViewController {
                vc.styleMenuTitle = styleMenuTitle
                vc.styleScrollPage = styleScroll
                navigationController.pushViewController(vc, animated: true)
            }
        }

    }
}
