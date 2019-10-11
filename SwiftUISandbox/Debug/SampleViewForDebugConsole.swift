//
//  SampleViewForDebugConsole.swift
//  SwiftUISandbox
//
//  Created by Masanao Imai on 2019/10/12.
//  Copyright © 2019 Masanao Imai. All rights reserved.
//

import SwiftUI

struct SampleViewForDebugConsole: View {
    @State var console = [String]()

    var body: some View {
        ZStack {
            DebugConsoleView(console: $console)
            Button(action: {
                self.console.insert("インクリメントボタンタップ  \(Date())\n", at: 0)
//                self.console = "インクリメントボタンタップ  \(Date())\n" + self.console
                
            }) {
                Text("インクリメントボタン")
            }
        }
    }
}

struct SampleViewForDebugConsole_Previews: PreviewProvider {
    static var previews: some View {
        SampleViewForDebugConsole()
    }
}
