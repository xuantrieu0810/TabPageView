import UIKit

class TabMenuCell: UICollectionViewCell {

    static var cellIdentifier: String  = "TabMenuCell"
    
    var styleCell: StyleMenu?
    
    override var isSelected: Bool {
        didSet {
            setUpCell()
        }
    }
    
    @IBOutlet weak var lableCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpCell() {
        self.lableCell.textColor = styleCell?.getTextColor(isSelected: isSelected)
        switch styleCell {
        case .boderRound(_, _, _, let bgSelected,  _):
            self.layer.cornerRadius = self.frame.height/2
            self.backgroundColor = isSelected ? bgSelected : .clear
        case .underline( let bgColor, _, let lineColor, let widthLine, _):
            self.layer.addBorder(edge: .bottom, color: isSelected ? lineColor : bgColor, thickness: widthLine)
        case .none:
            break
        }
    }
    
    func customStyleCell(style: StyleMenu) {
        styleCell = style
        setUpCell()
    }
}

extension CALayer {

  func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
    let border = CALayer()
    switch edge {
    case UIRectEdge.top:
        border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
    case UIRectEdge.bottom:
        border.frame = CGRect(x:0, y: frame.height - thickness, width: frame.width, height:thickness)
    case UIRectEdge.left:
        border.frame = CGRect(x:0, y:0, width: thickness, height: frame.height)
    case UIRectEdge.right:
        border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
    default: do {}
    }

    border.backgroundColor = color.cgColor
    addSublayer(border)
 }
}
