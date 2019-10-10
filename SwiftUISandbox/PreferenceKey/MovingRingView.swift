//
//  MovingRingView.swift
//  SwiftUISandbox
//
//  Created by 今井真尚 on 2019/10/10.
//  Copyright © 2019 Masanao Imai. All rights reserved.
//

import SwiftUI

// MARK: - Body

/// 図形の間を青枠がアニメーションしながら移動するサンプル(PreferenceKey学習用サンプル)
struct MovingRingView: View {

    // MARK: - Enum
    
    // オブジェクトの形
    enum ShapeType: Int {
        case circle
        case rectangle
    }
    
    // MARK: - State
    
    @State private var activeIdx: Int = 0
    @State private var rects: [CGRect] = Array<CGRect>(repeating: CGRect(), count: 8)
    // TODO: 初期表示時&画面回転時に円がアニメーションをさせないようにするためのフラグ
    // 画面回転することで@Stateが初期化されるのは深堀りしたいところ。
    @State private var isStarted: Bool = false
    @State private var selectedShapeType: ShapeType = .circle

    var isRectangleShape: Bool {
        selectedShapeType.rawValue == ShapeType.rectangle.rawValue
    }

    var isCircleShape: Bool {
        selectedShapeType.rawValue == ShapeType.circle.rawValue
    }
    
    // MARK: - View
    
    /// 青外枠のView
    /// シェイプシフター(形を変える化け物)のように今選択しているオブジェクトの形になる
    /// これを擬似的に表現させるためZStackで表現していて、表示していないオブジェクトの、Colorをclearにして見えないようにしている
    var shapeshifterView: some View {
        ZStack {
            // 長方形の外枠
            Rectangle()
                .stroke(isRectangleShape ? Color.blue : Color.clear, lineWidth: 5)
                .frame(width: rects[activeIdx].size.width, height: rects[activeIdx].size.height)
                .offset(x: rects[activeIdx].minX , y: rects[activeIdx].minY)
                .animation(.linear(duration: isStarted && isRectangleShape ? 0.5 : 0))
            // 円の外枠
            Circle()
                .stroke(isCircleShape ? Color.blue : Color.clear, lineWidth: 5)
                .frame(width: rects[activeIdx].size.width, height: rects[activeIdx].size.height)
                .offset(x: rects[activeIdx].minX , y: rects[activeIdx].minY)
                // タップによる移動以外(回転、初期表示時)はアニメーションさせないように0としている
                .animation(.linear(duration: isStarted && isCircleShape ? 0.5 : 0))
        }
    }

    /// ビビッドカラーの円、長方形のオブジェクト群
    var variousObjects: some View {
        VStack(spacing: 20) {
            HStack {
                Circle()
                    .fill(Color.green)
                    .frame(width: 100, height: 100)
                    .background(BGCircleView(idx: 0))
                    .onTapGesture {
                        self.isStarted = true
                        self.activeIdx = 0
                        self.selectedShapeType = .circle
                    }

                Circle()
                    .fill(Color.pink)
                    .frame(width: 150, height: 150)
                    .background(BGCircleView(idx: 1))
                    .onTapGesture {
                        self.isStarted = true
                        self.activeIdx = 1
                        self.selectedShapeType = .circle
                     }
            }
            
            HStack {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 50, height: 50)
                    .background(BGCircleView(idx: 2))
                    .onTapGesture {
                        self.isStarted = true
                        self.activeIdx = 2
                        self.selectedShapeType = .circle
                     }
                
                Rectangle()
                    .fill(Color.yellow)
                    .frame(width: 250, height: 100)
                    .background(BGRectangleView(idx: 3))
                    .onTapGesture {
                        self.isStarted = true
                        self.activeIdx = 3
                        self.selectedShapeType = .rectangle
                     }
            }

            HStack {
                Rectangle()
                    .fill(Color.purple)
                    .frame(width: 100, height: 30)
                    .background(BGRectangleView(idx: 4))
                    .onTapGesture {
                        self.isStarted = true
                        self.activeIdx = 4
                        self.selectedShapeType = .rectangle
                     }

                Circle()
                    .fill(Color.gray)
                    .frame(width: 70, height: 70)
                    .background(BGCircleView(idx: 5))
                    .onTapGesture {
                        self.isStarted = true
                        self.activeIdx = 5
                        self.selectedShapeType = .circle
                     }
            }
            
            HStack {
                Circle()
                    .fill(Color.orange)
                    .frame(width: 150, height: 150)
                    .background(BGCircleView(idx: 6))
                    .onTapGesture {
                        self.isStarted = true
                        self.activeIdx = 6
                        self.selectedShapeType = .circle
                     }

                Rectangle()
                    .fill(Color.green)
                    .frame(width: 250, height: 100)
                    .background(BGRectangleView(idx: 7))
                    .onTapGesture {
                        self.isStarted = true
                        self.activeIdx = 7
                        self.selectedShapeType = .rectangle
                     }
            }
        }
    }
    
    // Body部分
    var body: some View {

        ZStack(alignment: .topLeading) {
            // ビビッドカラーの円、長方形のオブジェクト群
            variousObjects
            // onPreferenceChangeはpreferencenのデータが変わるたびにコールされるので、例えば端末が回転して Viewの構成が変わった場合、自動的に値の更新が行われます。
            .onPreferenceChange(EdgePreferenceKey.self) { preference in
                for p in preference {
                    self.rects[p.idx] = p.rect
                }
            }
            // 青枠の円
            shapeshifterView
        }
        .coordinateSpace(name: "myCoordination")
        
    }
    
}

// MARK: - Support View

/// 円の位置＆大きさを調べるための図形(見えないようにColor.clearを指定)
struct BGCircleView: View {
    let idx: Int
    var body: some View {
        GeometryReader { geometry in
            Circle()
                .fill(Color.clear)
                .preference(key: EdgePreferenceKey.self, value: [PreferenceData(idx: self.idx, rect: geometry.frame(in: .named("myCoordination")))])
        }
    }
}

/// 長方形の位置＆大きさを調べるための図形(見えないようにColor.clearを指定)
struct BGRectangleView: View {
    let idx: Int
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.clear)
                .preference(key: EdgePreferenceKey.self, value: [PreferenceData(idx: self.idx, rect: geometry.frame(in: .named("myCoordination")))])
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
struct EdgePreferenceKey: PreferenceKey {
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

struct MovingRingView_Previews: PreviewProvider {
    static var previews: some View {
        MovingRingView()
    }
}
