//
//  CanlendarSelectionAnchorView.swift
//  SwiftUISandbox
//
//  Created by 今井真尚 on 2019/10/11.
//  Copyright © 2019 Masanao Imai. All rights reserved.
//
// original code is
// https://swiftui-lab.com/communicating-with-the-view-tree-part-2/
import SwiftUI

struct CanlendarSelectionAnchorView : View {
    
    @State private var activeIdx: Int = 0
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                MonthView(activeMonth: $activeIdx, label: "January", idx: 0)
                MonthView(activeMonth: $activeIdx, label: "February", idx: 1)
                MonthView(activeMonth: $activeIdx, label: "March", idx: 2)
                MonthView(activeMonth: $activeIdx, label: "April", idx: 3)
            }
            
            Spacer()
            
            HStack {
                MonthView(activeMonth: $activeIdx, label: "May", idx: 4)
                MonthView(activeMonth: $activeIdx, label: "June", idx: 5)
                MonthView(activeMonth: $activeIdx, label: "July", idx: 6)
                MonthView(activeMonth: $activeIdx, label: "August", idx: 7)
            }
            
            Spacer()
            
            HStack {
                MonthView(activeMonth: $activeIdx, label: "September", idx: 8)
                MonthView(activeMonth: $activeIdx, label: "October", idx: 9)
                MonthView(activeMonth: $activeIdx, label: "November", idx: 10)
                MonthView(activeMonth: $activeIdx, label: "December", idx: 11)
            }
            
            Spacer()
        }.backgroundPreferenceValue(MyTextPreferenceKey.self) { preferences in
            return GeometryReader { geometry in
                ZStack(alignment: .topLeading) {
                    self.createBorder(geometry, preferences)
                    
                    HStack { Spacer() } // makes the ZStack to expand horizontally
                    VStack { Spacer() } // makes the ZStack to expand vertically
                }.frame(alignment: .topLeading)
            }
        }
    }
    
    //  CGRect
    func createBorder(_ geometry: GeometryProxy, _ preferences: [MyTextPreferenceDataAnchor]) -> some View {
        let p = preferences.first(where: { $0.viewIdx == self.activeIdx })
        let bounds = p != nil ? geometry[p!.bounds] : .zero
        return RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 3.0)
                .foregroundColor(Color.green)
                .frame(width: bounds.size.width, height: bounds.size.height)
                .fixedSize()
                .offset(x: bounds.minX, y: bounds.minY)
                .animation(.easeInOut(duration: 1.0))
    }
    
    // CGPoint
//    func createBorder(_ geometry: GeometryProxy, _ preferences: [MyTextPreferenceDataAnchor]) -> some View {
//        let p = preferences.first(where: { $0.viewIdx == self.activeIdx })
//
//        let aTopLeading = p?.topLeading
//        let aBottomTrailing = p?.bottomTrailing
//
//        let topLeading = aTopLeading != nil ? geometry[aTopLeading!] : .zero
//        let bottomTrailing = aBottomTrailing != nil ? geometry[aBottomTrailing!] : .zero
//
//
//        return RoundedRectangle(cornerRadius: 15)
//            .stroke(lineWidth: 3.0)
//            .foregroundColor(Color.green)
//            .frame(width: bottomTrailing.x - topLeading.x, height: bottomTrailing.y - topLeading.y)
//            .fixedSize()
//            .offset(x: topLeading.x, y: topLeading.y)
//            .animation(.easeInOut(duration: 1.0))
//    }
}

// CGRect
struct MyTextPreferenceDataAnchor {
    let viewIdx: Int
    let bounds: Anchor<CGRect>
}

// CGPoint
//struct MyTextPreferenceDataAnchor {
//    let viewIdx: Int
//    var topLeading: Anchor<CGPoint>? = nil
//    var bottomTrailing: Anchor<CGPoint>? = nil
//}

private struct MyTextPreferenceKey: PreferenceKey {
    typealias Value = [MyTextPreferenceDataAnchor]
    
    static var defaultValue: [MyTextPreferenceDataAnchor] = []
    
    static func reduce(value: inout [MyTextPreferenceDataAnchor], nextValue: () -> [MyTextPreferenceDataAnchor]) {
        value.append(contentsOf: nextValue())
    }
}

private struct MonthView: View {
    @Binding var activeMonth: Int
    let label: String
    let idx: Int
    
    var body: some View {
        Text(label)
            .padding(10)
            // CGRect
            .anchorPreference(key: MyTextPreferenceKey.self, value: .bounds, transform: { [MyTextPreferenceDataAnchor(viewIdx: self.idx, bounds: $0)] })
            // CGPoint
//            .anchorPreference(key: MyTextPreferenceKey.self, value: .topLeading, transform: { [MyTextPreferenceDataAnchor(viewIdx: self.idx, topLeading: $0)] })
//            .transformAnchorPreference(key: MyTextPreferenceKey.self, value: .bottomTrailing, transform: { ( value: inout [MyTextPreferenceDataAnchor], anchor: Anchor<CGPoint>) in
//                value[0].bottomTrailing = anchor
//            })
            
            .onTapGesture { self.activeMonth = self.idx }
    }
}

struct CanlendarSelectionAnchorView_Previews: PreviewProvider {
    static var previews: some View {
        CanlendarSelectionAnchorView()
    }
}
