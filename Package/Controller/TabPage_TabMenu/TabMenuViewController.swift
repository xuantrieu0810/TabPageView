import UIKit

class TabMenuViewController: UIViewController {
    
    weak var tabMenuDelegate: TabMenuDelegate?
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.backgroundColor = styleMenuTitle?.barColor
        }
    }
    
    var styleMenuTitle: StyleMenu?

    /// tab menu titles
    var menuItemsCount = 0
    var menuItems: [String] = [] {
        didSet {
            self.menuItemsCount = self.menuItems.count
            collectionView.reloadData()
        }
    }
    weak var tabMenuDataSource: TabMenuDataSource?
    
    internal func scrollToItem(index: Int) {
        collectionView.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
    
    internal func loadData() {
        menuItems = tabMenuDataSource?.tabMenuViewController( self, numberOfItemsInTabMenu: 0) ?? []
        tabMenuDelegate?.tabMenuViewController(tabMenuViewController: self, didUpdatePageCount: menuItemsCount)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = false
        loadData()
    }
    /**
     - Set backgroud UICollectionView follow style of styleMenuTitle
     - Scroll to menu item default when appear
     */
    override func viewWillAppear(_ animated: Bool) {
    }
    
    
}
//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
/**
 Navigation menu title use UICollection view to display
 */
extension TabMenuViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    /// The total number of menu title.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItemsCount
    }
    /// Initial + set data cell

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabMenuCell.cellIdentifier, for: indexPath) as! TabMenuCell
        self.configureCell(cell, indexPath: indexPath)
        return cell
    }

    func configureCell(_ cell: TabMenuCell, indexPath: IndexPath) {
        cell.lableCell.text = menuItems[indexPath.row]
        cell.customStyleCell(style: styleMenuTitle!)
    }
    /// Handle event click into a cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tabMenuDelegate?.tabMenuViewController(tabMenuViewController: self, didUpdatePageIndex: indexPath.row)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    /// Format size of cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 40)
    }
}





    // MARK: UICollectionViewDelegate

//    // Uncomment this method to specify if the specified item should be highlighted during tracking
//    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    // Uncomment this method to specify if the specified item should be selected
//    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
//    func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
//        return false
//    }
//
//    func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
//        return false
//    }
//
//    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
//
//    }
