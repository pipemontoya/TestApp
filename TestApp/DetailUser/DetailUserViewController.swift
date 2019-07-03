//
//  DetailUserViewController.swift
//  TestApp
//
//  Created by Andres Montoya on 7/2/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import UIKit
import MapKit

class DetailUserViewController: UIViewController {
    
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: DetailViewModel? = nil
    
    deinit {
        viewModel?.delegate = nil
        mapView.delegate = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        tableView.dataSource = self
        tableView.delegate = self
        viewModel?.getAlbums()
        viewModel?.delegate = self
        userNameLabel.text = viewModel?.user.name
        phoneLabel.text  = viewModel?.user.phone
        companyLabel.text = viewModel?.user.company.name
        mapView.delegate = self
        centerMapOnLocation(location: viewModel?.getLocation() ?? CLLocation())
        mapView.addAnnotation((viewModel?.createAnnotation())!)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: viewModel?.regionRadius ?? CLLocationDistance(),
            longitudinalMeters: viewModel?.regionRadius ?? CLLocationDistance())
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "album" {
            let album = sender as! Albums
            let vc = segue.destination as? DetailAlbumViewController
            vc?.viewModel = DetailAlbumViewModel(album: album)
        }
    }

}

extension DetailUserViewController: DetailDelegate {
    func albums(_ albums: [Albums]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

extension DetailUserViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? UserAnnotation else { return nil }
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}

extension DetailUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.albums.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "album", for: indexPath)
        cell.textLabel?.text = viewModel?.albums[indexPath.row].title
        return cell
    }
}

extension DetailUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = viewModel?.albums[indexPath.row]
        performSegue(withIdentifier: "album", sender: album)
    }
}

