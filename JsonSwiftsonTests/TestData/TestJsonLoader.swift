import Foundation

public class TestJsonLoader {
  public func read(_ filename: String) -> String {
    let bundle = Bundle(for: self.dynamicType)
    let path = bundle.pathForResource(filename, ofType: nil)
    return try! String(contentsOfFile: path!, encoding: String.Encoding.utf8)
  }
}
