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
    var viewModel: AddCityViewModel
    let coordinator: Coordinator

    init(viewModel: AddCityViewModel) {
        self.viewModel = viewModel
        self.coordinator = Coordinator(viewModel: viewModel)
    }

    func makeUIViewController(context: Context) -> GMSAutocompleteViewController {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = coordinator

        return autocompleteController
    }

    func updateUIViewController(_ controller: GMSAutocompleteViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(viewModel: viewModel)
    }

    class Coordinator: NSObject, GMSAutocompleteViewControllerDelegate {
        var viewModel: AddCityViewModel

        init(viewModel: AddCityViewModel) {
            self.viewModel = viewModel
        }

        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            print("Place name: \(String(describing: place.name))")
            print("Place address: \(String(describing: place.formattedAddress))")
            print("Place attributions: \(String(describing: place.attributions))")

            viewModel.didSelect(place: place, onComplete: { [weak viewController] in
                viewController?.dismiss(animated: true, completion: nil)
            })
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
