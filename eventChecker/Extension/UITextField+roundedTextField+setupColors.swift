import UIKit

extension UITextField {
    internal func roundedTextField() {
        layer.cornerRadius = 16
        clipsToBounds = true
    }
    
    internal func colorsTextField() {
        backgroundColor = AppColor.fieldsColor
    }
}
