import UIKit

class ViewController: UITableViewController {
  // Criando variaveis globais para a view, ou seja, a variavel ira existir ate a existencia da view.
  var pictures = [(imageName: String, titleImage: String)]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.prefersLargeTitles = true
    title = "Storm Viewer"
    
    let fm = FileManager.default
    let path = Bundle.main.resourcePath!
  
    let items = try! fm.contentsOfDirectory(atPath: path)
    
    /*
     for item in items {
       if item.hasPrefix("nssl") {
         pictures.append(item)
       }
     }
     */
    
    // Outra maneira de fazer
    pictures = getImages(items, prefixImage: "nssl", sorted: true)
    print(pictures)
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pictures.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
    print(indexPath)
    cell.textLabel?.text = pictures[indexPath.row].titleImage
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //storyboard?.instantiateViewController(withIdentifier:) -> cria uma view controller com um determinado identifier
    if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
      vc.selectedImage = pictures[indexPath.row]
      navigationController?.pushViewController(vc, animated: true)
    }
  }
}
