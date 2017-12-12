import UIKit
import CoreData

class ViewController: UIViewController ,UIImagePickerControllerDelegate ,UINavigationControllerDelegate{

    @IBOutlet weak var tfname: UITextField!
    @IBOutlet weak var tfanimal: UITextField!
    @IBOutlet weak var tfdate: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var imageview: UIImageView!
    
    
    var info = [Info]()
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        savedata()
        navigationItem.title = "Pet"
    }
    
    @IBAction func chooseImage(_ sender: Any) {
        let imagePickercontroller = UIImagePickerController()
        imagePickercontroller.sourceType = .photoLibrary
        imagePickercontroller.delegate = self
        present(imagePickercontroller, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedimage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageview.image = selectedimage
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func savedata() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let spot = NSEntityDescription.insertNewObject(forEntityName: "Spot", into: context) as! Spot
        spot.image = UIImageJPEGRepresentation(imageview.image!, 1.0) as NSData?
        spot.name = tfname.text!
        spot.animal = tfanimal.text!
        var genderin = ""
        let selectedindex = gender.selectedSegmentIndex
        if selectedindex == 0 {
            genderin += "male"
        } else if selectedindex == 1 {
            genderin += "female"
        }
        spot.gender = genderin
        let birthin = tfdate.text!
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let newdate = format.date(from: birthin)!
        spot.birth = newdate as NSDate
        do {
        try context.save()
        } catch {
            fatalError("fail to save data!")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

        
    
    

    

}

