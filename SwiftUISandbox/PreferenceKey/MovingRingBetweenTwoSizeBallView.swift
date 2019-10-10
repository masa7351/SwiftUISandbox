//
//  MovingRingBetweenTwoSizeBallView.swift
//  SwiftUISandbox
//
//  Created by 今井真尚 on 2019/10/10.
//  Copyright © 2019 Masanao Imai. All rights reserved.
//

import SwiftUI

// MARK: - Body

// https://qiita.com/takaf51/items/de86221493f313ebfc3c
// のコードを元にコンパイルエラーを解消したもの。
// tapAction → onTapGesture に変更
// 元記事はこちらと思われる
// https://swiftui-lab.com/communicating-with-the-view-tree-part-1/
struct MovingRingBetweenTwoSizeBallView: View {

    @State private var activeIdx: Int = 0
    @State private var rects: [CGRect] = Array<CGRect>(repeating: CGRect(), count: 2)
    // TODO: 初期表示時&画面回転時に円がアニメーションをさせないようにするためのフラグ
    // 画面回転することで@Stateが初期化されるのは深堀りしたいところ。
    @State var isStarted: Bool = false

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

            // 円の外縁
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

// MARK: - PreferenceKey

// PerferenceDataは、Equatableに準拠する必要がある
struct PreferenceData: Equatable {
    let idx: Int
    var rect: CGRect
}

// 親Viewが参照する値
struct CirclePreferenceKey: PreferenceKey {
    // 親Viewに参照させるエイリアス
    typealias Value = [PreferenceData]
    // PreferenceKeyに値が設定されていない場合のデフォルト値
    static var defaultValue: [PreferenceData] = []
    // 親Viewはこのreduce functionを通じて値を取得する
    static func reduce(value: inout [PreferenceData], nextValue: () -> [PreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}

// MARK: - Preview

struct MovingRingBetweenTwoSizeBallView_Previews: PreviewProvider {
    static var previews: some View {
        MovingRingBetweenTwoSizeBallView()
    }
}
