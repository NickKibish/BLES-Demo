//
//  ValueRepresentableView.swift
//  BLES-Demo
//
//  Created by Nick Kibysh on 26/09/2023.
//

import SwiftUI

struct ContentCardView: View {
    let value: Displayable?
    
    var body: some View {
        if let v = value {
            switch v {
            case let t as DisplayableText:
                TextCard(text: t)
            default:
                EmptyView()
            }
        } else {
            EmptyView()
        }
    }
}

#if DEBUG
private struct TR: DisplayableText {
    let t: String
    var description: String { t }
}

#endif

#Preview {
    List {
        ContentCardView(value: nil)
        ContentCardView(value: TR(t: "Hello"))
    }
}
