//
//  ViewController.swift
//  GuessFlag
//
//  Created by GABRIEL MATHEUS RODRIGUES DE SOUZA on 21/11/21.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet var button1: UIButton!
  @IBOutlet var button2: UIButton!
  @IBOutlet var button3: UIButton!
  
  var countries = [String]()
  var correctAnswer = 0
  var score = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    countries.append("estonia")
    countries.append("france")
    countries.append("germany")
    countries.append("ireland")
    countries.append("italy")
    countries.append("monaco")
    countries.append("nigeria")
    countries.append("poland")
    countries.append("russia")
    countries.append("spain")
    countries.append("uk")
    countries.append("us")
    
    // Layer -> CALayer. o layer serve para fazer modificacoes na visualizacao da layer.
    button1.layer.borderWidth = 1
    button2.layer.borderWidth = 1
    button3.layer.borderWidth = 1
    
    button1.layer.cornerRadius = 5
    button2.layer.cornerRadius = 5
    button3.layer.cornerRadius = 5
    
    button1.layer.borderColor = UIColor.lightGray.cgColor
    button2.layer.borderColor = UIColor.lightGray.cgColor
    button3.layer.borderColor = UIColor.lightGray.cgColor
    
    askQuestion()
  }

  func askQuestion(action: UIAlertAction! = nil) {
    countries.shuffle()
    
    button1.setImage(UIImage(named: countries[0]), for: .normal)
    button2.setImage(UIImage(named: countries[1]), for: .normal)
    button3.setImage(UIImage(named: countries[2]), for: .normal)
    
    correctAnswer = Int.random(in: 0...2)
    title = countries[correctAnswer].uppercased()
  }
  
  @IBAction func buttonTapped(_ sender: UIButton) {
    var title: String
    
    if sender.tag == correctAnswer {
      title = "Correct"
      score += 1
    }
    
    else if score == 0 {
      title = "Wrong"
      score = 0
    }
    
    else {
      title = "Wrong"
      score -= 1
    }
    
    let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
    present(ac, animated: true)
  }
  
}

