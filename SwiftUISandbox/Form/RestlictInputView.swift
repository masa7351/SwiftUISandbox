//
//  RestlictInputView.swift
//  SwiftUISandbox
//
//  Created by Masanao Imai on 2019/10/12.
//  Copyright © 2019 Masanao Imai. All rights reserved.
//

import SwiftUI
import Combine
struct RestlictInputView: View {
    @ObservedObject private var restrictInput = RestrictInput(5)
    @State var showClearButton = true
    var body: some View {
        Form {
            TextField("input text", text: $restrictInput.text, onEditingChanged: { editing in
                self.showClearButton = editing
            }, onCommit: {
                self.showClearButton = false
            })
            .modifier( ClearButton(text: $restrictInput.text, visible: $showClearButton))
        }
    }
}

// https://stackoverflow.com/questions/57922766/how-to-use-combine-on-a-swiftui-view
class RestrictInput: ObservableObject {
    @Published var text = ""
    private var canc: AnyCancellable!
    init (_ maxLength: Int) {
        canc = $text
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map { String($0.prefix(maxLength)) }
            .assign(to: \.text, on: self)
    }
    deinit {
        canc.cancel()
    }
}

// https://stackoverflow.com/questions/58200555/swiftui-add-clearbutton-to-textfielda
struct ClearButton: ViewModifier {
    @Binding var text: String
    @Binding var visible: Bool
    public func body(content: Content) -> some View {
        HStack {
            content
            Image(systemName: "multiply.circle.fill")
                .foregroundColor(.secondary)
                .opacity(visible ? 1 : 0)
                .onTapGesture {
                    self.text = ""
                }
            // If you need to reaction. change onTapGesture to button action.
//            Button(action: {
//                self.text = ""
//            }) {
//                Image(systemName: "multiply.circle.fill")
//                    .foregroundColor(.secondary)
//                    .opacity(visible ? 1 : 0)
//            }
        }
    }
}
// MARK: - Preview

struct RestlictInputView_Previews: PreviewProvider {
    static var previews: some View {
        RestlictInputView()
    }
}
