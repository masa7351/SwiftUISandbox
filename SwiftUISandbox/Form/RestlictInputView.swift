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
    @State private var number: String = ""
    @ObservedObject private var restrictInput = RestrictInput(5)
    var body: some View {
        Form {
            TextField("input text", text: $restrictInput.myproperty.text)
        }
    }
}

struct MyPropertyStruct {
    var text: String
}

class RestrictInput: ObservableObject {
    @Published var myproperty = MyPropertyStruct(text: "")
    private var canc: AnyCancellable!
    init (_ maxLength: Int) {
        canc = $myproperty
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map { String($0.text.prefix(maxLength)) }
            .sink(receiveValue: {
                self.myproperty.text = $0
            })
    }
    deinit {
        canc.cancel()
    }
}

// MARK: - Preview

struct RestlictInputView_Previews: PreviewProvider {
    static var previews: some View {
        RestlictInputView()
    }
}
