//
//  InitializeState2View.swift
//  SwiftUISandbox
//
//  Created by Masanao Imai on 2019/10/03.
//  Copyright © 2019 Masanao Imai. All rights reserved.
//

import SwiftUI
// Redrawing body on every new character due to ObservableObject
struct InitializeState2View: View {
    @State var isShow = false
    var body: some View {
        Button(action: {self.isShow.toggle()}) {
            Text("show another view")
        }.sheet(isPresented: $isShow) {
            InitAnotherView()
        }
    }
}

private class InitAnotherViewState: ObservableObject {
    @Published var text: String = ""
    @Published var wasInitialized = false
}

private struct InitAnotherView: View {
    init() {
        print("Init InitAnotherView")

    }

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var state = InitAnotherViewState()

    var body: some View {
        print("Redrawing InitAnotherView")

        return VStack {
            TextField("Input changing the @State property", text: $state.text)
            Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                Text("Dismiss")
            }
        }.padding()
    }
}

struct InitializeState2View_Previews: PreviewProvider {
    static var previews: some View {
        InitializeState2View()
    }
}
