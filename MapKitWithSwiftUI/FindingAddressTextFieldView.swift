//
//  FindingAddressTextFieldView.swift
//  MapKitWithSwiftUI
//
//  Created by Александр Макаров on 10.11.2022.
//

import SwiftUI

struct FindingAddressTextFieldView: View {
    
    @Binding var showItems: Bool
    @Binding var textValue: String
    @ObservedObject var mapItemManager: MapItemManager
    
    var body: some View {
        TextField("Find Location", text: $textValue)
            .onChange(of: textValue) { itemName in
                mapItemManager.searchItems(with: itemName)
                if !mapItemManager.searchedMapItems.isEmpty {
                    withAnimation {
                        showItems = true
                    }
                } else {
                    withAnimation {
                        showItems = false
                    }
                }
            }
            .textFieldStyle(.roundedBorder)
            .overlay(content: {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.red, lineWidth: 2)
            })
    }
}

struct FindingAddressTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        FindingAddressTextFieldView(showItems: .constant(true), textValue: .constant("Кофе"), mapItemManager: MapItemManager())
    }
}
