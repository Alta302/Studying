# SwiftUI

## View Layout (HStack / VStack / ZStack)

### View Layout

#### Stack

`Stack`은 SwiftUI에서 뷰를 배치하는데 사용하는 컨테이너 뷰로, 콘텐츠로 전달된 자식 뷰들을 어떤 형태로 배치할 것인지 결정 짓습니다. SwiftUI에서는 거의 필수적으로 활용되므로 매우 중요하며 사용 방법 또한 매우 간단합니다.

Stack에는 가로 방향 `HStack`, 세로 방향 `VStack`, 겹겹히 쌓아 있는 `ZStack` 총 세 가지 종류가 있습니다.

```swift
var body: some View {
  Text("hello")
  Text("SwiftUI")
} // X

var body: some View {
  VStack {
    Text("hello")
    Text("SwiftUI")
  }
}
```



각 스택이 어떻게 사용되는지 알아보기 위해 2개의 사각형을 만들어 결과를 확인해 보겠습니다.

```swift
HStack {
  Rectangle()
		.fill(Color.green)
  	.frame(width: 150, height: 150)
  
  Rectangle()
  	.fill(Color.yellow)
  	.frame(width: 150, height: 150)
}

VStack {
  Rectangle()
		.fill(Color.green)
  	.frame(width: 150, height: 150)
  
  Rectangle()
  	.fill(Color.yellow)
  	.frame(width: 150, height: 150)
}

ZStack {
  Rectangle()
		.fill(Color.green)
  	.frame(width: 150, height: 150)
  
  Rectangle()
  	.fill(Color.yellow)
  	.frame(width: 150, height: 150)
}
```

