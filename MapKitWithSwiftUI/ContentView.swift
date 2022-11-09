//
//  ContentView.swift
//  MapKitWithSwiftUI
//
//  Created by Александр Макаров on 09.11.2022.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @StateObject private var coordinateGetHelper = CoordinateGetHelper()
    @State var targetMKItems: [MKMapItem] = []
    @State var textValue = ""
    @FocusState private var focusedField: Field?
    
    private  func addTarget(item: MKMapItem) {
        targetMKItems.append(item)
    }
    
    var body: some View {
        GeometryReader { geometry in
            
            let width = geometry.size.width
            
            ZStack {
                VStack {
                    MapView(targetMKItems: $targetMKItems)
                        .ignoresSafeArea()
                }
                .onTapGesture {
                    focusedField = nil
                    coordinateGetHelper.searchedMapItems = []
                    textValue = ""
                }
                if !targetMKItems.isEmpty {
                    VStack {
                        ForEach(targetMKItems, id: \.self) { item in
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 300, height: 40)
                                    .foregroundColor(.white)
                                Text(item.name ?? "")
                            }
                        }
                        Spacer()
                    }
                }
                
                VStack {
                    Spacer()
                    HStack {
                        TextField("Find Location", text: $textValue)
                            .onChange(of: textValue) { newValue in
                                coordinateGetHelper.localSearch(itemName: newValue)
                            }
                            .textFieldStyle(.roundedBorder)
                            .focused($focusedField, equals: .first)
                        Button {
                            coordinateGetHelper.searchedMapItems = []
                            textValue = ""
                        } label: {
                            Text("Delete")
                                .padding(7)
                                .background(Color(.white))
                                .cornerRadius(5)
                        }
                        Button {
                            targetMKItems = []
                        } label: {
                            Text("Clear")
                                .padding(7)
                                .background(Color(.white))
                                .cornerRadius(5)
                        }
                    }
                    .padding()
                    if !coordinateGetHelper.searchedMapItems.isEmpty {
                        List(coordinateGetHelper.searchedMapItems, id: \.self) { mapItem in
                            if let name = mapItem.name {
                                Button(action: {
                                    addTarget(item: mapItem)
                                }, label: {
                                    Text(name)
                                })
                            }
                        }.listStyle(.inset)
                            .frame(width: width, height: coordinateGetHelper.searchedMapItems.count < 6 ? CGFloat(coordinateGetHelper.searchedMapItems.count) * 40 : 240, alignment: .leading)
                            .padding(.bottom)
                    }
                }
            }
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
