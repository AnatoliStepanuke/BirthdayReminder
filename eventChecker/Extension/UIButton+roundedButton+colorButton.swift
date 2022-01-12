import UIKit

extension UIButton {
    internal func roundedButton() {
        layer.cornerRadius = 16
    }
    
    internal func backgroundColorButton() {
        backgroundColor = AppColor.buttonColor
    }
}
