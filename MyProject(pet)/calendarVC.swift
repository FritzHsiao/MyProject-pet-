import UIKit
import FSCalendar


class calendarVC: UIViewController ,FSCalendarDataSource ,FSCalendarDelegate ,UITableViewDelegate ,UITableViewDataSource{

    @IBOutlet weak var tableV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    var selecteddate: Date?

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selecteddate = date
        print(date)
        TodayResult.selectedList.removeAll()
        for a in TodayResult.List {
            if datecompare(date, a.date) {
                print("\n\(a.date)\n\(a.result)\nyes")
                let event = TodayResult(date: a.date, result: a.result)
                TodayResult.selectedList.append(event)
            } else {
                print("\n\(a.date)\n\(a.result)\nno match")
            }
        }
        tableV.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let selectA = selecteddate
            let newEventVC = segue.destination as? newEventVC
            newEventVC?.selectDate = selectA
        }
    }
    
    func datecompare(_ selecteddate: Date, _ Resultdate: Date) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let selecteddateString = formatter.string(from: selecteddate)
        let ResultdateString = formatter.string(from: Resultdate)
        if selecteddateString == ResultdateString {
            return true
        } else {
            return false
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodayResult.selectedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellid = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid)!
        cell.textLabel?.text = TodayResult.selectedList[indexPath.row].result
        return cell
    }



    



}
