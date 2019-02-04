//
//  MapViewControllerTests.swift
//  PizzaDemoTests
//
//  Created by Pietro Gandolfi on 05/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import UIKit
import XCTest
import CoreLocation
@testable import PizzaDemo
@testable import GoogleMaps

class MapViewControllerTests: XCTestCase {
    
    func test_initWithCoder_shouldInit() {
        // GIVEN
        let fakeData = Data(count: 8).base64EncodedData()

        do {
            let stubData = try NSKeyedUnarchiver(forReadingFrom: fakeData)
            
            // WHEN
            let sut = MapViewController(coder: stubData)
            
            // THEN
            XCTAssertNotNil(sut)
        } catch {
            print(error)
        }
        
    }

    func test_mapView_idleAt_shouldCallReverseCoordinates() {
        // GIVEN
        let sut = UIStoryboard(name: "Main", bundle: Bundle.main)
            .instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        let stubGMSMapView = GMSMapView(frame: .zero)
        let stubGMSCameraPosition = GMSCameraPosition(
            target: CLLocationCoordinate2D(latitude: 2.0, longitude: 2.0),
            zoom: 1.0,
            bearing: CLLocationDirection(exactly: 2.0)!,
            viewingAngle: 2.0)
        
        // WHEN
        sut.mapView(stubGMSMapView, idleAt: stubGMSCameraPosition)
    }
    
    func test_mapView_didTapAt_shouldCallReverseCoordinates() {
        // GIVEN
        let sut = UIStoryboard(name: "Main", bundle: Bundle.main)
            .instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        let stubGMSMapView = GMSMapView(frame: .zero)
        let stubCoordinates = CLLocationCoordinate2D(latitude: 2.0, longitude: 2.0)
        
        // WHEN
        sut.mapView(stubGMSMapView, didTapAt: stubCoordinates)
    }
    
    func test_mapView_didTapAt_marker_shouldFail() {
        // GIVEN
        let sut = UIStoryboard(name: "Main", bundle: Bundle.main)
            .instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        let stubGMSMapView = GMSMapView(frame: .zero)
        let stubGMSMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: 2.0, longitude: 2.0))
        
        // WHEN
        let value = sut.mapView(stubGMSMapView, didTap: stubGMSMarker)
        
        // THEN
        XCTAssertFalse(value)
    }
    
}
