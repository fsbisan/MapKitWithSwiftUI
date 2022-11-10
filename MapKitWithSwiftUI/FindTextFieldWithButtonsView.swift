//
//  FindTextFieldWithButtonsView.swift
//  MapKitWithSwiftUI
//
//  Created by Александр Макаров on 10.11.2022.
//

import SwiftUI
import MapKit

struct FindTextFieldWithButtonsView: View {
    
    @Binding var showItems: Bool
    @Binding var textValue: String
    @ObservedObject var mapItemManager: MapItemManager
    
    let deleteButtonAction: () -> Void
    let routeButtonAction: () -> Void
    let showRoute: Bool
    let items: [MKMapItem]
    
    var body: some View {
        HStack {
            FindingAddressTextFieldView(showItems: $showItems,
                                        textValue: $textValue,
                                        mapItemManager: mapItemManager)
            Button {
                deleteButtonAction()
            } label: {
                Text("Delete")
                    .padding(7)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.red, lineWidth: 2)
                        
                    })
                    .background(Color(.white))
            }
            Button {
                routeButtonAction()
            } label: {
                Text(showRoute ? "Clear" : "Route")
                    .padding(7)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.red, lineWidth: 2)
                    })
                    .background(Color(.white))
            }.disabled(items.count < 2)
        }
        .padding()
    }
}

struct FindTextFieldWithButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        FindTextFieldWithButtonsView(showItems: .constant(true), textValue: .constant("Text"),
                                     mapItemManager: MapItemManager(), deleteButtonAction: {},
                                     routeButtonAction: {}, showRoute: true,
                                     items: [])
    }
}
