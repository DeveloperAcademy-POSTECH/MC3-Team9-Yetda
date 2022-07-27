//
//  MapCell.swift
//  Yetda
//
//  Created by Jinsan Kim on 2022/07/25.
//

import UIKit
import MapKit

class MapCell: UICollectionViewCell {
    var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupCell()
    }
    
    func setupCell() {
        mapView = MKMapView()
        contentView.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        mapView.layer.cornerRadius = 12
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func moveLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double) {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let pSpanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: pSpanValue)
        mapView.setRegion(pRegion, animated: true)
    }
    
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subtitle strSubTitle: String) {
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        annotation.title = strTitle
        annotation.subtitle = strSubTitle
        mapView.addAnnotation(annotation)
    }
}
