//
//  MapViewController.swift
//  Navigation
//
//  Created by Дина Шварова on 06.04.2023.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {
    private lazy var mainView = MapView()
    private lazy var locationManager = CLLocationManager()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.map.delegate = self
        findUserLocation()
        addLongPress()
        addPin(to: CLLocationCoordinate2D(latitude: 59.925426, longitude: 30.295863))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.startUpdatingLocation()
        locationManager.requestLocation()
    }
    
    private func findUserLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
    }
    
    private func addLongPress() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotation))
        longPress.minimumPressDuration = 1
        mainView.map.addGestureRecognizer(longPress)
    }
    
    @objc private func addAnnotation(gesture: UIGestureRecognizer) {
        guard gesture.state == .ended,
              let mapView = gesture.view as? MKMapView else {return}
        let point = gesture.location(in: mapView)
        let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
        showRoute(to: coordinate)
    }
    
    private func showRoute(to coordinate: CLLocationCoordinate2D) {
//        removeAnnotations()
        guard let latitude = locationManager.location?.coordinate.latitude,
              let longitude = locationManager.location?.coordinate.longitude else {
            showAlert(with: "Location cannot be retrieved")
            return
        }
        
        let userCoordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: userCoordinates))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        request.transportType = .any
        
        let directions = MKDirections(request: request)
        
        directions.calculate { response, error in
            if let error = error {
                self.showAlert(with: error.localizedDescription)
                return
            }
            guard let response = response else {
                self.showAlert(with: "No response")
                return
            }
            self.addPin(to: coordinate)
            for route in response.routes {
                self.mainView.map.addOverlay(route.polyline)
                self.mainView.map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
            self.addRemoveButton()
        }
    }
    
    private func addRemoveButton() {
        let item = UIBarButtonItem(title: "remove", style: .done, target: self, action: #selector(removeAnnotations))
        navigationItem.rightBarButtonItem = item
    }
    
    @objc private func removeAnnotations() {
        mainView.map.removeAnnotations(mainView.map.annotations)
        mainView.map.removeOverlays(mainView.map.overlays)
        navigationItem.rightBarButtonItem = nil
    }
    
    private func addPin(to coordinate: CLLocationCoordinate2D) {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            mainView.map.addAnnotation(annotation)
        }
    
    private func showAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else {return}
        mainView.map.setCenter(location.coordinate, animated: true)
        
        let region = MKCoordinateRegion(center: mainView.map.centerCoordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mainView.map.setRegion(region, animated: false)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        case .denied, .restricted:
            print("Определение локации невозможно")
        case .notDetermined:
            print("Определение локации не запрошено")
        @unknown default:
            fatalError()
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .systemBlue
        return render
    }
}
