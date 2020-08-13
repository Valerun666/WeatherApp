//
//  AddCity.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 13.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI
import Combine
import GooglePlaces

struct AddCity: UIViewControllerRepresentable {
    var cityPublisher: PassthroughSubject<City?, Never>
    let coordinator: Coordinator

    init(cityPublisher: PassthroughSubject<City?, Never>) {
        self.cityPublisher = cityPublisher
        self.coordinator = Coordinator(cityPublisher: cityPublisher)
    }

    func makeUIViewController(context: Context) -> GMSAutocompleteViewController {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = coordinator

        return autocompleteController
    }

    func updateUIViewController(_ controller: GMSAutocompleteViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(cityPublisher: cityPublisher)
    }

    class Coordinator: NSObject, GMSAutocompleteViewControllerDelegate {
        var cityPublisher: PassthroughSubject<City?, Never>

        init(cityPublisher: PassthroughSubject<City?, Never>) {
            self.cityPublisher = cityPublisher
        }

        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            print("Place name: \(String(describing: place.name))")
            print("Place address: \(String(describing: place.formattedAddress))")
            print("Place attributions: \(String(describing: place.attributions))")

            guard let name = place.name else {
                return
            }
            cityPublisher.send(City(name: name, lat: place.coordinate.latitude, lon: place.coordinate.longitude))
            viewController.dismiss(animated: true, completion: nil)
        }
        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            print("Error: ", error.localizedDescription)
        }
        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            viewController.dismiss(animated: true, completion: nil)
        }
    }
}
