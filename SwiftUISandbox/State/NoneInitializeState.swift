//
//  NoneInitializeState.swift
//  SwiftUISandbox
//
//  Created by Masanao Imai on 2019/10/03.
//  Copyright © 2019 Masanao Imai. All rights reserved.
//

import SwiftUI

struct NoneInitializeState: View {
    @State var isShow = false
    var body: some View {
        Button(action: {self.isShow.toggle()}) {
            Text("show another view")
        }.sheet(isPresented: $isShow) {
            AnotherView()
        }
    }
}

private struct AnotherView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var text = ""
    var body: some View {
        VStack {
            TextField("Input changing the @State property", text: $text)
            Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                Text("Dismiss")
            }
        }.padding()
    }
}

struct NoneInitializeState_Previews: PreviewProvider {
    static var previews: some View {
        NoneInitializeState()
    }
}
