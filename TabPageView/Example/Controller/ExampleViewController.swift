import UIKit

class ExampleViewController: UIViewController {
    
    var tabPageController: TabPageController?
    // Get style TabPage from UserDefault
    let tabPageStyle = TabPageStyle.getStyleFromUserDefault()
    let styleTabPage: StylePage = .standard
    let listMenuTitle: [String] = ["MapKit", "Zoom", "List contact qwerty"]
    let listViewController: [UIViewController] = {
        return [
            UIStoryboard(name: "SubMain1", bundle: nil).instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController,
            UIStoryboard(name: "SubMain2", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController,
            UIStoryboard(name: "SubMain3", bundle: nil).instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TabPage"
        tabPageController = UIStoryboard(name: TabPageController.nameStoryboard, bundle: nil).instantiateViewController(identifier: TabPageController.identifier, creator: {
            coder -> TabPageController? in
            TabPageController(coder: coder, menuTitles: self.listMenuTitle, viewControllers: self.listViewController, tabPageStyle: self.tabPageStyle)
        })
        
        let editItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(goToSetting))
        navigationItem.setRightBarButton(editItem, animated: true)
        addChild(tabPageController!)
        view.addSubview(tabPageController!.view)
        view.constrainToEdges(tabPageController!.view)
        tabPageController!.didMove(toParent: self)
    }
    
    @objc func goToSetting() {
        TabPageController.goToSetting(navigationController: self.navigationController)
    }
}
