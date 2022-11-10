//
//  ContentView.swift
//  MapKitWithSwiftUI
//
//  Created by Александр Макаров on 09.11.2022.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @StateObject private var mapItemManager = MapItemManager()
    @State private var targetMKItems: [MKMapItem] = []
    @State private var textValue = ""
    @State private var showItems = false
    @State private var showDirectionPoints = false
    @State private var showRoute = false
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        GeometryReader { geometry in
            
            let width = geometry.size.width
            
            ZStack {
                MapView(targetMKItems: $targetMKItems, showRoute: $showRoute)
                    .ignoresSafeArea()
                    .onTapGesture {
                        focusedField = nil
                        mapItemManager.searchedMapItems = []
                        textValue = ""
                    }
                if showDirectionPoints {
                    StartAndEndPointsView(mkItems: targetMKItems)
                }
                VStack {
                    Spacer()
                    FindTextFieldWithButtonsView(showItems: $showItems, textValue: $textValue,
                                  mapItemManager: mapItemManager, deleteButtonAction: deleteItems, routeButtonAction: routeButtonDidTapped, showRoute: showRoute,
                                  items: targetMKItems)
                        .focused($focusedField, equals: .first)
                    
                    if showItems {
                        FoundedItemsListView(mapItemManager: mapItemManager, items: $targetMKItems, showDirectionPoints: $showDirectionPoints, width: width)
                    }
                }
            }
        }
    }
    
    private func deleteItems() {
        mapItemManager.searchedMapItems = []
        textValue = ""
    }
    
    private func routeButtonDidTapped() {
        if showRoute {
            targetMKItems = []
            showRoute = false
        } else {
            showRoute = true
            focusedField = nil
            deleteItems()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    enum Field {
        case first
    }
}
