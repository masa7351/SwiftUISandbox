//
//  GeometryRenderFirstView.swift
//  SwiftUISandbox
//
//  Created by Masanao Imai on 2019/10/09.
//  Copyright © 2019 Masanao Imai. All rights reserved.
//

import SwiftUI

/// GeometryRenderの検証その1
struct GeometryRenderFirstView: View {
    var body: some View {
        noneGeometryRenderFrame
//        noneFrame
//        specifiedOnlyOutsideFrame
//        specifiedFrame
    }
    
    /// GeometryReader未使用
    var noneGeometryRenderFrame: some View {
        ScrollView(.vertical, showsIndicators: false) {
            HStack(spacing: 0) {
                Text("Left")
                    .frame(width: UIScreen.main.bounds.width / 2, height: 200)
                    .background(Color.green)
                Text("Right")
                    .frame(width: UIScreen.main.bounds.width / 2, height: 200)
                    .background(Color.blue)
            }
//            .frame(width: UIScreen.main.bounds.width, height: 200)
//            Rectangle().frame(width: UIScreen.main.bounds.width, height: 200, alignment: .leading)
//                .foregroundColor(.green)
            Rectangle().frame(width: UIScreen.main.bounds.width, height: 200, alignment: .leading)
                .foregroundColor(.yellow)
        }
    }

    
    /// GeometryReaderの内側のみで高さ指定
    var noneFrame: some View {
        ScrollView(.vertical, showsIndicators: false) {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    Text("Left")
                        .frame(width: geometry.size.width / 2, height: 200)
                        .background(Color.green)
                    Text("Right")
                        .frame(width: geometry.size.width / 2, height: 200)
                        .background(Color.blue)
                }
            }
            Rectangle().frame(width: UIScreen.main.bounds.width, height: 200, alignment: .leading)
                .foregroundColor(.yellow)
        }.padding(.vertical, 0)
    }
    
    /// GeometryReaderの外側でのみ高さ指定
    var specifiedOnlyOutsideFrame: some View {
        ScrollView(.vertical, showsIndicators: false) {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    Text("Left")
                        .frame(width: geometry.size.width / 2)
                        .background(Color.green)
                    Text("Right")
                        .frame(width: geometry.size.width / 2)
                        .background(Color.blue)
                }
            }
            .frame(height: 200, alignment: .leading)
            Rectangle().frame(width: UIScreen.main.bounds.width, height: 200, alignment: .leading)
                .foregroundColor(.yellow)
        }
    }
    
    /// GeometryReaderの内側+外側でそれぞれ高さ指定
    var specifiedFrame: some View {
        ScrollView(.vertical, showsIndicators: false) {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    Text("Left")
                        .frame(width: geometry.size.width / 2, height: 200)
                        .background(Color.green)
                    Text("Right")
                        .frame(width: geometry.size.width / 2, height: 200)
                        .background(Color.blue)
                }
            }
            .frame(height: 200, alignment: .leading)
            Rectangle().frame(width: UIScreen.main.bounds.width, height: 200, alignment: .leading)
                .foregroundColor(.yellow)
        }
    }


}

struct GeometryRenderFirstView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryRenderFirstView()
    }
}