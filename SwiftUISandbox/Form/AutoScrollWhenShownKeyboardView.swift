//
//  AutoScrollWhenShownKeyboardView.swift
//  SwiftUISandbox
//
//  Created by Masanao Imai on 2019/10/13.
//  Copyright © 2019 Masanao Imai. All rights reserved.
//
// https://stackoverflow.com/questions/56491881/move-textfield-up-when-thekeyboard-has-appeared-by-using-swiftui-ios/56721268#56721268
import SwiftUI

/// TODO: キーボード表示時に自動的にスクロールするサンプル
struct AutoScrollWhenShownKeyboardView: View {
    var body: some View {
        VStack {
            Rectangle().frame(height: 500)
            Text(/*@START_MENU_TOKEN@*/"Hello World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct AutoScrollWhenShownKeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        AutoScrollWhenShownKeyboardView()
    }
}
