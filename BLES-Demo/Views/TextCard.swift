//
//  CaptionedLabel.swift
//  BLES-Demo
//
//  Created by Nick Kibysh on 26/09/2023.
//

import SwiftUI

struct TextCard: View {
    
    let text: DisplayableText
    
    var body: some View {
        Text(text.description)
            .font(.title)
            .fontWeight(.black)
    }
}

#if DEBUG
private struct TR: DisplayableText {
    var description: String {
        text
    }
    
    let text: String
}
#endif

#Preview {
    TextCard(text: TR(text: "Hello World"))
}
