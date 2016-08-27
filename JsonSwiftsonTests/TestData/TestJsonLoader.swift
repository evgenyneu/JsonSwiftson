import Foundation

public class TestJsonLoader {
  public func read(_ filename: String) -> String {
    let bundle = Bundle(for: type(of: self))
    let path = bundle.path(forResource: filename, ofType: nil)
    return try! String(contentsOfFile: path!, encoding: String.Encoding.utf8)
  }
}
