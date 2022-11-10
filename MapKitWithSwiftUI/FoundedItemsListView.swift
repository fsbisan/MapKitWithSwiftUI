//
//  FoundedItemsListView.swift
//  MapKitWithSwiftUI
//
//  Created by Александр Макаров on 10.11.2022.
//

import SwiftUI
import MapKit

struct FoundedItemsListView: View {
    @ObservedObject var mapItemManager: MapItemManager
    @Binding var items: [MKMapItem]
    @Binding var showDirectionPoints: Bool
    
    let width: CGFloat
    
    var body: some View {
        List(mapItemManager.searchedMapItems, id: \.self) { mapItem in
            if let name = mapItem.name {
                Button(action: {
                    withAnimation {
                        addTarget(item: mapItem)
                        if !items.isEmpty {
                            showDirectionPoints = true
                        }
                    }
                }, label: {
                    Text(name)
                })
            }
        }
        .transition (.move (edge: .bottom))
        .listStyle(.inset)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.red, lineWidth: 2)
        })
        .frame(width: width - 32, height: 180, alignment: .leading)
        .padding(.bottom)
    }
    
    private  func addTarget(item: MKMapItem) {
        items.append(item)
    }
}


struct FoundedItemsListView_Previews: PreviewProvider {
    static var previews: some View {
        FoundedItemsListView(mapItemManager: MapItemManager(), items: .constant([]), showDirectionPoints: .constant(true), width: 400)
    }
}
