import Foundation
import UIKit

struct TabPageStyle {
    var styleTabMenu: StyleMenu
    var styleTabPage: StylePage
}

public enum StylePage: Int {
    case standard = 1
    case infinite = 2
    static let allValues = [standard, infinite]
    
    public init?(rawValue: Int) {
        switch rawValue {
        case 1: self = .standard
        case 2: self = .infinite
        default: return nil
        }
    }
}

public enum StyleMenu {
    
    case underline(barColor: UIColor, textColorNormal: UIColor, textColorSelected: UIColor, widthLine: CGFloat, height: CGFloat)
    case boderRound(barColor: UIColor, textColorNormal: UIColor, textColorSelected: UIColor, bgSelected: UIColor = .white, height: CGFloat)
    static let allValues = [underline , boderRound] as [Any]
}

extension StyleMenu {
    
    var height: CGFloat {
        switch self {
        case let .underline(_, _, _, _, height):
            return height
        case let .boderRound(_ , _, _, _, height):
            return height
        }
    }
    
    var barColor: UIColor {
        switch self {
        case let .underline(barColor, _, _, _, _):
            return barColor
        case let .boderRound(barColor , _, _, _, _):
            return barColor
        }
    }
    
    func getTextColor(isSelected: Bool) -> UIColor {
        switch self {
        case let .underline(_, textColorNormal, textColorSelected, _, _):
            return isSelected ? textColorSelected : textColorNormal
        case let .boderRound(_, textColorNormal, textColorSelected, _, _):
            return isSelected ? textColorSelected : textColorNormal
        }
    }
}

extension StyleMenu: RawRepresentable {
    
    public var rawValue: Int {
        switch self {
        case .boderRound(_,_,_,_,_): return 1
        case .underline(_,_,_,_,_): return 2
        }
    }
    
    public init?(rawValue: Int) {
        let styleMenuBoderRound: StyleMenu = .boderRound(barColor: .blue, textColorNormal: .white, textColorSelected: .blue, bgSelected: .white, height: 40)
        let styleMenuUnderline: StyleMenu = .underline(barColor: .white, textColorNormal: .darkGray, textColorSelected: .blue, widthLine: 2.0, height: 40.0)
        switch rawValue {
        case 1: self = styleMenuBoderRound
        case 2: self = styleMenuUnderline
        default: return nil
        }
    }
}
