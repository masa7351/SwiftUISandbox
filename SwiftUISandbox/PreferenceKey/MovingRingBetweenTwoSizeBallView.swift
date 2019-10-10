//
//  MovingRingBetweenTwoSizeBallView.swift
//  SwiftUISandbox
//
//  Created by 今井真尚 on 2019/10/10.
//  Copyright © 2019 Masanao Imai. All rights reserved.
//

import SwiftUI

// MARK: - PreferenceKey

struct PreferenceData: Equatable {
    let idx: Int
    var rect: CGRect
}

struct CirclePreferenceKey: PreferenceKey {
    typealias Value = [PreferenceData]

    static var defaultValue: [PreferenceData] = []

    static func reduce(value: inout [PreferenceData], nextValue: () -> [PreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}

// MARK: - Body

// https://qiita.com/takaf51/items/de86221493f313ebfc3c
// のコードを元にコンパイルエラーを解消したもの。
// tapAction → onTapGesture に変更
struct MovingRingBetweenTwoSizeBallView: View {

    @State private var activeIdx: Int = 0
    @State private var rects: [CGRect] = Array<CGRect>(repeating: CGRect(), count: 2)
    @State var isStarted:Bool = false

    var body: some View {

        ZStack(alignment: .topLeading) {
            HStack {
                Circle()
                    .fill(Color.green)
                    .frame(width: 100, height: 100)
                    .background(BGView(idx: 0))
                    .onTapGesture {
                        self.isStarted = true
                        self.activeIdx = 0
                    }
                    .padding()
                Circle()
                    .fill(Color.pink)
                    .frame(width: 150, height: 150)
                    .background(BGView(idx: 1))
                    .onTapGesture {
                        self.isStarted = true
                        self.activeIdx = 1
                     }
                     .padding()
            }
            // onPreferenceChangeはpreferencenのデータが変わるたびにコールされるので、例えば端末が回転して Viewの構成が変わった場合、自動的に値の更新が行われます。
            .onPreferenceChange(CirclePreferenceKey.self) { preference in
                for p in preference {
                    self.rects[p.idx] = p.rect
                }
            }

            // 外縁
            Circle()
                .stroke(Color.blue, lineWidth: 10)
                .frame(width: rects[activeIdx].size.width, height: rects[activeIdx].size.height)
                .offset(x: rects[activeIdx].minX , y: rects[activeIdx].minY)
                // タップによる移動以外(回転、初期表示時)はアニメーションさせないように0としている
                .animation(.linear(duration: isStarted ? 0.5 : 0))

        }.coordinateSpace(name: "myCoordination")
    }
}

struct BGView: View {
    let idx: Int
    var body: some View {
        GeometryReader { geometry in
            Circle()
                .fill(Color.clear)
                .preference(key: CirclePreferenceKey.self, value: [PreferenceData(idx: self.idx, rect: geometry.frame(in: .named("myCoordination")))])
        }
    }
}

// MARK: - Preview

struct MovingRingBetweenTwoSizeBallView_Previews: PreviewProvider {
    static var previews: some View {
        MovingRingBetweenTwoSizeBallView()
    }
}
