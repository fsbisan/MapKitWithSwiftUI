//
//  MapView.swift
//  MapKitWithSwiftUI
//
//  Created by Александр Макаров on 09.11.2022.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    // Набор айтемов для отображения аннотаций и маршрута
    @Binding var targetMKItems: [MKMapItem]
    
    // Свойство показывает отображается ли маршрут
    @Binding var showRoute: Bool
    
    typealias UIViewType = MKMapView
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        // Задаем регион
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 58, longitude: 60),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        mapView.setRegion(region, animated: true)
        
        return mapView
    }
    
    // Метод обновления карты
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if !targetMKItems.isEmpty {
            for targetMKItem in targetMKItems {
                uiView.showAnnotations([targetMKItem.placemark], animated: true)
            }
        } else {
            resetButtonDidTapped()
        }
        
        if showRoute {
            // Создаем запрос
            let request = MKDirections.Request()
            request.source = targetMKItems[0]
            request.destination = targetMKItems[1]
            request.transportType = .automobile
            
            // Запрашиваем маршрут
            let directions = MKDirections(request: request)
            directions.calculate { response, error in
                guard let route = response?.routes.first else { return }
                uiView.addOverlay(route.polyline)
                uiView.setVisibleMapRect(
                    route.polyline.boundingMapRect,
                    edgePadding: UIEdgeInsets(top: 120, left: 20, bottom: 60, right: 20),
                    animated: true)
            }
        }
        
        func resetButtonDidTapped() {
            // Очищаем наложенные маршруты
            uiView.removeOverlays(uiView.overlays)
            // Очищаем аннотации
            uiView.removeAnnotations(uiView.annotations)
        }
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    final class MapViewCoordinator: NSObject, MKMapViewDelegate {
        internal func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            // Рисуем полилинию(маршрут)
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 5
            return renderer
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(targetMKItems: .constant([]), showRoute: .constant(false))
    }
}
