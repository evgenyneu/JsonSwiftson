import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var outputLabel: UILabel!
  @IBOutlet weak var button: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    outputLabel.text = ""
  }
  
  @IBAction func onMapJsonToSwiftTapped(sender: AnyObject) {
    let json = TestJsonLoader().read("people.json")

    let tick = TickTock()
    
    for i in 1...100 {
      let people = PeopleParser.parse(json)
      
      if people.isEmpty {
        outputLabel.text = "Mapping error"
        return
      }
    }
    
    let timeElapsed = tick.formatted()
    outputLabel.text = "Time: \(timeElapsed)"    
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
}

