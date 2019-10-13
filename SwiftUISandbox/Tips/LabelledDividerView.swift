//
//  LabelledDividerView.swift
//  SwiftUISandbox
//
//  Created by Masanao Imai on 2019/10/13.
//  Copyright © 2019 Masanao Imai. All rights reserved.
//
// original code is
// https://stackoverflow.com/questions/56619043/show-line-separator-view-in-swiftui/57576694#57576694
import SwiftUI

struct LabelledDividerView: View {
    var body: some View {
        VStack {

            Text("Text1").font(.title)

            LabelledDivider(label: "or")

            Text("Text2").font(.title)

            LabelledDivider(label: "or")
                .modifier(ButtonStyle(color: .yellow, enabled: { true } ))

            Text("Text3").font(.title)

            LabelledDivider(label: "or")
            .buttonStyleEmerald(enabled: {true})

            Text("Text4").font(.title)

            LabelledDivider(label: "or")
            .buttonStyleSaphire(enabled: {true})

        }.padding(20)
    }
}

private struct LabelledDivider: View {

    let label: String
    let horizontalPadding: CGFloat
    let color: Color

    init(label: String, horizontalPadding: CGFloat = 20, color: Color = .gray) {
        self.label = label
        self.horizontalPadding = horizontalPadding
        self.color = color
    }

    var body: some View {
        HStack {
            line
            Text(label).foregroundColor(color)
            line
        }
    }

    var line: some View {
        VStack { Divider().background(color) }.padding(horizontalPadding)
    }
}

private struct ButtonStyle: ViewModifier {

    private let color: Color
    private let enabled: () -> Bool
    init(color: Color, enabled: @escaping () -> Bool = { true }) {
        self.color = color
        self.enabled = enabled
    }

    dynamic func body(content: Content) -> some View {
        content
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .foregroundColor(Color.white)
            .background(enabled() ? color : Color.black)
            .cornerRadius(5)
    }
}

private extension View {
    dynamic func buttonStyleEmerald(enabled: @escaping () -> Bool = { true }) -> some View {
        ModifiedContent(content: self, modifier: ButtonStyle(color: Color.gray, enabled: enabled))
    }

    dynamic func buttonStyleSaphire(enabled: @escaping () -> Bool = { true }) -> some View {
        ModifiedContent(content: self, modifier: ButtonStyle(color: Color.gray, enabled: enabled))
    }

}

// MARK: - Preview

struct LabelledDividerView_Previews: PreviewProvider {
    static var previews: some View {
        LabelledDividerView()
    }
}
