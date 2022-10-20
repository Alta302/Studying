# SwiftUI

## HStack

앞에 `Stack`은 뷰 컨테이너이자 하나의 뷰라고 했습니다.따라서 스택에도 뷰 프로토콜이 가진 수식어를 적용할 수 있습니다.

우선 `HStack` 주위로 테두리를 그려봅시다.

참고로 여기서 `padding`을 먼저 **적용하지 않으면** 텍스트 주위로 바짝 붙어서 **여백이 없어지니** 순서에 유의해주세요.

```swift
HStack {
  Text("HStack")
  	.font(.title) // 이미 폰트 크기를 정해줬기 때문에 밖에 있는 largeTitle은 영향 X
  	.foregroundColor(.blue)
  
  Text("은 뷰를 가로로 배열합니다")
  Text("!")
}
.padding()
.border(Color.black) // border은 테두리를 뜻한다.
.font(.largeTitle)
```

![img](https://blog.kakaocdn.net/dn/ch5sHr/btqUkZtcqdG/l5uSF7TfugBdLmCjdK8cH1/img.png)

이처럼 `largeTitle` 폰트를 `HStack`에 적용하게 되면, **그 내부의 모든 자식 뷰에 영향을 주게 됩니다**.

단, `HStack`이라는 문자열을 가진 텍스트는 `title` 폰트가 이미 정해져 있기 때문에, 그 뷰 자신에 적용된 설정이 우선시 되어 `largeTitle`이 적용되지 않습니다.



## Frame()

`SwiftUI`에서 `Frame`은 `UIKit`에서 프레임을 설정했던 것과는 다릅니다. `SwiftUI`의 수식어는 뷰를 직접 변경하는 것이 아니라 원래의 뷰를 수식하는 **새로운 뷰를 반환**합니다.

`SwiftUI`의 뷰는 필요한 만큼만 공간을 차지하지만 변경하려는 경우 `frame()` 수정자를 사용하여 `SwiftUI`에 원하는 크기 범위를 알릴 수 있습니다.

```swift
Text("Frame") // Text 타입
Text("Frame").frame(width: 100, height: 100) // ModifiedContent<Text, _FrameLayout>
```

위 코드에서 `Text`에 `Frame` 수식어를 적용하니 `Text` 타입이 아닌 `ModifiedContent` 타입으로 바뀐 것을 볼 수 있는데, 이처럼 `SwiftUI`에서 프레임은 제약 조건을 설정하는 것이 아니라, 액자처럼 콘텐츠를 담고 있는 하나의 뷰라는 점을 인식해야 합니다.



### 프레임의 역할

`SwiftUI`에서 프레임은 자식 뷰가 사용 가능한 크기를 제안하기 위해 사용됩니다. 동시에 뷰의 정렬 위치를 결정하는 역할도 하죠. 이제 어느 위치에 그림을 배치할 것인지도 정할 수 있습니다. `Frame` 수식어에는 `Alignment` 타입을 가진 `alignment` 매개 변수가 있어 위치를 지정해 줄 수 있습니다.

```swift
HStack(spacing: 20) {
  Text("정창용").background(Color.yellow)
  	.frame(width: 200, height: 200, alignment: .leading)
  	.border(Color.blue)
  
  Text("정창용").background(Color.yellow)
  	.frame(width: 200, height: 200, alignment: .center)
  	.border(Color.blue)
  
  Text("정창용").background(Color.yellow)
  	.frame(width: 200, height: 200, alignment: .center)
  	.border(Color.blue)
}
```

![image-20220902154213161](/Users/jeongchangyong/Library/Application Support/typora-user-images/image-20220902154213161.png)

```swift
Button {
  print("Button tapped")
} label: {
  Text("Welcome")
  	.foregroundColor(.black)
  	.frame(minWidth: 0, maxWidth: 200, minHeight: 0, maxHeight: 200)
  	.font(.largeTitle)
  	.background(Color.blue)
  	.clipShape(Circle())
}
```

![img](https://blog.kakaocdn.net/dn/cXrfQQ/btqZZTIif1P/YuLMGx2QP33z3fRG4hIUfK/img.png)



### 배경화면을 꽉 채우는 방법

`.frame(maxWidth: .infinity, maxHeight: .infinity)`

```swift
Text("서근개발노트")
	.frame(maxWidth: .infinity, maxHeight: .infinity)
  .font(.largeTitle)
  .foregroundColor(.black)
	.background(Color.yellow)
```



### SafeArea까지 채우는 방법

`ignoresSafeArea()` 또는 `edgesIgnoringSafeArea(.all)`

```swift
Text("서근개발노트")
	.frame(maxWidth: .infinity, maxHeight: .infinity)
  .font(.largeTitle)
  .foregroundColor(.black)
	.background(Color.yellow)
  .ignoresSafeArea()
```

![img](https://blog.kakaocdn.net/dn/dG7SE7/btqZYk0Ktgl/FbKEOdg1DdPwrJkVMogqoK/img.png)

## Spacer( )

`Spacer()`는 뷰 사이의 간격을 설정하거나 뷰의 크기를 확장할 용도로 사용되는 레이아웃을 위한 뷰입니다.

`SwiftUI`에서는 기본적으로 `view`를 중앙에 배치합니다. 즉, 세 개의 `text view`를 `VStack` 모두 내부에 배치하면 화면의 수직 중앙에 배치됩니다. 이를 변경하려면 (화면의 상단, 하단, 왼쪽 또는 오른쪽으로 보기를 강제하려는 경우) `Spacer()` 를 사용해야 합니다.

스택 외부에서 사용할 때와 스택 내부에서 사용될 때 그 특성이 각각 달라지게 됩니다.



**스택 외부에서 단독으로 사용**

- 부모 뷰가 제공하는 공간 내에서 가능한 최대 크기로 확장.
- 시각적 요소를 적용할 수 있는 하나의 뷰로 사용됨.

**HStack / VStack 내부에서 사용**

- 시각적 요소가 제외되고 단지 공간을 차지하기 위한 역할로만 가능하며,
- 만약 콘텐츠가 없이 단독으로 사용되었을 경우는 아예 뷰가 없는 것처럼 취급됩니다.



## 출처

https://seons-dev.tistory.com/14