![img](https://blog.kakaocdn.net/dn/doSRGD/btqUl9h291V/0VwFPGCoocOj3pzZcfzs11/img.png)

`ZStack`이 정말 초록색 사각형이 노란색 사각형에 가려진 것이 맞는 것인지 확인하고자, 노란색 사각형에 위치를 이동시키는 수식어 `offset` 수식어를 적용해 봅니다.

```swift
ZStack {
  Rectangle()
		.fill(Color.green)
  	.frame(width: 150, height: 150)
  
  Rectangle()
  	.fill(Color.yellow)
  	.frame(width: 150, height: 150)
  	.offset(x: 40, y: 40) // 각각 x축과 y축으로 40씩 이동
}
```

![img](https://blog.kakaocdn.net/dn/JTqzM/btqUnJQI08I/K5tXQcSEjfcB6xw8lKjGi0/img.png)



다시 정리해보면, **H / V / Z 스택**의 레이아웃은 다음 그림과 같은 모습으로 나타납니다.

![img](https://blog.kakaocdn.net/dn/wuRFH/btqUhzuQkUM/HaobZBUPU8aWVx1wovvg81/img.png)



##### 생성자

`Stack`에 대한 생성자를 살펴보면,

> 뷰의 정렬을 위한 alignment
>
> 뷰 간의 간격을 지정하는 spacing
>
> 스택에서 콘텐츠로 표시할 content

이렇게 3개의 매개 변수를 받고 있습니다. 매개 변수를 지정해주지 않으면 '기본값'으로 지정됩니다.



#### Alignment

`alignment` 매개 변수는 각 스택마다 서로 다른 타입을 받아들입니다.



예를 들어,

`HStack`은 가로 방향이므로 배열하기에 세로 방향에 대한 정렬 값인 **VerticalAlignment** 타입이 필요.

`VStack`은 세로 방향이므로 배열하기에 가로 방향에 대한 정렬 값은 **HorizontalAlignment**가 필요.

`ZStack`은 가로와 세로축에 대한 정보가 모두 필요하기 때문에 두 가지 값을 가진 **Alignment**가 필요.



- `VerticalAlignment 종류 (HStack)`
  - top / bottom / center
- `HorizontalAlignment 종류 (VStack)`
  - leading(왼쪽) / center / trailing(오른쪽)
- `Alignment 종류 (ZStack)`
  - topTrailing(오위) / bottomTrailing(오아) / topLeading(왼위) / bottomLeading(왼아)

```swift
HStack(alignment: .top / .center / .bottom) {
  Rectangle()
  	.fill(Color.green)
  	.frame(width: 100, height: 100)
  Rectangle()
  	.fill(Color.red)
  	.frame(width: 150, height: 500)
}
```

![img](https://blog.kakaocdn.net/dn/bbXgvW/btqUfZ8nPzx/n7hAEg3njwm5LJVWrGkT4k/img.png)



#### Spacing

다음 코드처럼 `spacing`의 값을 명시적으로 지정해주면 원하는 간격만큼 떨어지게 하는 효과를 줄 수 있습니다.

```swift
HStack(spacing: 0) { ... }
HStack(spacing: 50) { ... }
```

```swift
HStack(spacing: 50) {
  Rectangle()
  	.fill(Color.green)
  	.frame(width: 150, height: 150)
  
  Rectangle()
  	.fill(Color.red)
  	.frame(width: 150, height: 150)
}
```

![img](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FquSz3%2FbtqUl9JacIL%2Fila1s7XNG2yyPQkXPt0GOK%2Fimg.png)



#### 사용

위에 배운 내용을 바탕으로 화면을 그려보겠습니다. 아래 코드를 확인하며 어떤 식으로 구성되는지 파악하시면 좋습니다. :)



##### HStack

```swift
VStack {
	// HStack 타이틀
  HStack {
    Text("HStack")
    	.font(.title)
    
  	Spacer()
  }
            
  // HStack 도형 정렬
  HStack(alignment: .bottom,spacing: 20) {
		RoundedRectangle(cornerRadius: 20)
			.foregroundColor(.blue)
			.frame(width: 100, height: 100)
		
		RoundedRectangle(cornerRadius: 20)
			.foregroundColor(.red)
			.frame(width: 100, height: 150)
                
		RoundedRectangle(cornerRadius: 20)
			.frame(width: 100, height: 200)
			.foregroundColor(.yellow)
	}
}
```

![img](https://blog.kakaocdn.net/dn/rPGb0/btq2u1KdYhS/5IZhwBVkMPR94zhfpmEzw1/img.png)



여기서 `ZStack`을 활용해 `HStack`의 도형 뒤쪽에 얇은 선 하나를 추가해보겠습니다.

```swift
VStack {
	// HStack 타이틀
	HStack {
		Text("HStack")
			.font(.title)
		
		Spacer()
	}

	// HStack 도형 뒤쪽 선 추가
	ZStack {
		Rectangle()
			.frame(height: 10)
			.padding(.top, 100)

	// HStack 도형 정렬
	HStack(alignment: .bottom,spacing: 20) {
		RoundedRectangle(cornerRadius: 20)
			.foregroundColor(.blue)
			.frame(width: 100, height: 100)
		
		RoundedRectangle(cornerRadius: 20)
			.foregroundColor(.red)
			.frame(width: 100, height: 150)
		
		RoundedRectangle(cornerRadius: 20)
			.frame(width: 100, height: 200)
			.foregroundColor(.yellow)
		}
	}
}
```

![img](https://blog.kakaocdn.net/dn/bzmIUs/btq2u3g1bio/V6aZLegvzPa5rRD4ASjXK0/img.png)



##### VStack

```swift
VStack {
	HStack {
    Text("VStack")
    	.font(.title)
		
    Spacer()
  }
	
  // VStack 도형 정렬
  VStack {
    RoundedRectangle(cornerRadius: 20)
    	.foregroundColor(.blue)
		
    RoundedRectangle(cornerRadius: 20)
    	.foregroundColor(.red)
		
    RoundedRectangle(cornerRadius: 20)
  }
  .frame(width: 100, height: 100)
}
```

![image-20220905151652129](/Users/jeongchangyong/Library/Application Support/typora-user-images/image-20220905151652129.png)



##### ZStack

```Swift
VStack {
  // ZStack 도형 정렬
  ZStack {
  	RoundedRectangle(cornerRadius: 20)
    	.foregroundColor(.blue)
    	.frame(width: 200, height: 200)
    
    RoundedRectangle(cornerRadius: 20)
    	.foregroundColor(.red)
    	.frame(width: 150, height: 150)
    
    RoundedRectangle(cornerRadius: 20)
    	.foregroundColor(.yellow)
    	.frame(width: 100, height: 100)
  }
}
```

![img](https://blog.kakaocdn.net/dn/bsPxop/btq2yas38MM/dJKr4tFLeKRO9OwWw7YtQ1/img.png)



## 출처

https://seons-dev.tistory.com/13