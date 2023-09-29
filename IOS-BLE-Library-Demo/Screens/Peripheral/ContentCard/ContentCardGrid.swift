//
//  ValueGrid.swift
//  BLES-Demo
//
//  Created by Nick Kibysh on 26/09/2023.
//

import SwiftUI

struct ContentCardGrid: View {
    let data: [DisplayableTextValue]
    
    var body: some View {
        Grid(alignment: .leading, horizontalSpacing: 64) {
            ForEach(data.group2(), id: \.0.id) { datum in
                GridRow {
                    Text(datum.0.description.uppercased())
                        .font(.caption)
                    Text(datum.1?.description.uppercased() ?? "")
                        .font(.caption)
                }
                
                GridRow {
                    ContentCardView(value: datum.0.value)
                        .padding(.bottom)
                    ContentCardView(value: datum.1?.value)
                        .padding(.bottom)
                }
            }
        }
    }
}

#Preview {
    ContentCardGrid(data: [
        DisplayableTextValue(id: "2", description: "int number", value: 123),
        DisplayableTextValue(id: "1", description: "text", value: "📖 Value"),
        DisplayableTextValue(id: "3", description: "float number", value: 1.2393),
        DisplayableTextValue(id: "4", description: "Array", value: [1,2,4]),
        DisplayableTextValue(id: "5", description: "dictionary", value: ["1":"v"]),
        DisplayableTextValue(id: "5", description: "data", value: Data([0x08, 0x03])),
    ])
}
