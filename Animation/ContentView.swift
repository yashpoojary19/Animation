//
//  ContentView.swift
//  Animation
//
//  Created by Yash Poojary on 23/09/21.
//

import SwiftUI


struct CornerRotateModifier: ViewModifier {
    
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}


extension AnyTransition {
    static var pivot: AnyTransition{
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
        
    }
    
}




struct ContentView: View {
    
    @State private var isShowingRed = false
    
    var body: some View {
        VStack {
            Button("Tap me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }
            
            
            if isShowingRed {
                Color.red
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
                   
            }
        
        }
        
    }
    
}









struct SecondaryView: View {
    
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { index in
                Text(String(letters[index]))
                    .padding(5)
                    .font(.title)
                    .background( enabled ? Color.blue : Color.red)
                    .offset(dragAmount)
                    .animation(Animation.default.delay(Double(index) / 20 ))
            }
        }
        .gesture(
            DragGesture()
                .onChanged {dragAmount = $0.translation}
                .onEnded {
                    _ in
                    
                    dragAmount = .zero
                    enabled.toggle()
                }
        )
     
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

