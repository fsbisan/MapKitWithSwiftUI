//
//  CoordinateGetHelper.swift
//  MapKitWithSwiftUI
//
//  Created by Александр Макаров on 09.11.2022.
//

import Foundation
import MapKit

class CoordinateGetHelper: ObservableObject {
    @Published var searchedMapItems: [MKMapItem] = []
    
    func localSearch(itemName: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = itemName
        
        //Выставляем в локацию (Нижний Тагил)
        searchRequest.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 58, longitude: 60),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { [unowned self] (response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let response = response else { return }
            
            self.searchedMapItems = response.mapItems
            
            for item in response.mapItems {
                if let name = item.name,
                   let location = item.placemark.location {
                    print("\(name): \(location.coordinate.latitude),\(location.coordinate.longitude)")
                }
            }
        }
    }
}
