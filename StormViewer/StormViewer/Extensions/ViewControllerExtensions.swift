import Foundation

protocol IViewControllerExtensions {
  func getImages(_ items: [String], prefixImage: String, sorted: Bool) -> [(String, String)]
}

extension ViewController: IViewControllerExtensions {
  public func getImages(_ items: [String], prefixImage: String, sorted: Bool = false) -> [(String, String)] {
    let picturesNssl = sorted ? items.filter { $0.hasPrefix(prefixImage) }.sorted() : items.filter { $0.hasPrefix(prefixImage) }

    return picturesNssl.map {(
      imageName: $0,
      titleImage: "Picture \(picturesNssl.firstIndex(of: $0)! + 1) of \(picturesNssl.count)"
    )}
  }
}
