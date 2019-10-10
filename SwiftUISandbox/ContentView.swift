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
                Section(header: Text("Basic")) {
                    NavigationLink(destination: StateAnotationView(), label: { Text("@Stateの動作確認") })
                    NavigationLink(destination: BindingInteractiveView(), label: { Text("@Bindingを活用したインタラクティブUIのサンプル") })
                }
                Section(header: Text("PreferenceKey")){
                    NavigationLink(destination: MovingRingBetweenTwoSizeBallView(), label: { Text("@PreferenceKeyのサンプル") })
                }
                Section(header: Text("GeometryReader")){
                    NavigationLink(destination: GeometryReaderSamplesView(), label: { Text("GeometryReaderの動作確認サンプル集") })
                    NavigationLink(destination: GeometryReaderFirstView(), label: { Text("GeometryReaderの動作確認サンプル1") })
                    NavigationLink(destination: GeometryReaderPersentDivisionView(), label: { Text("3色のスタックで背景を表現するサンプル") })
                }
                Section(header: Text("Hack")){
                    NavigationLink(destination: ScrollViewRemoveSpaceView(), label: { Text("ScrollViewの要素間のスペースを削る") })
                }
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
