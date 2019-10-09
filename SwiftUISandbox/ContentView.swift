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
                NavigationLink(destination: GeometryRenderSamplesView(), label: { Text("GeometryRenderの動作確認サンプル集") })
                NavigationLink(destination: GeometryRenderFirstView(), label: { Text("GeometryRenderの動作確認サンプル1") })
                NavigationLink(destination: ScrollViewRemoveSpaceView(), label: { Text("ScrollViewの要素間のスペースを削る") })
                NavigationLink(destination: GeometryRenderPersentDivisionView(), label: { Text("3色のスタックで背景を表現するサンプル") })

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
