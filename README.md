# Custom navigation swiftui


### Experimenting with navigation link. if you find this idea interesting you can expend it into more powerful solution.


- The result navigaion definition
```swift
    var body: some View {
        NavigationView{
            VStack{
                Button("go1") { route = .go1}
                Button("go2") { route = .go2}
                Button("go3") { route = .go3}
            }.navigation(route: $route)
        }.navigationViewStyle(.stack)
    }
```

- Define sub view
```swift
struct SubView: View {

    let text: String

    var body: some View {
        Text("\(text)")
    }
}
```

- Define routes
```swift
enum Router {
    case go1
    case go2
    case go3
    case empty

    @ViewBuilder
    var builder: some View {
        switch(self) {
        case .go1: SubView(text: "go1")
        case .go2: SubView(text: "go2")
        case .go3: SubView(text: "go3")
        default: EmptyView()
        }
    }
}
```
- Define view modifire
```swift
struct NavigationModifire : ViewModifier{
    
    @State var isActive :  Bool = true
    
    @Binding var route : Router
    
    func body(content: Content) -> some View {
        content
            .background{
                NavigationLink(destination : route.builder, isActive: $isActive ){
                    EmptyView()
                }.hidden()
            }
            .onChange(of: isActive){
                if $0 == false { route = .empty }
            }
    }
    
}

extension View{
    @ViewBuilder
    func navigation(route : Binding<Router>) -> some View{
        if route.wrappedValue != .empty{
            modifier(NavigationModifire(route: route))
        }else { self }
    }
}
```


