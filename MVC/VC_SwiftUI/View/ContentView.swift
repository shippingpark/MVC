//
//  ContentView.swift
//  VC_SwiftUI
//
//  Created by 박혜운 on 7/21/24.
//

import SwiftUI
import Model
import MVCNetwork

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
