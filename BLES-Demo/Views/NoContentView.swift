//
//  NoContentView.swift
//  BLES-Demo
//
//  Created by Nick Kibysh on 20/09/2023.
//

import SwiftUI

struct NoContentView<T: View>: View {
    let image: Image
    let title: Text
    let message: Text
    let actionButton: Button<T>
    
    init(image: Image, title: Text, message: Text, action: Button<T>) {
        self.image = image
        self.title = title
        self.message = message
        self.actionButton = action
    }
    
    init(systemName: String, title: String, message: String, actionLabel: () -> T, action: @escaping () -> ()) {
        self.image = Image(systemName: systemName)
        self.title = Text(title)
        self.message = Text(message)
        self.actionButton = Button(action: action, label: actionLabel)
    }
    
    var body: some View {
        VStack {
            image
                .renderingMode(.template)
                .resizable()
                .foregroundColor(.secondary)
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                
            title
                .font(.title)
                .foregroundStyle(.secondary)
                
            message
                .foregroundStyle(.secondary)
            
            actionButton
                .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    NoContentView(
        systemName: "network",
        title: "Hello World",
        message: "Message to the world",
        actionLabel: {
            Text("Say HI!")
        }, action: {
            print("hi")
        })
}
