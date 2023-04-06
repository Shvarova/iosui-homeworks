//
//  MapView.swift
//  Navigation
//
//  Created by Дина Шварова on 06.04.2023.
//

import UIKit
import MapKit

class MapView: UIView {
    lazy var map: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.mapType = .standard
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsUserLocation = true

        let pointsOfInterestFilter = MKPointOfInterestFilter()
        mapView.pointOfInterestFilter = pointsOfInterestFilter
        return mapView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .white
        addSubview(map)

        let safeAreaGuide = safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            map.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            map.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            map.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            map.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }
}

