import UIKit
import Foundation

struct Button {
  static func create(posX: Int = 0, posY: Int = 0, width sizeW: Int, height sizeH: Int, useDefaultStyle: Bool = false) -> UIButton {
    let button = UIButton()
    
    button.frame = CGRect(
      x: posX,
      y: posY,
      width: sizeW,
      height: sizeH
    )
    
    if useDefaultStyle {
      applyDefaultStyle(button)
    }
    
    return button
  }
}
