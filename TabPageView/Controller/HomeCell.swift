import UIKit

class HomeCell: UICollectionViewCell {

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
        switch styleCell {
        case .boderRound:
            self.layer.cornerRadius = self.frame.height/2
            self.backgroundColor = isSelected ? .white : .blue
            self.lableCell.textColor = isSelected ? .blue : .white
        case .underLine:
            self.layer.addBorder(edge: .bottom, color: isSelected ? .blue : .white, thickness: 2)
            self.lableCell.textColor = isSelected ? .blue : .darkGray
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
