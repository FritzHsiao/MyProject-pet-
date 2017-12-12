import UIKit
import CoreData

class mainVC: UIViewController {
    
    @IBOutlet weak var tvinfo: UITextView!
    @IBOutlet weak var imagview: UIImageView!
    
    let calendar = Calendar.current
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loaddata()
    }
    
    
    func loaddata() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<Spot>(entityName: "Spot")
        do{
           let spots = try context.fetch(request)
            for spot in spots {
                let format = DateFormatter()
                format.dateStyle = .medium
                let newdate = format.string(from: spot.birth! as Date)
                let componentset: Set<Calendar.Component> = [.day]
                let datenow = Date()
                let diff = calendar.dateComponents(componentset, from: datenow, to: spot.birth! as Date)
                let age = -diff.day!
                var textage = ""
                if age < 365 && age > 30 {
                    textage += "age = \(age / 30) month"
                } else if age < 30 {
                    textage += "age = \(age)days"
                } else if age > 365 {
                    let year = age / 365
                    textage += "age = \(year)year"
                }
                let text = "name: \(spot.name!)\ngender: \(spot.gender!)\nanimal: \(spot.animal!)\nbirth: \(newdate)\n\(textage)"
                imagview.image = UIImage(data: spot.image as! Data)
                tvinfo.text = text
            }
        }catch {
            fatalError("fail to load data")
            
        }
        
        
    }


}
