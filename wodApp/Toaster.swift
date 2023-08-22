//
//  Toaster.swift
//  wodApp
//
//  Created by 최최광현 on 2023/08/22.
//

import SwiftUI

struct Toaster: ViewModifier {
    private let message: String
    private let backgroundColor: Color
    private let textColor: Color
    @Binding var showMessage: Bool
    
    public init(message: String,
                showMessage: Binding<Bool>,
                backgroundColor: Color, textColor: Color) {
        self.message = message
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self._showMessage = showMessage
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if showMessage {
                VStack {
                    Spacer()
                    Spacer()
                    Text(message)
                        .padding()
                        .foregroundColor(textColor)
                        .background(backgroundColor.opacity(0.8))
                        .cornerRadius(10)
                        .clipped()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                showMessage.toggle()
                            }
                        }
                    Spacer()
                }
            }
        }
    }
}

public extension View {
    func toast(isPresented: Binding<Bool>,
               message: String,
               backgroundColor: Color = .black,
               textColor: Color = .white) -> some View {
        self.modifier(Toaster(message: message,
                              showMessage: isPresented,
                              backgroundColor: backgroundColor,
                              textColor: textColor))
    }
}

struct Toaster_Previews: PreviewProvider {
    static var previews: some View {
        Color.red
            .toast(isPresented: .constant(true), message: "Hello world!!")
    }
}
