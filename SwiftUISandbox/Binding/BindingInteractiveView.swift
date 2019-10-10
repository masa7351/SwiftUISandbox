//
//  BindingInteractiveView.swift
//  SwiftUISandbox
//
//  Created by 今井真尚 on 2019/10/10.
//  Copyright © 2019 Masanao Imai. All rights reserved.
//

import SwiftUI

// MARK: - Styles

struct DefaultButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .font(Font.system(size: 17.0))
            .foregroundColor(.blue)
            .background(Color.white)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.blue, lineWidth: 3))
    }
}

struct DisableButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .font(Font.system(size: 17.0))
            .foregroundColor(.gray)
            .background(Color.white)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.gray, lineWidth: 3))
    }
}

extension View {
    func defaultButtonStyle() -> some View {
        self.modifier(DefaultButtonStyle())
    }
    func disableButtonStyle() -> some View {
        self.modifier(DisableButtonStyle())
    }
}

// MARK: - Body

/// @Bindingを活用したインタラクティブUIのサンプル
struct BindingInteractiveView: View {
    @State var selectedIndex = 0
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                BindingButton(selectedIndex: $selectedIndex, title: "ボタン1", index: 0)
                BindingButton(selectedIndex: $selectedIndex, title: "ボタン2", index: 2)
                BindingButton(selectedIndex: $selectedIndex, title: "ボタン3", index: 3)
            }
            HStack(spacing: 20) {
                BindingButton(selectedIndex: $selectedIndex, title: "ボタン4", index: 4)
                BindingButton(selectedIndex: $selectedIndex, title: "ボタン5", index: 5)
                BindingButton(selectedIndex: $selectedIndex, title: "ボタン6", index: 6)
            }
        }
    }
}

struct BindingButton: View {
    @Binding var selectedIndex: Int
    let title: String
    let index: Int
    var body: some View {
        Button(action: {
            self.selectedIndex = self.index
        }, label: {
            if self.selectedIndex == self.index {
                Text(title).defaultButtonStyle()
            } else {
                Text(title).disableButtonStyle()
            }
        })
    }
}

// MARK: - Preview

struct BindingInteractiveView_Previews: PreviewProvider {
    static var previews: some View {
        BindingInteractiveView()
    }
}
