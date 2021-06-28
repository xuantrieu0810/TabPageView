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
## Requirements

- iOS 13.0+
- Swift 5+

## How to use

### Example

Here is an example of how to TabPageController.
- You need to ```import TabPage``` and provide the following attributes:
  + listMenuTitle:  the list of titles on the Tabpage's menu bar
  + listViewController:  child viewcontrollers located in the Tabpage corresponding to the titles on the menu bar
  > Note: --The number of items of these 2 components must be equal and correspond to each other in terms of position in the array
- Style of TabPage include style of tabMenu and style of pageView::
  + pageViewStyle: StylePage => scrolling of pages(viewcontrollers)
  + tabMenuStyle: StyleMenu => title bar style on menu
- In viewDidLoad() you need create a instance of TabPageController through UIStoryboard : 
```swift
UIStoryboard(name: TabPageController.nameStoryboard, bundle: nil).instantiateViewController(identifier: TabPageController.identifier, creator: {
            coder -> TabPageController? in
            TabPageController(coder: coder, menuTitles: self.listMenuTitle, viewControllers: self.listViewController, tabPageStyle: self.tabPageStyle)
        })
```
[TabPageView/Example/Controller/ExampleViewController.swift](https://github.com/xuantrieu0810/TabPageView/blob/main/TabPageView/Example/Controller/ExampleViewController.swift)

```swift
import UIKit
import TabPage

class ExampleViewController: UIViewController {
    
    var tabPageController: TabPageController?
    /// Get style TabPage from UserDefault
    let tabPageStyle = TabPageStyle.getStyleFromUserDefault()
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
        /// Add a navigationItem to navigate to SettingTabPage
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

```
### Setting TabPage
To be able to go to the TabPage settings view controller you need ```import TabPage``` and provided a navigationController
Call: ```TabPageController.goToSetting(navigationController: self.navigationController)``` a static function to navigate to SettingTabPage view controller

### Customization
#### StylePage
  - standard: page scroll with stops
  - infinite: endless page scroll
#### StyleMenu 
  - underLine:
     + case normal: white background color + black text color 
     + case selected: blue text color + blue underline color
  - boderRound:
     + case normal: blue background color + white text color 
     + case selected: blue text color + rounded rectangle around text on white background


## License

MIT license. See the LICENSE file for more info.
