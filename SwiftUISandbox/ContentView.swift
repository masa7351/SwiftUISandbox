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
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: StateAnotationView(), label: { Text("@Stateの動作確認") })
                NavigationLink(destination: GeometryRenderSamplesView(), label: { Text("GeometryRenderの動作確認") })
            }.navigationBarTitle(Text("メニュー"), displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
