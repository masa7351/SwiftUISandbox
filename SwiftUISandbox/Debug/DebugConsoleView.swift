//
//  DebugConsoleView.swift
//  SwiftUISandbox
//
//  Created by Masanao Imai on 2019/10/12.
//  Copyright © 2019 Masanao Imai. All rights reserved.
//

import SwiftUI

struct DebugConsoleView: View {
    @Binding private var consoleLogs: [String]
    @State private var isOpen: Bool = false
    
    init(console: Binding<[String]>) {
        // https://stackoverflow.com/questions/56973959/swiftui-how-to-implement-a-custom-init-with-binding-variables
        self._consoleLogs = console
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().backgroundColor = UIColor.init(hex: 0xdddddd)
        // https://stackoverflow.com/questions/57128547/swiftui-list-color-background/57158348
        UITableViewCell.appearance().backgroundColor = UIColor.init(hex: 0xdddddd)
    }
    var body: some View {
        Group {
            if isOpen {
                maxWindow
            } else {
                minWindow
            }
        }
    }
    
    var maxWindow: some View {
        VStack {
            HStack {
                Button(action: {
                    self.isOpen.toggle()
                }) {
                    Image(systemName: "tray.and.arrow.down")
                        .font(.title)
                        .foregroundColor(.black)
                }
                .padding()
                Button(action: {
                    self.consoleLogs.removeAll()
                }) {
                    Image(systemName: "trash")
                        .font(.title)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            if consoleLogs.isEmpty {
                List {
                    Text("log is empty.")
                }
            } else {
                List(consoleLogs, id: \.self) { value in
                    Text(value)
                        .lineLimit(Int.max)
                        .fixedSize(horizontal: false, vertical: true)
                    
                }
                .background(Color.init(hex: 0xdddddd))
            }
        }
        .background(Color.init(hex: 0xdddddd))
    }
    
    var minWindow: some View {
        VStack {
            HStack {
                Button(action: {
                    self.isOpen.toggle()
                }) {
                    Image(systemName: "tray.and.arrow.up")
                        .font(.title)
                        .foregroundColor(.black)
                }
                .padding()
                Spacer()
            }
            Spacer()
        }
    }
    
}

// MARK: - Helper

private extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: alpha)
    }
}

private extension Color {
    init(hex: Int, alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(
            .sRGB,
            red: components.R,
            green: components.G,
            blue: components.B,
            opacity: alpha
        )
    }
}


// MARK: - Preview

struct DeubugTestView: View {
    @State var console = [String]()
    var body: some View {
        ZStack {
            Button(action: {
                self.console.insert("インクリメントボタンタップ  \(Date())\n", at: 0)
                
            }) {
                Text("インクリメントボタン")
            }
            DebugConsoleView(console: $console)
        }
    }
}

struct DebugConsoleView_Previews: PreviewProvider {
    static var previews: some View {
        DeubugTestView()
    }
}
