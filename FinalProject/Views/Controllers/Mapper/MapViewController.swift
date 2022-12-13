//
//  MapViewController.swift
//  FinalProject
//
//  Created by luong.tran on 23/11/2022.
//

import UIKit
import MapKit
import CoreLocation

final class MapViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet private weak var mapView: MKMapView!

    // MARK: Properties
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    var viewModel: MapViewModel?

    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        setupLocationManager()
        mapView.delegate = self
        getLocationShops()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDesinationLocation()
    }

    // MARK: Private methods
    private func configNavigation() {
        navigationItem.title = Define.title

        let backButton = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "chevron"), style: .plain, target: self, action: #selector(returnButtonTouchUpInside))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }

    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }

    private func draw() {
        guard let viewModel = viewModel,
              let resource = viewModel.resourceLocation?.coordinate,
              let des = viewModel.destinationLocation else { return }
        let source = CLLocationCoordinate2D(latitude: resource.latitude, longitude: resource.longitude)
        let destination = CLLocationCoordinate2D(latitude: des.latitude, longitude: des.longitude)
        routing(source: source, destination: destination)
    }

    private func addPin(coordinate: CLLocationCoordinate2D, title: String, subTitle: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        annotation.subtitle = subTitle
        mapView.addAnnotation(annotation)
    }

    private func zoomCenter(location: CLLocation) {
        mapView.setCenter(location.coordinate, animated: true)
        let span = MKCoordinateSpan(latitudeDelta: Define.span, longitudeDelta: Define.span)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }

    private func routing(source: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: source, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        let directions = MKDirections(request: request)
        showHUD()
        directions.calculate { [unowned self] response, _ in
            dismissHUD()
            guard let unwrappedResponse = response else { return }
            let route = unwrappedResponse.routes[0]
            mapView.removeOverlays(mapView.overlays)
            mapView.addOverlay(route.polyline, level: .aboveRoads)
            mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        }
    }

    @objc private func returnButtonTouchUpInside() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: Define
extension MapViewController {
    private struct Define {
        static var title: String = "Map"
        static var span: CGFloat = 0.03
        static var overlayColor: UIColor = UIColor.blue
        static var overlayWidth: CGFloat = 5
    }
}

// MARK: Delegate MapView, LocationManager
extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let viewModel = viewModel else { return }
        if currentLocation == nil {
            currentLocation = locations.last
            locationManager.stopMonitoringSignificantLocationChanges()
            viewModel.resourceLocation = currentLocation
            locationManager.stopUpdatingLocation()
            mapView.showsUserLocation = true
        }
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let viewModel = viewModel else { return }
        viewModel.destinationLocation = view.annotation?.coordinate
        UIView.animate(withDuration: 0.5, delay: 1, options: .transitionCrossDissolve) { [weak self] in
            guard let this = self else { return }
            this.draw()
        }
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay.isKind(of: MKPolyline.self) {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.fillColor = Define.overlayColor
            polylineRenderer.strokeColor = Define.overlayColor
            polylineRenderer.lineWidth = Define.overlayWidth
            return polylineRenderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}

// MARK: Get Location
extension MapViewController {

    private func getDesinationLocation() {
        guard let viewModel = viewModel,
              let shop = viewModel.shop else { return }
        getLocation(from: shop.address) { [weak self] location in
            guard let location = location,
                  let this = self else { return }
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            this.zoomCenter(location: CLLocation(latitude: location.latitude, longitude: location.longitude))
            this.addPin(coordinate: annotation.coordinate, title: shop.nameShop, subTitle: shop.phoneNumber)
        }
    }

    private func getLocation(from address: String, completion: @escaping (_ location: CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, _) in
            guard let placemarks = placemarks,
            let location = placemarks.first?.location?.coordinate else {
                completion(nil)
                return
            }
            completion(location)
        }
    }
}

// MARK: Get APIs
extension MapViewController {

    private func getLocationShops() {
        guard let viewModel = viewModel else { return }
        viewModel.getApiShop { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let shops):
                for shop in shops {
                    this.getLocation(from: shop.address) { [weak self] location in
                        guard let location = location,
                              let this = self else { return }
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                        this.addPin(coordinate: annotation.coordinate, title: shop.nameShop, subTitle: shop.phoneNumber)
                    }
                }
            case .failure(let err):
                this.alert(msg: err.localizedDescription, completion: nil)
            }
        }
    }
}
