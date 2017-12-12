import UIKit
import FSCalendar

class newEventVC: UIViewController {
    
    @IBOutlet weak var newtext: UITextView!
    
    
    var selectDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New"
        print(selectDate!)
        
    }

    @IBAction func save(_ sender: Any) {
        let selectDa = selectDate
        let textin = newtext.text!
        print(selectDa!)
        let newResult = TodayResult(date: selectDa!,result: textin)
        TodayResult.List.append(newResult)
        print("saved user event!")
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clear(_ sender: Any) {
        newtext.text = nil
        self.navigationController?.popViewController(animated: true)
    }
    
}
