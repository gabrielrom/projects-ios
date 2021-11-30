import UIKit

class ViewController: UIViewController {
  var cluesLabel: UILabel!
  var answersLabel: UILabel!
  var currentAnswer: UITextField!
  var scoreLabel: UILabel!
  var letterButtons = [UIButton]()
  
  var activatedButtons = [UIButton]()
  var solutions = [String]()
  
  var score = 0 {
    didSet {
      scoreLabel.text = "Score \(score)"
    }
  }
  var level = 1
  
  override func loadView() {
    view = UIView()
    view.backgroundColor = .white
    
    scoreLabel = UILabel()
    scoreLabel.translatesAutoresizingMaskIntoConstraints = false
    scoreLabel.textAlignment = .right
    scoreLabel.text = "Score: \(score)"
    
    cluesLabel = UILabel()
    cluesLabel.translatesAutoresizingMaskIntoConstraints = false
    cluesLabel.font = UIFont.systemFont(ofSize: 24)
    cluesLabel.text = "CLUES"
    cluesLabel.numberOfLines = 0
    cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
    
    answersLabel = UILabel()
    answersLabel.translatesAutoresizingMaskIntoConstraints = false
    answersLabel.font = UIFont.systemFont(ofSize: 24)
    answersLabel.text = "ANSWERS"
    answersLabel.numberOfLines = 0
    answersLabel.textAlignment = .right
    answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
    
    currentAnswer = UITextField()
    currentAnswer.translatesAutoresizingMaskIntoConstraints = false
    currentAnswer.placeholder = "Tap letters to guess"
    currentAnswer.textAlignment = .center
    currentAnswer.font = UIFont.systemFont(ofSize: 44)
    currentAnswer.isUserInteractionEnabled = false
    
    let submitButton = UIButton(type: .system)
    submitButton.translatesAutoresizingMaskIntoConstraints = false
    submitButton.setTitle("SUBMIT", for: .normal)
    
    let clearButton = UIButton(type: .system)
    clearButton.translatesAutoresizingMaskIntoConstraints = false
    clearButton.setTitle("CLEAR", for: .normal)
    
    let buttonsView = UIView()
    buttonsView.translatesAutoresizingMaskIntoConstraints = false
    buttonsView.layer.borderWidth = 0.5
    buttonsView.layer.borderColor = UIColor.gray.cgColor
    buttonsView.layer.cornerRadius = 5
    
    view.addSubview(scoreLabel)
    view.addSubview(cluesLabel)
    view.addSubview(answersLabel)
    view.addSubview(currentAnswer)
    view.addSubview(submitButton)
    view.addSubview(clearButton)
    view.addSubview(buttonsView)
    
    scoreLabelConstraints()
    cluesLabelConstraints()
    answersLabelConstraints()
    currentAnswerConstraints()
    submitButtonContraints(button: submitButton)
    clearButtonContraints(button: clearButton, submitButton: submitButton)
    buttonsViewContraints(buttonsView: buttonsView, submitButton: submitButton)
    createButtonOnButtonsViews(buttonsView)
    
    submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    clearButton.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
    
    letterButtons.forEach {
      $0.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
    }
    
    loadLevel()
//    cluesLabel.backgroundColor = .red
//    answersLabel.backgroundColor = .blue
//    buttonsView.backgroundColor = .green
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  private func createButtonOnButtonsViews(_ buttonsView: UIView) -> Void {
    let width = 150
    let height = 80
    
    for row in 0..<4 {
      for column in 0..<5 {
        let letterButton = UIButton(type: .system)
        letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        
        letterButton.setTitle("WWW", for: .normal)
        
        letterButton.frame = CGRect(
          x: column * width,
          y: row * height,
          width: width,
          height: height
        )
        
        buttonsView.addSubview(letterButton)
        letterButtons.append(letterButton)
      }
    }
  }
  
  private func loadLevel() {
    var clueString = ""
    var solutionString = ""
    var letterBits = [String]()
    
    guard let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") else { return }
    guard let levelContents = try? String(contentsOf: levelFileURL) else { return }
    
    let lines = levelContents.components(separatedBy: "\n").shuffled()
    
    for (index, line) in lines.enumerated() {
      let parts = line.components(separatedBy: ": ")
      let answer = parts[0]
      let clue = parts[1]
      
      clueString += "\(index + 1). \(clue)\n"
      
      let solutionWord = answer.replacingOccurrences(of: "|", with: "")
      
      solutionString += "\(solutionWord.count) letters\n"
      solutions.append(solutionWord)
      
      let bits = answer.components(separatedBy: "|")
      letterBits += bits
    }
    
    cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
    answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
    
    letterBits.shuffle()
    
    if letterBits.count == letterButtons.count {
      for i in 0..<letterButtons.count {
        letterButtons[i].setTitle(letterBits[i], for: .normal)
      }
    }
  }
  
  @objc func letterTapped(_ sender: UIButton) {
    guard let buttonTitle = sender.titleLabel?.text else { return }
    currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
    
    activatedButtons.append(sender)
    sender.isHidden = true
  }
  
  @objc func submitTapped(_ sender: UIButton) {
    guard let answerText = currentAnswer.text else { return }
    if let solutionPosition = solutions.firstIndex(of: answerText) {
      activatedButtons.removeAll()

      var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
      splitAnswers?[solutionPosition] = answerText
      answersLabel.text = splitAnswers?.joined(separator: "\n")

      currentAnswer.text = ""
      score += 1

      if score % 7 == 0 {
        let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
        present(ac, animated: true)
      }
    }
  }
  
  @objc func clearTapped(_ sender: UIButton) {
    currentAnswer.text = ""
    
    for btn in activatedButtons {
      btn.isHidden = false
    }
    
    activatedButtons.removeAll()
  }
  
  func levelUp(action: UIAlertAction) {
    level += 1
    solutions.removeAll(keepingCapacity: true)

    loadLevel()

    for btn in letterButtons {
      btn.isHidden = false
    }
  }
}

extension ViewController {
  private func scoreLabelConstraints() -> Void {
    NSLayoutConstraint.activate([
      scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
      scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
    ])
  }
  
  private func cluesLabelConstraints() -> Void {
    NSLayoutConstraint.activate([
      cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
      cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
      cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100)
    ])
  }
  
  private func answersLabelConstraints() -> Void {
    NSLayoutConstraint.activate([
      answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
      answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
      answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
      answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor)
    ])
  }
  
  private func currentAnswerConstraints() -> Void {
    NSLayoutConstraint.activate([
      currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
      currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20)
    ])
  }
  
  private func submitButtonContraints(button: UIButton) -> Void {
    NSLayoutConstraint.activate([
      button.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
      button.heightAnchor.constraint(equalToConstant: 44)
    ])
  }
  
  private func clearButtonContraints(button: UIButton, submitButton: UIButton) -> Void {
    NSLayoutConstraint.activate([
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
      button.centerYAnchor.constraint(equalTo: submitButton.centerYAnchor),
      button.heightAnchor.constraint(equalToConstant: 44)
    ])
  }
  
  private func buttonsViewContraints(buttonsView: UIView, submitButton: UIButton) -> Void {
    NSLayoutConstraint.activate([
      buttonsView.widthAnchor.constraint(equalToConstant: 750),
      buttonsView.heightAnchor.constraint(equalToConstant: 320),
      buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      buttonsView.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 20),
      buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
    ])
  }
  
}

