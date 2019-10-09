import UIKit
import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    var body: some View {
        GeometryReader { metrics in
            VStack(spacing: 0) {
                Color.red.frame(height: metrics.size.height * 0.43)
                Color.green.frame(height: metrics.size.height * 0.37)
                Color.yellow
            }
        }
    }
}

struct DivisionView: View {
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Text("Left")
                    .frame(width: geometry.size.width / 2, height: 50)
                    .background(Color.green)
                Text("Right")
                    .frame(width: geometry.size.width / 2, height: 50)
                    .background(Color.blue)
                }
        }
    }
}

struct StickyNoteSamplesView: View {
    var body: some View {
        Group {
            Text("Hello World!")
                .frame(width: 120, height: 120)
                .background(StickyNoteView())

            Spacer().frame(height: 10)
            
            Text("GeometryRenderのお勉強。これをマスターすると実現できることが広がりそう。")
                .frame(width: 200, height: 200)
                .lineLimit(10)
                .fixedSize(horizontal: true, vertical: false)
                .background(StickyNoteView())
        }
    }
}

struct StickyNoteView: View {
    var color: Color = .green
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    let w = geometry.size.width
                    let h = geometry.size.height
                    let m = min(w/5, h/5)
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: 0, y: h))
                    path.addLine(to: CGPoint(x: w-m, y: h))
                    path.addLine(to: CGPoint(x: w, y: h-m))
                    path.addLine(to: CGPoint(x: w, y: 0))
                    path.addLine(to: CGPoint(x: 0, y: 0))
                }
                .fill(self.color)
                Path { path in
                    let w = geometry.size.width
                    let h = geometry.size.height
                    let m = min(w/5, h/5)
                    path.move(to: CGPoint(x: w-m, y: h))
                    path.addLine(to: CGPoint(x: w-m, y: h-m))
                    path.addLine(to: CGPoint(x: w, y: h-m))
                    path.addLine(to: CGPoint(x: w-m, y: h))
                }
                .fill(Color.black).opacity(0.4)
            }
        }
    }
}



//PlaygroundPage.current.liveView = UIHostingController(rootView: ContentView())

//PlaygroundPage.current.liveView = UIHostingController(rootView: DivisionView())

PlaygroundPage.current.liveView = UIHostingController(rootView: StickyNoteSamplesView())
