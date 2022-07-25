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
    }
}
