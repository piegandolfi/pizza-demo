//
//  MapViewController.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import UIKit
import GoogleMaps
import RxSwift
import RxOptional
import NVActivityIndicatorView

class MapViewController: UIViewController {
    
    // MARK: - Properties
    
    private var interactor: MapBusinessLogic!
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var mapView: GMSMapView!
    
    private let locationManager = CLLocationManager()
    private var mapViewModel: Observable<[PizzaPlaceViewModel]>!
    private var animationPresenter: AnimationPresenter!
    private var pizzaPlaceID: String?
    
    // MARK: - Lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let interactor = MapInteractor()
        self.interactor = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        mapView.delegate = self
        
        setupLayout()
        setupNavigationBar()
        
        startAnimation()
        
        interactor
            .requestPizzaFriends()
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func setupLayout() {
        setupUI()
    }
    
    private func setupNavigationBar() {
        /// Setup Title
        navigationItem.title = "Best pizza in town"
        
        /// Back button
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backButton")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backButton")
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.imageInsets = UIEdgeInsets(top: 8, left: -8, bottom: 8, right: 8)
        
        /// Left icon Image
        let pizzaImage = UIImage(named: "pizzaIcon")
        let pizzaBut = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        pizzaBut.setImage(pizzaImage, for: .normal)
        pizzaBut.imageView?.contentMode = .scaleAspectFit
        pizzaBut.imageEdgeInsets = UIEdgeInsets(top: 4, left: -6, bottom: 4, right: 6)
        let pizzaButton = UIBarButtonItem(customView: pizzaBut)
        navigationItem.leftBarButtonItem = pizzaButton
    }
    
    private func startAnimation() {
        // Activity Indicator
        
        animationPresenter = AnimationPresenter()
        animationPresenter.present(in: self, animated: true)
    }
    
    // MARK: - Actions
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let _ = address.lines else {
                return
            }
            
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D) {
        // Request Pizza Places addresses.
        interactor.requestPizzaPlaces()
            .subscribe(onNext: { [unowned self] (viewModel) in
                self.mapViewModel = Observable.just(viewModel)
                self.mapView.clear()
                
                viewModel.forEach({ (mapVM) in
                    let marker = PizzaMarker(place: mapVM)
                    marker.map = self.mapView
                })
                
                self.locationManager.startUpdatingLocation()
                self.mapView.camera = GMSCameraPosition(target: viewModel.first!.coordinates, zoom: 15, bearing: 0, viewingAngle: 0)
                self.locationManager.stopUpdatingLocation()
                self.delay(2.5, closure: {
                    self.animationPresenter.animationController.dismiss(animated: true)
                })
                
                
                }, onError: { (err) in
                    print(err)
            })
            .disposed(by: disposeBag)
        
    }
    
    @IBAction func searchAction(_ sender: Any) {
        let alertView = AlertPresenter(.search)
        alertView.present(in: self, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let placeDetails = segue.destination as? PlaceDetailsViewController {
            placeDetails.pizzaPlaceID = pizzaPlaceID!
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        guard status == .authorizedWhenInUse else { return }
        
        locationManager.startUpdatingLocation()
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        locationManager.stopUpdatingLocation()
        delay(1.5, closure: {
            self.animationPresenter.animationController.dismiss(animated: true)
        })
        
        fetchNearbyPlaces(coordinate: location.coordinate)
    }
    
}

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target)
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let pizzaMarker = marker as? PizzaMarker else {
            return false
        }
        print("You tapped at marker: \(pizzaMarker)")
        pizzaPlaceID = pizzaMarker.id
        
        performSegue(withIdentifier: "goToDetails", sender: pizzaMarker)
        
        return true
    }
}


