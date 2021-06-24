import UIKit

class SettingTabPageViewController: UIViewController {
    
    static let identifier = "SettingTabPage"
    var styleTabPage: StylePage?
    {
        didSet {
            if styleTabPage == .standard {
                (self.view.viewWithTag(10) as? UIButton)?.setImage(UIImage(named: "checked"), for: .normal)
                (self.view.viewWithTag(11) as? UIButton)?.setImage(UIImage(named: "unchecked"), for: .normal)
            } else {
                (self.view.viewWithTag(11) as? UIButton)?.setImage(UIImage(named: "checked"), for: .normal)
                (self.view.viewWithTag(10) as? UIButton)?.setImage(UIImage(named: "unchecked"), for: .normal)
            }
            
        }
    }
    var styleTabMenu: StyleMenu?
    {
        didSet {
            if styleTabMenu! == styleMenuBoderRound {
                (self.view.viewWithTag(20) as? UIButton)?.setImage(UIImage(named: "checked"), for: .normal)
                (self.view.viewWithTag(21) as? UIButton)?.setImage(UIImage(named: "unchecked"), for: .normal)
            } else {
                (self.view.viewWithTag(21) as? UIButton)?.setImage(UIImage(named: "checked"), for: .normal)
                (self.view.viewWithTag(20) as? UIButton)?.setImage(UIImage(named: "unchecked"), for: .normal)
            }
            
        }
    }
    let styleMenuBoderRound: StyleMenu = StyleMenu(rawValue: 1) ?? .boderRound(barColor: .blue, textColorNormal: .white, textColorSelected: .blue, bgSelected: .white, height: 40)
    let styleMenuUnderline: StyleMenu = StyleMenu(rawValue: 2) ?? .underline(barColor: .white, textColorNormal: .white, textColorSelected: .blue, widthLine: 2.0, height: 40.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Custom style TabPage"
    }
    
    @IBAction func styleScrollChanage(_ sender: UIButton) {
        styleTabPage = sender.tag == 10 ? .standard : .infinite
    }
    
    @IBAction func styleTitleChange(_ sender: UIButton) {
        styleTabMenu = sender.tag == 20 ? styleMenuBoderRound : styleMenuUnderline
    }
    
    @IBAction func pressButtonSave(_ sender: Any) {
        guard let styleTabPage = styleTabPage, let styleTabMenu = styleTabMenu else {
            return
        }
        UserDefaults.standard.set(styleTabPage.rawValue, forKey: "tabPageStyle")
        UserDefaults.standard.set(styleTabMenu.rawValue, forKey: "tabMenuStyle")
        print("scroll: \(String(describing: styleTabPage)) -- title: \(String(describing: styleTabMenu))")
        if let navigationController = self.navigationController {
            //            navigationController.popToRootViewController(animated: true)
            self.navigationController!.viewControllers.removeAll(where: { (vc) in
                vc.isKind(of: TabPageController.self) || vc.isKind(of: SettingTabPageViewController.self)
            })
            navigationController.popViewController(animated: true)
//            if let vc = UIStoryboard(name: "TabPage", bundle: nil).instantiateViewController(withIdentifier: "TabPage") as? TabPageController {
//                navigationController.pushViewController(vc, animated: true)
//            }
        }
    }
}
