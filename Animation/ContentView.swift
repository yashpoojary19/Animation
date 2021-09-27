



import SwiftUI




struct CornerPointRotation: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
        
    }
}

extension AnyTransition {
    
    static var pivot: AnyTransition {
        .modifier(active: CornerPointRotation(amount: -90, anchor: .topLeading), identity: CornerPointRotation(amount: 0, anchor: .topLeading))
    }
    
    
}

struct ContentView: View {
    @State private var isShowing = false
    
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    isShowing.toggle()
                }
            }
            
            
            if isShowing {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
