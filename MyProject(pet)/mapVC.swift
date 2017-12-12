import UIKit
import MapKit
import CoreLocation

class mapVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapkit: MKMapView!
    
    var locationmanager = CLLocationManager()
    
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region = MKCoordinateRegion(center: myLocation, span: span)
        mapkit.setRegion(region, animated: true)
        mapkit.showsUserLocation = true
        findvet()
        print(myLocation.latitude)
        print(myLocation.longitude)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationmanager.delegate = self
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest
        locationmanager.requestWhenInUseAuthorization()
        locationmanager.startUpdatingLocation()
        
        mapkit.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
    
    func findvet (){
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "vet"
        request.region = mapkit.region
        
        let search = MKLocalSearch(request: request)
        
        search.start { (response:MKLocalSearchResponse?, error:Error?) in
            if error == nil {
                let items = response!.mapItems
                
                for item in items {
                    
                    print(item.name!)
                    print(item.placemark.title!)
                    print(item.placemark.coordinate)
                    
                    let vetannotation = MKPointAnnotation()
                    vetannotation.title = item.name
                    vetannotation.subtitle = item.placemark.title
                    vetannotation.coordinate = item.placemark.coordinate
                    
                    self.mapkit.addAnnotation(vetannotation)
                }
            }
            
        }
        
    }
}

extension mapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let identifier = "annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        annotationView?.canShowCallout = true
        annotationView?.animatesDrop = true
        let directButton = UIButton(type: .detailDisclosure)
        annotationView?.rightCalloutAccessoryView = directButton
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let start = mapView.userLocation.coordinate
        let end = view.annotation!.coordinate
        direct(start: start, end: end)
    }
    
    func direct(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D) {
        let placemarkStart = MKPlacemark(coordinate: start, addressDictionary: nil)
        let placemarkEnd = MKPlacemark(coordinate: end, addressDictionary: nil)
        let mapitemStart = MKMapItem(placemark: placemarkStart)
        let mapitemEnd = MKMapItem(placemark: placemarkEnd)
        mapitemStart.name = "my location"
        mapitemEnd.name = "destination"
        let mapitems = [mapitemStart, mapitemEnd]
        let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        MKMapItem.openMaps(with: mapitems, launchOptions: options)
    }
}
