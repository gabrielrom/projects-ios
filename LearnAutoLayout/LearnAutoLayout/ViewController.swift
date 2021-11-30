//
//  ViewController.swift
//  LearnAutoLayout
//
//  Created by GABRIEL MATHEUS RODRIGUES DE SOUZA on 22/11/21.
//

import UIKit

class ViewController: UIViewController {
  var box = Box<UIView>.createView(posX: 100, posY: 170, width: 200, height: 200)
  var box2 = Box<UIView>.createView(posX: 100, posY: 400, width: 200, height: 200)
  var buttonHidden: UIButton = Button.create(posX: 136, posY: 620, width: 120, height: 50, useDefaultStyle: true)
  var buttonShown: UIButton = Button.create(posX: 136, posY: 680, width: 120, height: 50, useDefaultStyle: true)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    box.frame = CGRect(
//      x: 100,
//      y: 170,
//      width: 200,
//      height: 200
//    )
//
//    box2.frame = CGRect(
//      x: 100,
//      y: 400,
//      width: 200,
//      height: 200
//    )
//
//    buttonHidden.frame = CGRect(
//      x: 136,
//      y: 620,
//      width: 120,
//      height: 50
//    )
//
//    buttonShown.frame = CGRect(
//      x: 136,
//      y: 680,
//      width: 120,
//      height: 50
//    )
    
    buttonHidden.setTitle("Esconder", for: .normal)
//    buttonHidden.setTitleColor(UIColor.black, for: .normal)
//    buttonHidden.layer.backgroundColor = .none
//    buttonHidden.layer.borderWidth = 2
//    buttonHidden.layer.borderColor = UIColor.lightGray.cgColor
//    buttonHidden.layer.cornerRadius = 10
    
    buttonShown.setTitle("Mostrar", for: .normal)
//    buttonShown.setTitleColor(UIColor.black, for: .normal)
//    buttonShown.layer.backgroundColor = .none
//    buttonShown.layer.borderWidth = 2
//    buttonShown.layer.borderColor = UIColor.lightGray.cgColor
//    buttonShown.layer.cornerRadius = 10
    
    box.layer.backgroundColor = UIColor.red.cgColor
    box.layer.cornerRadius = 10
    
    box2.layer.backgroundColor = UIColor.blue.cgColor
    box2.layer.cornerRadius = 10
    
    view.addSubview(box)
    view.addSubview(box2)
    view.addSubview(buttonHidden)
    view.addSubview(buttonShown)
    
    buttonHidden.addTarget(self, action: #selector(hiddenBox), for: .touchUpInside)
    buttonShown.addTarget(self, action: #selector(showBox), for: .touchUpInside)
  }
  
  @objc func hiddenBox() {
    box.isHidden = true
  }
  
  @objc func showBox() {
    box.isHidden = false
  }
}
