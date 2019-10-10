//
//  GeometryReaderPersentDivisionView.swift
//  SwiftUISandbox
//
//  Created by 今井真尚 on 2019/10/09.
//  Copyright © 2019 Masanao Imai. All rights reserved.
//

import SwiftUI

/// 3色のスタックで背景を表現するサンプル
/// https://stackoverflow.com/questions/57243677/proportional-height-or-width-in-swiftui
struct GeometryReaderPersentDivisionView: View {
    var body: some View {
        // 横のスタック
//         GeometryReader { metrics in
//             HStack(spacing: 0) {
//                 Color.red.frame(width: metrics.size.width * 0.43)
//                 Color.green.frame(width: metrics.size.width * 0.37)
//                 Color.yellow
//             }
//         }.edgesIgnoringSafeArea(.all)
        // 縦のスタック
        GeometryReader { metrics in
            VStack(spacing: 0) {
                Color.red.frame(height: metrics.size.height * 0.43)
                Color.green.frame(height: metrics.size.height * 0.37)
                Color.yellow
            }
        }
     }
}

struct GeometryReaderPersentDivisionView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderPersentDivisionView()
    }
}
