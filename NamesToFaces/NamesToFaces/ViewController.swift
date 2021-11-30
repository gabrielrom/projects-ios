import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  var people = [Person]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
//    1 forma de fazer usando o NSCoding:
//    let defaults = UserDefaults.standard
//
//    if let savedPeople = defaults.object(forKey: "people") as? Data {
//      if let decodedPeople = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPeople) as? [Person] {
//        people = decodedPeople
//      }
//    }
    
    let defaults = UserDefaults.standard

    if let savedPeople = defaults.object(forKey: "people") as? Data {
        let jsonDecoder = JSONDecoder()

        do {
            people = try jsonDecoder.decode([Person].self, from: savedPeople)
        } catch {
            print("Failed to load people")
        }
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return people.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
      fatalError("Unable to dequeue PersonCell.")
    }
    
    let person = people[indexPath.item]
    let pathImage = getDocumentsDirectory().appendingPathComponent(person.image)
    
    cell.name.text = person.name
    cell.name.textColor = .black
    cell.imageView.image = UIImage(contentsOfFile: pathImage.path)
    
    cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
    cell.imageView.layer.borderWidth = 2
    cell.imageView.layer.cornerRadius = 3
    cell.layer.cornerRadius = 7
    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let person = people[indexPath.item]
    
    let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
    ac.addTextField()
    
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    
    ac.addAction(UIAlertAction(title: "OK", style: .default) {
      [unowned self, ac] _ in
      let newName = ac.textFields![0]
      person.name = newName.text!
      
      self.collectionView?.reloadData()
      self.save()
    })
    
    present(ac, animated: true)
  }
  
  @objc func addNewPerson() {
      let picker = UIImagePickerController()
      picker.allowsEditing = true
      picker.delegate = self
      present(picker, animated: true)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.editedImage] as? UIImage else { return }
    
    let imageName = UUID().uuidString
    let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
    
    if let jpegData = image.jpegData(compressionQuality: 0.8) {
      try? jpegData.write(to: imagePath)
    }
    
    people.append(
      Person(
        name: "Unkown",
        image: imageName
      )
    )
    
    collectionView?.reloadData()
    dismiss(animated: true)
  }
  
  func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
  
  func save() {
    // 1 FORMA DE FAZER UTILIZANDO O NSCODING
//    if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: people, requiringSecureCoding: false) {
//      let defaults = UserDefaults.standard
//      defaults.set(savedData, forKey: "people")
//    }
    
    let jsonEncoder = JSONEncoder()
    
    if let savedData = try? jsonEncoder.encode(people) {
      let defaults = UserDefaults.standard
      
      defaults.set(savedData, forKey: "people")
      return
    }
    
    print("Failed to save people")
  }
}

