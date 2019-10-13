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
    @State var anyText: String = ""
    @State var customText: String = ""
    var isEnabled: Bool {
        restrictInput.text.count > 0
    }
    var body: some View {
        Form {
            Section {
                TextField("input text", text: $restrictInput.text, onEditingChanged: { editing in
                    self.showClearButton = editing
                }, onCommit: {
                    self.showClearButton = false
                })
                    .modifier( ClearButton(text: $restrictInput.text, visible: $showClearButton))
            }
            Section {
                CustomTextField(text: $customText, isFirstResponder: true)
                .frame(width: 300, height: 50)
                .background(Color.red)
            }
            
            Section {
                TextField("custom stype", text: $anyText)
                .modifier(CustomStyle())
            }
            Section {
                // highlight problem when button is disabled.
//                Button(action: submit) { Text("Submit").disabled(!self.isEnabled) }
                if self.isEnabled {
                    Button(action: submit) { Text("Submit") }
                } else {
                    Text("Submit").foregroundColor(.gray)
                }
            }
            
        }
        
//        // shrink only a text filed
//        Form {
//            HStack {
//                Spacer().frame(width: 30)
//                TextField("input text", text: $restrictInput.text)
//                Spacer().frame(width: 30)
//            }
//        }

        // shrink a whole form area
//        HStack {
//            Spacer().frame(width: 30)
//            Form {
//                TextField("input text", text: $restrictInput.text)
//            }
//            Spacer().frame(width: 30)
//        }

        
    }
    
    func submit() -> Void {
        guard self.isEnabled else {
            return
        }
        print("click submit button")
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

// this is not good.
// I guess that Apple prohibit UI custom.
private struct CustomStyle: ViewModifier {
    public func body(content: Content) -> some View {
        return content
            .padding()
            .foregroundColor(.green)
            .background(Color.yellow)
    }
}

// https://stackoverflow.com/questions/56507839/how-to-make-textfield-become-first-responder/56508132#56508132
private struct CustomTextField: UIViewRepresentable {

    class Coordinator: NSObject, UITextFieldDelegate {

        @Binding var text: String
        var didBecomeFirstResponder = false

        init(text: Binding<String>) {
            _text = text
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }

    }

    @Binding var text: String
    var isFirstResponder: Bool = false

    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        return textField
    }

    func makeCoordinator() -> CustomTextField.Coordinator {
        return Coordinator(text: $text)
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}

// MARK: - Preview

struct RestlictInputView_Previews: PreviewProvider {
    static var previews: some View {
        RestlictInputView()
    }
}
