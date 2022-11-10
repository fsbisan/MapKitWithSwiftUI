//
//  StartAndEndPointsView.swift
//  MapKitWithSwiftUI
//
//  Created by Александр Макаров on 10.11.2022.
//

import SwiftUI
import MapKit

struct StartAndEndPointsView: View {
    
    let mkItems: [MKMapItem]
    
    var body: some View {
        VStack {
            ForEach(Array(zip(mkItems.indices, mkItems)), id: \.0) { index, item in
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .overlay(content: {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.red, lineWidth: 2)
                        })
                        .frame(width: 250, height: 35)
                        .foregroundColor(.white)
                    Text("\(index % 2 == 0 ? "Откуда:" : "Куда:") \(item.name ?? "")")
                        .multilineTextAlignment(.leading)
                }
                .transition (.move (edge: .leading))
            }
            Spacer()
        }
        .transition (.move (edge: .leading))
    }
}

struct StartAndEndPointsView_Previews: PreviewProvider {
    static var previews: some View {
        StartAndEndPointsView(mkItems: [])
    }
}
