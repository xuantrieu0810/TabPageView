import UIKit

class SettingTabPageViewController: UIViewController {
    
    static let identifier = "SettingTabPage"
    
    private var styleTabPage: Int! = -1
    {
        didSet {
            if styleTabPage == 1 {
                (self.view.viewWithTag(10) as? UIButton)?.setImage(UIImage.getImageCheckBox(isSelected: true), for: .normal)
                (self.view.viewWithTag(11) as? UIButton)?.setImage(UIImage.getImageCheckBox(isSelected: false), for: .normal)
            } else {
                (self.view.viewWithTag(11) as? UIButton)?.setImage(UIImage.getImageCheckBox(isSelected: true), for: .normal)
                (self.view.viewWithTag(10) as? UIButton)?.setImage(UIImage.getImageCheckBox(isSelected: false), for: .normal)
            }
        }
    }
    
    private var styleTabMenu: Int! = -1
    {
        didSet {
            if styleTabMenu == 1 {
                (self.view.viewWithTag(20) as? UIButton)?.setImage(UIImage.getImageCheckBox(isSelected: true), for: .normal)
                (self.view.viewWithTag(21) as? UIButton)?.setImage(UIImage.getImageCheckBox(isSelected: false), for: .normal)
            } else {
                (self.view.viewWithTag(21) as? UIButton)?.setImage(UIImage.getImageCheckBox(isSelected: true), for: .normal)
                (self.view.viewWithTag(20) as? UIButton)?.setImage(UIImage.getImageCheckBox(isSelected: false), for: .normal)
            }
            
        }
    }
    
    override func viewDidLoad() {
        styleTabPage = TabPageStyle.getStyleFromUserDefault().styleTabPage.rawValue
        styleTabMenu = TabPageStyle.getStyleFromUserDefault().styleTabMenu.rawValue
        guard styleTabPage != -1 || styleTabMenu != -1 else {
            navigationController?.popViewController(animated: true)
            return
        }
        super.viewDidLoad()
        title = "Custom style TabPage"
    }
    
    @IBAction func styleScrollChanage(_ sender: UIButton) {
        styleTabPage = sender.tag == 10 ? 1 : 2
    }
    
    @IBAction func styleTitleChange(_ sender: UIButton) {
        styleTabMenu = sender.tag == 20 ? 1 : 2
    }
    
    @IBAction func pressButtonSave(_ sender: Any) {
        guard let styleTabPage = styleTabPage, let styleTabMenu = styleTabMenu else {
            return
        }
        UserDefaults.standard.set(styleTabPage, forKey: "tabPageStyle")
        UserDefaults.standard.set(styleTabMenu, forKey: "tabMenuStyle")
        print("scroll: \(String(describing: styleTabPage)) -- title: \(String(describing: styleTabMenu))")
        if let navigationController = self.navigationController {
            //            navigationController.popToRootViewController(animated: true)
            self.navigationController!.viewControllers.removeAll(where: { (vc) in
                vc.isKind(of: TabPageController.self) || vc.isKind(of: SettingTabPageViewController.self)
            })
            navigationController.popViewController(animated: true)
        }
    }
}
