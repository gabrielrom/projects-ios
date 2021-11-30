import UIKit

class ViewController: UIViewController {
  let viewVermelho = UIView()
  let viewAzul = UIView()
  let viewYellow = UIView()
  let viewRosa = UIView()
  let viewBox = UIView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let textLabel = UILabel()
    let textLabelViewBlue = UILabel()
    let textLabelViewRed = UILabel()
    let textLabelViewYellow = UILabel()
    let textLabelViewPink = UILabel()
    let textLabelViewBox = UILabel()
  
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    textLabelViewBlue.translatesAutoresizingMaskIntoConstraints = false
    textLabelViewRed.translatesAutoresizingMaskIntoConstraints = false
    textLabelViewYellow.translatesAutoresizingMaskIntoConstraints = false
    textLabelViewPink.translatesAutoresizingMaskIntoConstraints = false
    textLabelViewBox.translatesAutoresizingMaskIntoConstraints = false
    
    viewVermelho.translatesAutoresizingMaskIntoConstraints = false
    viewAzul.translatesAutoresizingMaskIntoConstraints = false
    viewYellow.translatesAutoresizingMaskIntoConstraints = false
    viewRosa.translatesAutoresizingMaskIntoConstraints = false
    viewBox.translatesAutoresizingMaskIntoConstraints = false
    
    textLabel.text = "Skills \nTo Pump!"
    textLabel.numberOfLines = 0
    textLabel.textColor = .white
//    textLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
    textLabel.attributedText = NSAttributedString(
      string: textLabel.text!,
      attributes: [.font: UIFont.systemFont(ofSize: 36, weight: .bold)]
    )
    
    textLabelViewBlue.text = "Technique"
    textLabelViewBlue.textColor = .white
    textLabelViewBlue.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    
    textLabelViewRed.text = "Arsenal"
    textLabelViewRed.textColor = .white
    textLabelViewRed.font = UIFont.systemFont(ofSize: 18, weight: .bold)

    textLabelViewYellow.text = "Coordination"
    textLabelViewYellow.textColor = .white
    textLabelViewYellow.font = UIFont.systemFont(ofSize: 18, weight: .bold)

    textLabelViewPink.text = "Songs"
    textLabelViewPink.textColor = .white
    textLabelViewPink.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    
    textLabelViewBox.text = "Some Text"
    textLabelViewBox.textColor = .white
    textLabelViewBox.font = UIFont.systemFont(ofSize: 18, weight: .bold)

    viewAzul.layer.cornerRadius = 20
    viewVermelho.layer.cornerRadius = viewAzul.layer.cornerRadius
    viewYellow.layer.cornerRadius = viewAzul.layer.cornerRadius
    viewRosa.layer.cornerRadius = viewAzul.layer.cornerRadius
    viewBox.layer.cornerRadius = viewAzul.layer.cornerRadius
    
    view.backgroundColor = .black
    
    viewAzul.backgroundColor = .blue
    viewVermelho.backgroundColor = .red
    viewYellow.backgroundColor = UIColor(red: CGFloat(7)/CGFloat(255), green: CGFloat(96)/CGFloat(255), blue: CGFloat(244)/CGFloat(255), alpha: 1)
    viewRosa.backgroundColor = .systemPink
    viewBox.backgroundColor = UIColor(red: CGFloat(32)/CGFloat(255), green: CGFloat(34)/CGFloat(255), blue: CGFloat(46)/CGFloat(255), alpha: 0.77)
    
    view.addSubview(textLabel)
    
    view.addSubview(viewAzul)
    viewAzul.addSubview(textLabelViewBlue)
    
    view.addSubview(viewVermelho)
    viewVermelho.addSubview(textLabelViewRed)
    
    view.addSubview(viewYellow)
    viewYellow.addSubview(textLabelViewYellow)
    
    view.addSubview(viewRosa)
    viewRosa.addSubview(textLabelViewPink)
    
    view.addSubview(viewBox)
    viewBox.addSubview(textLabelViewBox)
    
    NSLayoutConstraint.activate([
      textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      textLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      
      textLabelViewBlue.centerYAnchor.constraint(equalTo: viewAzul.centerYAnchor),
      textLabelViewBlue.centerXAnchor.constraint(equalTo: viewAzul.centerXAnchor),
      viewAzul.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 30),
      viewAzul.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor),
      viewAzul.widthAnchor.constraint(equalToConstant: 150),
      viewAzul.heightAnchor.constraint(equalToConstant: 150),
      
      textLabelViewRed.centerYAnchor.constraint(equalTo: viewVermelho.centerYAnchor),
      textLabelViewRed.centerXAnchor.constraint(equalTo: viewVermelho.centerXAnchor),
      viewVermelho.topAnchor.constraint(equalTo: viewAzul.topAnchor),
      viewVermelho.leadingAnchor.constraint(equalTo: viewAzul.trailingAnchor, constant: 20),
      viewVermelho.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      viewVermelho.widthAnchor.constraint(equalTo: viewAzul.widthAnchor),
      viewVermelho.heightAnchor.constraint(equalTo: viewAzul.heightAnchor),
      
      textLabelViewYellow.centerYAnchor.constraint(equalTo: viewYellow.centerYAnchor),
      textLabelViewYellow.centerXAnchor.constraint(equalTo: viewYellow.centerXAnchor),
      viewYellow.topAnchor.constraint(equalTo: viewAzul.bottomAnchor, constant: 20),
      viewYellow.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor),
      viewYellow.widthAnchor.constraint(equalTo: viewAzul.widthAnchor),
      viewYellow.heightAnchor.constraint(equalTo: viewAzul.heightAnchor),
      
      textLabelViewPink.centerYAnchor.constraint(equalTo: viewRosa.centerYAnchor),
      textLabelViewPink.centerXAnchor.constraint(equalTo: viewRosa.centerXAnchor),
      viewRosa.topAnchor.constraint(equalTo: viewVermelho.bottomAnchor, constant: 20),
      viewRosa.leadingAnchor.constraint(equalTo: viewVermelho.leadingAnchor),
      viewRosa.trailingAnchor.constraint(equalTo: viewVermelho.trailingAnchor),
      viewRosa.widthAnchor.constraint(equalTo: viewAzul.widthAnchor),
      viewRosa.heightAnchor.constraint(equalTo: viewAzul.heightAnchor),
      
      textLabelViewBox.centerYAnchor.constraint(equalTo: viewBox.centerYAnchor),
      textLabelViewBox.centerXAnchor.constraint(equalTo: viewBox.centerXAnchor),
      viewBox.topAnchor.constraint(equalTo: viewYellow.bottomAnchor, constant: 30),
      viewBox.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor),
      viewBox.trailingAnchor.constraint(equalTo: viewRosa.trailingAnchor),
      viewBox.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
}

