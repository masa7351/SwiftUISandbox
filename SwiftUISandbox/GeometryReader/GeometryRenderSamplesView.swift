//
//  GeometryRenderSamplesView.swift
//  SwiftUISandbox
//
//  Created by 今井真尚 on 2019/10/08.
//  Copyright © 2019 Masanao Imai. All rights reserved.
//

import SwiftUI

struct GeometryRenderSamplesView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            halfDivision
                .frame(height: 50) // GeometryReader の内側だけではなく、外側でも高さ指定しないとstickyNotesと重なってしまう
            stickyNotes
            horitontalBalls
            cardList
        }
        .navigationBarTitle("GeometryRender Lab")
    }
    
    // https://www.hackingwithswift.com/quick-start/swiftui/how-to-provide-relative-sizes-using-geometryreader
    var halfDivision: some View {
        // OK
        // why is Okay that hstack set inside of geometryReader?
        // Answer:
        //  if you wanted two views to take up half the available width on the screen,
        // this wouldn’t be possible using hard-coded values because we don’t know ahead of time
        // what the screen width will be.
        // To solve this, GeometryReader provides us with an input value telling us the width and height we have available, and we can then use that with whatever calculations we need
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Text("Left")
                    .frame(width: geometry.size.width / 2, height: 50)
                    .background(Color.green)
                Text("Right")
                    .frame(width: geometry.size.width / 2, height: 50)
                    .background(Color.blue)
                }
        }
        
        // NG
//        HStack(spacing: 0) {
//            GeometryReader { geometry in
//                Text("Left")
//                    .frame(width: geometry.size.width / 2, height: 50)
//                    .background(Color.green)
//                Text("Right")
//                    .frame(width: geometry.size.width / 2, height: 50)
//                    .background(Color.blue)
//            }
//        }
    }
    
    var stickyNotes: some View {
        Group {
            Text("Hello World!")
                .frame(width: 120, height: 120)
                .background(StickyNoteView())

            Spacer().frame(height: 10)
            
            Text("GeometryRenderのお勉強。これを活用できるとやれることの幅が広がりそう。")
                .frame(width: 200, height: 200)
//                .frame(width: 200)
                .lineLimit(10)
                .fixedSize(horizontal: true, vertical: false)
                .background(StickyNoteView())

        }
    }

    // 水平方向のScrollViewで球体の大きさを変更するアニメーション
    // ※offsetの定義を省略するためにオリジナルのものから少しロジックを改造しております
    // https://qiita.com/takaf51/items/a67db8bbc42a4c82b1f0
    
    let halfScreenWidth = UIScreen.main.bounds.width / 2
    let magnification: CGFloat = 1.8 // 円の拡大倍率

    var horitontalBalls: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0...10, id: \.self) { _ in
                    GeometryReader { geometry in
                        Circle()
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color.red)
                            // ScrollViewのanimationとしてgeometryRenderの利用が可能
                            // geometory.frame(in: .global).midXで円のx座標の中心点を取得し、
                            // 円が画面X軸上の真んに来た時にmagnificationで指定した倍率のサイズの
                            // 最大にして、左右にずれるほど小さく（最小値は１倍）なるようにサイズを指定
                            //
                            // 円がセンターの場合は、 abs(geometry.frame(in: .global).midX - self.halfScreenWidth)が0となり
                            // 最大値1.8倍で表示する
                            .scaleEffect(
                                max(1,
                                    -abs(geometry.frame(in: .global).midX - self.halfScreenWidth) / self.halfScreenWidth * self.magnification
                                        + self.magnification
                                )
                            )
                        }
                    .frame(width: 100, height: self.magnification * 100)
                    .padding()
                }
            }
        }
    }
    
    
    var cardList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(0...30, id: \.self) { value in
                    GeometryReader { geometry in
                        CardView(message: "カード\(value)")
                        .rotation3DEffect(Angle(degrees: (Double(geometry.frame(in: .global).minX) - 40) / -15), axis: (x: 0, y: 10, 0))
                    }
                    .frame(width: 140, height: 250)
                }
            }
            .padding(40)
        }
    }
    
}

// https://qiita.com/takaf51/items/a67db8bbc42a4c82b1f0
struct StickyNoteView: View {
    var color: Color = .green
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    let w = geometry.size.width
                    let h = geometry.size.height
                    let m = min(w/5, h/5)
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: 0, y: h))
                    path.addLine(to: CGPoint(x: w-m, y: h))
                    path.addLine(to: CGPoint(x: w, y: h-m))
                    path.addLine(to: CGPoint(x: w, y: 0))
                    path.addLine(to: CGPoint(x: 0, y: 0))
                }
                .fill(self.color)
                Path { path in
                    let w = geometry.size.width
                    let h = geometry.size.height
                    let m = min(w/5, h/5)
                    path.move(to: CGPoint(x: w-m, y: h))
                    path.addLine(to: CGPoint(x: w-m, y: h-m))
                    path.addLine(to: CGPoint(x: w, y: h-m))
                    path.addLine(to: CGPoint(x: w-m, y: h))
                }
                .fill(Color.black).opacity(0.4)
            }
        }
    }
}


struct CardView: View {
    var message: String = ""
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 140, height: 200)
                .foregroundColor(.blue)
                .cornerRadius(15)
            Text(message)
        }
    }
}

// MARK: - Preview

struct GeometryRenderSamplesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GeometryRenderSamplesView()
        }
    }
}
