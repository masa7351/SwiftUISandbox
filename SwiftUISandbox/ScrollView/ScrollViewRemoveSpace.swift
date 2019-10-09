//
//  ScrollViewRemoveSpaceView.swift
//  SwiftUISandbox
//
//  Created by 今井真尚 on 2019/10/09.
//  Copyright © 2019 Masanao Imai. All rights reserved.
//

import SwiftUI

struct ScrollViewRemoveSpaceView: View {
    var body: some View {
//        normalScrollView
//        normalScrollWithOptionsView
        normalScrollWithGeometryView
//        insideVStackView
//        normalVStack
//        spacingZeroVStack
    }
    
    var normalScrollView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: 200)
                .foregroundColor(.yellow)
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: 200)
                .foregroundColor(.green)
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: 200)
                .foregroundColor(.blue)
        }
    }

    var normalScrollWithOptionsView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: 200)
                .foregroundColor(.yellow)
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: 200)
                .foregroundColor(.green)
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: 200)
                .foregroundColor(.blue)
            Rectangle()
            .frame(width: UIScreen.main.bounds.width, height: 200)
            .foregroundColor(.red)
        }
//        .offset(x: 50, y: 100) // ScrollView自体の表示位置調整
            .edgesIgnoringSafeArea(.all)
            .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
    }

        var normalScrollWithGeometryView: some View {
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: false) {
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width, height: 200)
                        .foregroundColor(.yellow)
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width, height: 200)
                        .foregroundColor(.green)
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width, height: 200)
                        .foregroundColor(.blue)
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width, height: 200)
                        .foregroundColor(.red)
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width, height: 200)
                        .foregroundColor(.gray)
                }
                .position(x: geometry.frame(in: .global).midX, y: geometry.frame(in: .global).midY)
                .edgesIgnoringSafeArea(.all)
                // postionとedgesIgnoringSafeAreaの実行順序を変えただけで表示が変わる
            }
        }

    
    /// ScrollViewの内部にVStackのスペース0を指定することで、余白を削ることを実現
    var insideVStackView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            // https://stackoverflow.com/questions/58018633/swiftui-how-to-remove-margin-between-views-in-vstack
            VStack(spacing: 0) {
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: 200)
                    .foregroundColor(.yellow)
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: 200)
                    .foregroundColor(.green)
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: 200)
                    .foregroundColor(.blue)
            }
        }
    }
    
    /// Item間のスペース未指定のVStack
    var normalVStack: some View {
        VStack {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: 200)
                .foregroundColor(.yellow)
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: 200)
                .foregroundColor(.green)
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: 200)
                .foregroundColor(.blue)
            Spacer()
        }
    }
    
    
    /// Item間のスペース0指定のVStack
    var spacingZeroVStack: some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: 200)
                .foregroundColor(.yellow)
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: 200)
                .foregroundColor(.green)
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: 200)
                .foregroundColor(.blue)
            Spacer()
        }
    }

}

struct ScrollViewRemoveSpaceView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewRemoveSpaceView()
    }
}
