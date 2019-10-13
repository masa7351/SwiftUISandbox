//
//  HorizontalTabsView.swift
//  SwiftUISandbox
//
//  Created by Masanao Imai on 2019/10/13.
//  Copyright © 2019 Masanao Imai. All rights reserved.
//
// original code is
// https://stackoverflow.com/questions/56505043/how-to-make-view-the-size-of-another-view-in-swiftui/56661706#56661706
import SwiftUI

extension HorizontalAlignment {
    private enum UnderlineLeading: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.leading]
        }
    }

    static let underlineLeading = HorizontalAlignment(UnderlineLeading.self)
}

struct WidthPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat(0)
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


struct HorizontalTabsView : View {

    @State private var activeIdx: Int = 0
    @State private var w: [CGFloat] = [0, 0, 0, 0]

    var body: some View {
        return VStack(alignment: .underlineLeading) {
            HStack {
                Text("Tweets")
                    .modifier(MagicStuff(activeIdx: $activeIdx, idx: 0))
                    .background(TextGeometry())
                    .onPreferenceChange(WidthPreferenceKey.self, perform: { self.w[0] = $0 })

                Spacer()

                Text("Tweets & Replies")
                    .modifier(MagicStuff(activeIdx: $activeIdx, idx: 1))
                    .background(TextGeometry())
                    .onPreferenceChange(WidthPreferenceKey.self, perform: { self.w[1] = $0 })

                Spacer()

                Text("Media")
                    .modifier(MagicStuff(activeIdx: $activeIdx, idx: 2))
                    .background(TextGeometry())
                    .onPreferenceChange(WidthPreferenceKey.self, perform: { self.w[2] = $0 })

                Spacer()

                Text("Likes")
                    .modifier(MagicStuff(activeIdx: $activeIdx, idx: 3))
                    .background(TextGeometry())
                    .onPreferenceChange(WidthPreferenceKey.self, perform: { self.w[3] = $0 })

                }
                .frame(height: 20)
                .padding(.horizontal, 10)
            
            Rectangle()
                .alignmentGuide(.underlineLeading) { d in d[.leading]  }
                .frame(width: w[activeIdx],  height: 2)
                .animation(.default)
        }
    }
}

struct TextGeometry: View {
    var body: some View {
        GeometryReader { geometry in
            return Rectangle()
                .foregroundColor(.clear)
                .preference(key: WidthPreferenceKey.self, value: geometry.size.width)
        }
    }
}

struct MagicStuff: ViewModifier {
    @Binding var activeIdx: Int
    let idx: Int

    func body(content: Content) -> some View {
        Group {
            if activeIdx == idx {
                content.alignmentGuide(.underlineLeading) { d in
                    return d[.leading]
                }.onTapGesture { self.activeIdx = self.idx }

            } else {
                content.onTapGesture { self.activeIdx = self.idx }
            }
        }
    }
}

struct HorizontalTabsView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalTabsView()
    }
}
