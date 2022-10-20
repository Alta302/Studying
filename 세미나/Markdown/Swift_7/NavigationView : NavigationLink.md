# SwiftUI

## NavigationView / NavigationLink

`NavigationView`는 `SwiftUI`의 가장 중요한 구성 요소 중 하나입니다. 화면을 쉽게 `Push`와 `Pop`할 수 있으며, 사용자에게 명확하고 계층적인 방식으로 정보를 제공할 수 있습니다.

### NavigationView

`NavigationView`를 사용하려면 다음과 같이 항목을 감싸야합니다.

```swift
struct ContentView: View {
  var body: some View {
    NavigationView {
      Text("Hello, World!")
    }
  }
}
```

`NavigationView`는 최상위에 위치해야 하지만, `TabView` 내에서 사용하는 경우에는 `NavigationView`가 `TabView` 내에 있어야 합니다.



```swift
// 옳은 방법
NavigationView {
  Text("Hello, World!")
  	.navigationBarTitle("Navigation")
}

// 잘못된 방법
NavigationView {
  Text("Hello, World!")
}
.navigationBarTitle("Navigation")
```

> `NavigationView` 내에서 `navigationBarTitle()`를 사용할 수 있으며, 뷰 바깥쪽에서 사용하지 않아도 됩니다. 또한  `displayMode parameter`를 사용하여 커스터마이징을 할 수 있습니다. 



#### displayMode

> `.large` 옵션은 내비게이션 스택의 최상위 보기에 유용한 큰 제목을 표시합니다.
>
> `.inline` 옵션은 내비게이션 스택의 2차, 3차 또는 후속 보기에 유용한 작은 제목을 표시합니다.
>
> `.automatic` 옵션은 기본값이며 이전에 사용한 View를 사용합니다.

```swift
.navigationBarTitle("Navigation") // 기본값에 .automatic이 포함되어 있다.
```

```swift
.navigationBarTitle("Navigation", displayMode: .inline)
```



### NavigationLink

```swift
NavigationLink(destination: Text("String"))
```

`SwiftUI`의 `NavigationView`는 `View`의 맨 위에 `NavigationBar`를 표시하지만 다른 작업도 수행합니다.

`View`를 `view stack`에 푸시할 수 있습니다. 이것은 `iOS view`의 가장 기본적인 형태입니다. 예를 들어 `Wifi`를 탭 하면 설정으로 들어가져서 `Wifi` 목록을 볼 수 있거나, 연락처에서 이름을 탭하면 메시지를 보내는 것과 같습니다.



`TextView`를 `NavigationView`로 `래핑`하고 제목을 지정하면 다음과 같은 결과가 나타납니다.

```swift
struct ContentView: View {
  var body: some View {
    NavigationView {
      VStack {
        Text("Hello World")
      }
      .navigationBarTitle("SwiftUI")
    }
  }
}
```

-> 기본적인 `NavigationView` 형태



이제 텍스트를 클릭하면 새로운 탭으로 이동하는 코드를 작성해 봅시다.

```swift
struct ContentView: View {
  var body: some View {
    NavigationView {
      VStack {
        NavigationLink(destination: Text("Detail View")) {
        	Text("Hello World")
        }
      }
      .navigationBarTitle("SwiftUI")
    }
  }
}
```

-> 이제 화면에 `Hello World` 부분을 탭할 수 있게 바뀌고, 그것을 누르면 `Detail View`로 이동할 수 있습니다. 하지만 여기서 의문점이 있습니다.



`sheet()`와 `NavigationLink()`의 **차이점**?

`NavigationLink()`는 `topic`을 더 자세히 살펴보는 것처럼 사용자가 선택한 것에 대한 세부 정보를 보여줍니다.

`sheet()`는 설정 또는 작성창과 같은 관련 없는 내용을 표시하는데 사용됩니다.



#### List와 NavigationLink

`List`에서 `row in`하여 `Navigation` 내 `destination: Text`에 `row`를 추가해주고, `Text`에도 `row`를 할당해줍니다.

```swift
NavigationView {
  List(0..<100) { row in
  	NavigationLink(destination: Text("Detail \(row)")) {
      Text("Row \(row)")
    }
  }
  .navigationBarTitle("SwiftUI")
}
```

![img](/Users/jeongchangyong/Desktop/img.gif)



#### View를 추가하여 NavigationLink에 연동

만약 동전의 앞과 뒤 중에 골라야 하는 버튼이 있고, 그 버튼을 누르면 "`을 선택하셨습니다.`" 와 같은 텍스트를 보여주고 싶으면 아래와 같이 `ContentView` 바깥에 또 다른 `View`를 생성해 주면 됩니다.

```swift
struct ResultView: View {
  var choice: String
  
  var body: some View {
    Text("\(choice)을 선택하셨습니다.")
  }
}
```



이제 `ContentView`에 `NavigationView`와 `Text`, `NavigationLink` 등을 추가해줍니다.

```swift
import SwiftUI

struct ResultView: View {
  var choice: String
  
  var body: some View {
    Text("\(choice)을 선택하셨습니다.")
  }
}
 
struct ContentView: View {
  var body: some View {
    NavigationView {
     	VStack(spacing: 30) {
        Text("당신은 동전을 던질것입니다\n앞면과 뒷면 중에 하나를 선택해 주세요.")
          .multilineTextAlignment(.center)
        
        NavigationLink(destination: ResultView(choice: "앞면")) {
        	Text("앞면을 선택하셨습니다.")
        }
        
        NavigationLink(destination: ResultView(choice: "뒷면")) {
        	Text("뒷면을 선택하셨습니다.")
       	}
      }
      .navigationBarTitle("Navigation")
    }
  }
}
```



#### Image와 NavigationLink

아래 코드와 같이 `NavigationLink` 내에서 `Image`를 넣어주면 자동으로 텍스트와 모든 것을 파란색으로 설정하게 됩니다.

이것은 때때로 유용할 수도 있지만, 그렇지 않은 경우가 더 많이 있습니다.

```swift
NavigationView {
  NavigationLink(destination: Text("Second View")) {
    Image("원하는 사진")
  }
  .navigationBarTitle("Navigation")
}
```



 만약 사진을 정상적으로 보여주고 싶다면 `.renderingMode(.original)`를 `Image` 밑에 추가해 주면 됩니다.

```swift
NavigationView {
  NavigationLink(destination: Text("Second View")) {
    Image("원하는 사진")
    	.renderingMode(.original)
  }
  .navigationBarTitle("Navigation")
}
```



이것의 대안으로는 `PlainButtonStyle()`과 함께 `buttonStyle()` 수정자를 사용할 수 있습니다.

```swift
NavigationView {
  NavigationLink(destination: Text("Second View")) {
    Image("원하는 사진")
  }
  .buttonStyle(PlainButtonStyle())
  .navigationBarTitle("Navigation")
}
```



혹은 `button`으로 만들어 줄 수 있습니다.

```swift
NavigationView {
  Button {
    // your action here
  } label: {
    Image("card")
    	.resizable()
    	.scaledToFit()
  }
  .buttonStyle(PlainButtonStyle())
  .navigationTitle("Navigation")
}
```



## 출처

https://seons-dev.tistory.com/entry/NavigationView