//
//  ContentView.swift
//  SwiftUISandbox
//
//  Created by Masanao Imai on 2019/10/03.
//  Copyright © 2019 Masanao Imai. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State var isShow = false
    @State var count: Int = 0
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("@Stateカウンター:\(self.count)")
            Button(action: {self.isShow.toggle()}) {
                Text("sheetを使い画面を開く")
            }.sheet(isPresented: $isShow) {
                NavigationView {
                    AnotherView(bCount: self.$count)
                }
            }
            Button(action: {
                let window = UIApplication.shared.windows.first
                let vc = UIHostingController(rootView: NavigationView { AnotherView(bCount: self.$count) })
                window?.rootViewController?.present(vc, animated: true)
            }) {
                Text("modalとして画面を開く")
            }
        }
    }
}

private struct AnotherView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var bCount: Int
    @State var sCount: Int = 0
    @ObservedObject var state = CounterState()

    var body: some View {
        Form {
            Section {
                Text("@Binding カウンター:\(self.bCount)")
                Button(action: { self.bCount += 1 }) {
                    Text("カウントアップ")
                }
            }
            Section {
                Text("@State カウンター:\(self.sCount)")
                Button(action: { self.sCount += 1 }) {
                    Text("カウントアップ")
                }
            }
            Section {
                Text("@ObservableObject カウンター:\(self.state.count)")
                Button(action: { self.state.count += 1 }) {
                    Text("カウントアップ")
                }
            }
            Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                Text("CloseButton")
            }
        }.navigationBarTitle("カウントアップ")
    }
}

final class CounterState: ObservableObject {
    @Published var count: Int = 0
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
