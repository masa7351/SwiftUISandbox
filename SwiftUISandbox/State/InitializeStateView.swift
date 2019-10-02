//
//  InitializeStateView.swift
//  SwiftUISandbox
//
//  Created by Masanao Imai on 2019/10/03.
//  Copyright © 2019 Masanao Imai. All rights reserved.
//

import SwiftUI
// https://stackoverflow.com/questions/57601684/the-state-property-doesnt-initialization-when-the-view-open-two-times
// The @State lives as long as it can and so is likely being reused between deconstructed views. But one can go around it in several ways.

// Redrawing body only on first initialization due to part-ObservableObject
struct InitializeStateView: View {
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
    @Published var wasInitialized = false
}

private struct InitAnotherView: View {
    init() {
        print("Init InitAnotherView")
    }

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var state = InitAnotherViewState()
    @State var text = ""

    var body: some View {
        print("Redrawing InitAnotherView")

        if !state.wasInitialized {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.text = "hey"
            }
            state.wasInitialized = true
        }

        return VStack {
            TextField("Input changing the @State property", text: $text)
            Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                Text("Dismiss")
            }
        }.padding()
    }
}

struct InitializeStateView_Previews: PreviewProvider {
    static var previews: some View {
        InitializeStateView()
    }
}
