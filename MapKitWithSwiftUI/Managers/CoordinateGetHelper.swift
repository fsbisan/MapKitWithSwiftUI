//
//  CoordinateGetHelper.swift
//  MapKitWithSwiftUI
//
//  Created by Александр Макаров on 09.11.2022.
//

import Foundation
import MapKit

final class MapItemManager: ObservableObject {
    @Published var searchedMapItems: [MKMapItem] = []
    
    func searchItems(with name: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = name
        
        //Выставляем локацию (Нижний Тагил)
        searchRequest.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 58, longitude: 60),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        // Cоздаем запрос из текста
        let search = MKLocalSearch(request: searchRequest)
        // Запрашиваем айтемы
        search.start { [unowned self] (response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let response = response else { return }
            // Присваеваем полученные значения в массив
            self.searchedMapItems = response.mapItems
        }
    }
}
