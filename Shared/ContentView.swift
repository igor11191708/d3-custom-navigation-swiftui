//
//  ContentView.swift
//  Shared
//
//  Created by Igor Shelopaev on 09.06.2022.
//  The link to the code is under the video
//

import SwiftUI

// experimenting with nav link
struct ContentView: View {
    @State var route: Router = .empty

    var body: some View {
        NavigationView {
            VStack {
                Button("go1") { route = .go1 }
                Button("go2") { route = .go2 }
                Button("go3") { route = .go3 }
            }.navigation(route: $route)
        }.navigationViewStyle(.stack)
    }
}

extension View {
    @ViewBuilder
    func navigation(route: Binding<Router>) -> some View {
        if route.wrappedValue != .empty {
            modifier(NavigationModifire(route: route))
        } else { self }
    }
}

// MARK: - define view modifire

struct NavigationModifire: ViewModifier {
    @State var isActive: Bool = true

    @Binding var route: Router

    func body(content: Content) -> some View {
        content
            .background {
                NavigationLink(destination: route.builder, isActive: $isActive) {
                    EmptyView()
                }.hidden()
            }
            .onChange(of: isActive) {
                if $0 == false { route = .empty }
            }
    }
}

// MARK: - Define routes

enum Router {
    case go1
    case go2
    case go3
    case empty

    @ViewBuilder
    var builder: some View {
        switch self {
        case .go1: SubView(text: "go1")
        case .go2: SubView(text: "go2")
        case .go3: SubView(text: "go3")
        default: EmptyView()
        }
    }
}

// MARK: - Define sub view

struct SubView: View {
    let text: String

    var body: some View {
        Text("\(text)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
