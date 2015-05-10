import Foundation

public class TestJsonLoader {
  public class func read(filename: String, bundle: NSBundle) -> String {
    let path = bundle.pathForResource(filename, ofType: nil)
    return String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
  }
}
