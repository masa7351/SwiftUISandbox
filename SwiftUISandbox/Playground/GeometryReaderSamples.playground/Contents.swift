import UIKit

//let propHeight = metrics.size.height * 0.43

import SwiftUI

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

import PlaygroundSupport

PlaygroundPage.current.liveView = UIHostingController(rootView: ContentView())
