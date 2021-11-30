import UIKit
import Foundation

extension Button {
  
  static func applyDefaultStyle(_ button: UIButton) {
    button.setTitleColor(UIColor.black, for: .normal)
    button.layer.backgroundColor = .none
    button.layer.borderWidth = 2
    button.layer.borderColor = UIColor.lightGray.cgColor
    button.layer.cornerRadius = 10
  }
  
}
