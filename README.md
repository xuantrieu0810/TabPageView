TabPageView
===================================


## Demo
<div>
  <img src="https://github.com/xuantrieu0810/TabPageView/blob/main/screen-shot/tabpage-border-menu.png" alt="..." width="250" />
  <img src="https://github.com/xuantrieu0810/TabPageView/blob/main/screen-shot/tabpage-underline-menu.png" alt="..." width="250" />
  <img src="https://github.com/xuantrieu0810/TabPageView/blob/main/screen-shot/setting-tabpage.png" alt="..." width="250" />
</div>



Customizable PageView ViewController and ColletionView in Swift

Features


- Custom style menu titles
  + BorderRound / Underline
- Custom style scroll view page
  + Standard / Infinite
#
## How to use

### Example

Here is an example of how to SwiftPageMenu.

[TabPageView/Controller/RootTabPageViewController.swift](https://github.com/xuantrieu0810/TabPageView/blob/main/TabPageView/Controller/RootTabPageViewController.swift)

```swift
import UIKit



class RootTabPageViewController: UIViewController {
    
    static let identifier = "RootTabPage"
    
    private var currentIndexCell = 0
    /**
     
     */
    var styleScrollPage: StyleScroll = .standard
    var styleMenuTitle: StyleMenu = .boderRound
    
    /**
     the menuTitles + pageViewControllers properties are the two main components of the Tabpage
          - menuTitles:  the list of titles on the Tabpage's menu bar
          - pageViewControllers:  child viewcontrollers located in the Tabpage corresponding to the titles on the menu bar
       **The number of items of these 2 components must be equal and correspond to each other in terms of position in the array
     */
    lazy var menuTitles: [String] = ["MapKit", "Zoom", "List contact"]
    lazy var pageViewControllers: [UIViewController] = {
        return [
            UIStoryboard(name: "SubMain1", bundle: nil).instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController,
            UIStoryboard(name: "SubMain2", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController,
            UIStoryboard(name: "SubMain3", bundle: nil).instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
        ]
    }()
    
    @IBOutlet weak var collectionViewMenu: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    
    var tabPageViewController: TabPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewMenu.delegate = self
        collectionViewMenu.dataSource = self
        collectionViewMenu.allowsMultipleSelection = false
        registerCell()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editMenuAction))
    }
    /**
     - Set backgroud UICollectionView follow style of styleMenuTitle
     - Scroll to menu item default when appear
     */
    override func viewWillAppear(_ animated: Bool) {
        collectionViewMenu.backgroundColor = styleMenuTitle == .boderRound ? .blue : .white
        guard currentIndexCell < menuTitles.count else { return }
        collectionViewMenu.selectItem(at: IndexPath(item: currentIndexCell, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
    /**
     - Get TabPage VỉewController & set properties:
        + tabPageDelegate
        + pageViewControllers
        + styleScrollPage
        + currentIndexPage
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueTabPage" {
            if let descVC = segue.destination as? TabPageViewController {
                self.tabPageViewController = descVC
                self.tabPageViewController!.tabPageDelegate = self
                self.tabPageViewController!.pageViewControllers = pageViewControllers
                self.tabPageViewController!.styleScrollPage = styleScrollPage
                self.tabPageViewController!.currentIndexPage = currentIndexCell
            }
        }
    }
    
    private func registerCell() {
        let nib = UINib(nibName: "HomeCell", bundle: .main)
        collectionViewMenu.register(nib, forCellWithReuseIdentifier: "HomeCell")
    }
    
    /// func editMenuAction: go to a VỉewController to edit styleScroll and styleMenuTitle
    @objc func editMenuAction() {
        let vc = UIStoryboard(name: "TabPage", bundle: nil).instantiateViewController(withIdentifier: SettingTabPageViewController.identifier) as? SettingTabPageViewController
        if let vc = vc , let navi = navigationController{
            vc.styleScroll = styleScrollPage
            vc.styleMenuTitle = styleMenuTitle
            navi.pushViewController(vc, animated: true)
        }
    }
}
.
.
.
.
//MARK: - TabPageDelegate
extension RootTabPageViewController: TabPageDelegate {
    /**
     Called when the number of pages is updated.
     - parameter tabPageViewController: the tabPageViewController instance
     - parameter count: the total number of pages.
     */
    func tabPageViewController(tabPageViewController: TabPageViewController,
        didUpdatePageCount count: Int) {
    }
    
    /**
     Called when the current index is updated.
     - parameter tabPageViewController: the TabPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func tabPageViewController(tabPageViewController: TabPageViewController,
        didUpdatePageIndex index: Int) {
        // prevent repeat operation when change collectionview
        guard index != currentIndexCell else { return }
        collectionViewMenu.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        currentIndexCell = index
    }
    
}
```



### Delegate

SwiftPageMenu give you the events below code.

```swift
protocol TabPageDelegate: class {
    
    /**
     Called when the number of pages is updated.
     - parameter tabPageViewController: the tabPageViewController instance
     - parameter count: the total number of pages.
     */
    func tabPageViewController(tabPageViewController: TabPageViewController,
        didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter tabPageViewController: the TabPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func tabPageViewController(tabPageViewController: TabPageViewController,
        didUpdatePageIndex index: Int)
    
}
```

### Customization

```swift
public enum StyleScroll {
    case standard
    case infinite
}

public enum StyleMenu {
    case underLine
    case boderRound
}
```

## License

MIT license. See the LICENSE file for more info.
