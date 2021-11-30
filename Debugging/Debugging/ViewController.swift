//
//  ViewController.swift
//  Debugging
//
//  Created by GABRIEL MATHEUS RODRIGUES DE SOUZA on 29/11/21.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
//    print("Im inside the viewDidLoad() method!")
//    print(1,2,4,5,6, separator: "-", terminator: "")
//
//    assert(1 == 1, "Maths failure!")
//    assert(1 == 2, "Maths failure!")
    
    for i in 1 ... 100 {
      print("Got number \(i)")
      
      if i == 10 {
        fatalError()
      }
    }
  }

  
}

