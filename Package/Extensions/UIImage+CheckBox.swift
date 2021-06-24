import UIKit

extension UIImage {
    
    static func getImageCheckBox(isSelected: Bool) -> UIImage? {
        let checked = UIImage(systemName: "checkmark.circle.fill")
        let uncheck = UIImage(systemName: "checkmark.circle")
        return isSelected ?  checked : uncheck
    }
}
