# @State, @ObservedObject / Struct를 Class로

## @State

### 왜 @State는 오직 Struct에서만 작동을 하는가?



### State 사용하기

사용자의 성과 이름을 저장하는 **Struct**(구조체)를 만들겠습니다.

``` swift
struct User {
  var firstName = ""
  var lastName = ""
}
```



이제 **ContentView**에서 **@State** 속성을 만들고, 아래와 같이 **Text**와 **TextField**를 만들어 주겠습니다.

```swift
struct ContentView: View {
  @State private var user = User()
  
  var body: some View {
    VStack {
      Text("당신의 이름은 \(user.firstName)\(user.lastName) 입니다")
      	.font(.title)
      	.fontWeight(.bold)
      	.padding(30)
      
      List {
        Section(header: Text("이름을 입력하세요").font(.headline)) {
          TextField("성", text: $user.firstName)
          TextField("이름", text: $user.lastName)
        }
      }
    }
  }
}
```

