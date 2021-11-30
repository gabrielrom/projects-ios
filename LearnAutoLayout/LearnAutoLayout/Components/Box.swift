import UIKit
import Foundation

protocol Initializable {
  init()
}

struct Box<T> {
  static func createView<T>(posX: Int, posY: Int, width sizeW: Int, height sizeH: Int) -> T where T : UIView {
    let box = T()
    
    box.frame = CGRect(
      x: posX,
      y: posY,
      width: sizeW,
      height: sizeH
    )
    
    return box
  }
  
}
