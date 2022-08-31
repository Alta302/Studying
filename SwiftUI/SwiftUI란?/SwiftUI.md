# SwiftUI

## SwiftUI란?

![img](https://developer.apple.com/assets/elements/icons/swiftui/swiftui-96x96_2x.png)

SwiftUI에서는 놀랍게도 최소한의 코드만으로 Swift의 성능을 사용하여 모든 Apple 플랫폼 전반에서 멋진 앱을 빌드할 수 있습니다. 어떤 Apple 기기에서나 단 하나의 도구 및 APi 세트를 사용하여 모든 사용자에게 더 나은 경험을 제공할 수 있습니다.

![SwiftUI 인터페이스가 표시되어 있는 MacBook Pro, iPad 및 iPhone.](https://developer.apple.com/xcode/swiftui/images/hero-lockup-large_2x.png)



## 선언적 구문

SwiftUI는 선언적 구문을 사용하므로 사용자 인터페이스의 기능을 명시하기만 하면 됩니다. 예를 들어, 텍스트 필드로 구성된 항목의 목록을 작성한 다음 각 필드의 정렬, 서체 및 색상을 설명하면 됩니다. 코드가 그 어느 때보다 간단하고 가독성이 향상되어 시간이 절약되고 유지 관리가 용이합니다.

``` swift
import SwiftUI

struct AlbumDetail: View {
  var album: Album
  
  var body: some View {
    List(album.songs) { song in
    	HStack {
        Image(album.cover)
        
        VStack(alignment: .leading) {
          Text(song.title)
          Test(song.artist.name)
          	.foregroundStyle(.secondary)
        }
      }
    }
  }
}
```

이 선언적 스타일은 애니메이션과 같은 복잡한 개념에도 적용됩니다. 코드 몇 줄 만으로 거의 모든 컨트롤에 애니메이션을 손쉽게 추가하고 바로 사용할 수 있는 효과 모음을 선택할 수도 있습니다. 런타임 중에 시스템에서는 부드러운 움직임을 만들기 위해 필요한 모든 단계는 물론 사용자의 상호 작용 및 애니메이션 도중의 상태 변경까지도 처리합니다. 따라서 개발자는 이와 같이 간단한 애니메이션을 사용하여 앱에 생동감을 불어넣어 줄 새로운 방법을 찾을 수 있습니다.



## 디자인 도구

Xcode에는 SwiftUI를 사용하여 드래그 앤 드롭만큼 간단하게 인터페이스를 빌드할 수 있는 직관적인 디자인 도구가 포함되어 있습니다. 디자인 캔버스에서 작업하면 편집하는 모든 내용이 옆에 표시되는 편집기의 코드와 완벽하게 동기화됩니다. 코드를 입력하는 동시에 미리보기로 바로 볼 수 있고 라이트 모드 및 다크 모드와 같이 다양한 구성에서 UI를 확인할 수도 있습니다. Xcode는 변경 사항을 즉시 재컴파일하고 실행 중인 앱 버전에 삽입하므로 상시 확인 및 편집이 가능합니다.

![img](https://developer.apple.com/xcode/swiftui/images/example-design-large_2x.png)

**드래그 앤 드롭.** 캔버스에서 컨트롤을 드래그하여 사용자 인터페이스 내에서 간단히 구성 요소를 정렬할 수 있습니다. 속성을 클릭하여 열고 서체, 색상, 정렬 및 기타 디자인 옵션을 선택하고, 커서를 움직여 컨트롤을 쉽게 다시 정렬할 수 있습니다. 이러한 시각적인 편집기의 상당 부분은 코드 편집기 내에서도 사용 가능하므로 인터페이스에서 직접 코딩하는 부분을 선호하는 경우에도 속성을 사용하여 각 컨트롤에서 새 수정자를 탐지할 수 있습니다. 또한 라이브러리에서 컨트롤을 드래그하여 디자인 캔버스 또는 코드에 직접 드롭할 수 있습니다.

**동적 대체.** Swift 컴파일러 및 런타임은 Xcode 전체에서 기본 제공되므로 앱을 지속적으로 구축하고 실행할 수 있습니다. 개발자에게 표시되는 디자인 캔버스는 사용자 인터페이스가 아닌 라이브 앱과 비슷합니다. 또한 Xcode는 동적 대체를 사용하여 직접 라이브 앱에서 편집된 코드로 바꿀 수 있습니다.

**미리보기.** 이제 SwiftUI 보기 중 하나 또는 여러 개의 미리보기를 생성하여 샘플 데이터를 얻을 수 있으며 큰 서체, 현지화 또는 다크 모드와 같이 사용자에게 표시할 모든 항목을 구성할 수 있습니다. 또한 미리보기에서는 UI를 원하는 기기에서 원하는 방향으로 표시할 수 있습니다.



## UIKit 및 AppKit와 호환

SwiftUI는 UIKit 및 AppKit과 호환되도록 설계되었기 때문에 기존 앱에 추가로 적용할 수 있습니다. 사용자 인터페이스의 새로운 부분을 구축하거나 기존 사용자 인터페이스를 다시 빌드해야하는 경우 나머지 코드베이스를 유지하면서 SwiftUI를 사용할 수 있습니다.

SwiftUI에서 제공하지 않는 인터페이스 요소를 사용하려는 경우 SwiftUI를 UIKit 및 AppKit과 함께 사용하여 최고의 환경을 활용할 수 있습니다.



- SwiftUI와 UIKit는 같이 사용될 수 있습니다.
- SwiftUI는 ViewController에 embed 될 수 있습니다.
- 반대로 UIKit View 역시 SwiftUI에서 사용되도록 개조될 수 있습니다.



### SwiftUI to UIKit

- SwiftUI 계층은 다음과 같이 쉽게 UIKit에서 사용할 수 있습니다.
- UIHostingController로 SwiftUI를 감싸서 사용하면 됩니다.

``` swift
let vc = UIHostingController(rootView: MyView())
```



### UIKit to SwiftUI

- UIView도 다음꽈 같이 SwiftUI에서 사용할 수 있습니다.
- UIViewRepresentable을 conform하는 wrapper를 만들면 여타 SwiftUI view와 같이 작동하게 됩니다.

``` swift
struct MySwiftUIView: UIViewRepresentable {
  func makeUIView(context: Context) -> UIViewType {
    // View를 원하는대로 생성하는 곳
    let view = UIView()
    return view
  }
  
  func updateUIView(_ view: UIViewType, context: Context) {
    // View를 원하는대로 수정하는 곳
  }
}
```



- 다음과 같이 SwiftUI에서 사용하면 되는 것입니다.

``` swift
struct MyView: View {
  var body: some View {
    MySwiftUIView()
  }
}
```



## 장단점

### 장점

#### 1. 선언적 구문

``` swift
Text(Date(), style: .date)
	.font(.title)
	.bold()
	.foregroundColor(.orange)
	.italic()
```

- SwiftUI는 이벤트 중심의 프로그래밍(명령형 방식)이 아닌 선언적 구문을 사용하여 개별 기능을 명시하는 방법으로 처리함
- 예를 들어, Text로 구성된 화면에서 각 Text의 서체 및 색상 등의 정보를 명시
- 이벤트 중심의 명령형 방식보다 코드가 간결하고 가독성이 향상되어 시간이 절약되고 유지 관리가 용이



#### 2. 대폭 개선된 설계 / 개발 워크플로우

![A screenshot of Xcode showing code that draws a circular image and the](https://jasudev.github.io/posts-images/2022-05-02-Fabula1/Previews-in-Xcode-1@2x.png)

- 기존 방식은 시뮬레이터 / 디바이스를 통해 앱을 빌드해야 확인 가능한 개발 방식
- SwiftUI는 코드와 함께 실시간 미리보기를 제공하여 이 문제를 크게 개선
- 실시간으로 변경 사항을 확인 가능하여 개발 시간을 획기적으로 단축



#### 3. 우수한 레이아웃 시스템

> **SwiftUI 레이아웃 프로세스의 3단계**
>
> 1. 부모가 자식의 크기를 제안합니다.
> 2. 부모의 제안을 받아 자식은 스스로 크기를 선택합니다.
> 3. 자식이 선택한 크기를 기반으로 부모는 좌표 공간에 자식을 배치합니다.

- SwiftUI는 레이아웃 시스템이 개념적으로 단순하고 명확함
- UIKit처럼 앵커 및 제약 시스템에 의존하지 않고 전통적인 Grid System을 기반으로 함
- SwiftUI의 모든 Layout UI는 코드에서 직접 정의
- 코드는 더 간결하고 이해하기 쉬우며 오류 발생율이 낮아 유지 관리가 용이



#### 4. 기본적으로 상태(State) 기반 UI 적용

![스크린샷 2022-05-04 오후 1.38.13](https://jasudev.github.io/posts-images/2022-05-02-Fabula1/2022-05-04_1.38.13.png)

- SwiftUI의 또 다른 핵심 기능으로 상태(State) 관리 메커니즘
- 모든 뷰는 여러 내장 메커니즘을 통해 상태 객체에 바인딩
- 주어진 상태 객체의 속성이 변경되면 변경을 반영해야하는 모든 뷰를 즉시 렌더링
- UIKit / AppKit의 명령형 접근 방식(이벤트 중심의 프로그래밍)보다 코드가 줄고 가독성이 좋음
- 기본적으로 뷰를 상태에 바인딩함으로써 상태를 전달하는 코드가 필요하지 않아 버그가 감소
- 단, 명령형 방식과 다른 개발 사고 방식이 필요



#### 5. 양방향 프리징

![스크린샷 2022-05-04 오후 2.04.31](https://jasudev.github.io/posts-images/2022-05-02-Fabula1/2022-05-04_2.04.31.png)

- Objective-C -> Swift 전환과 마찬가지로 기존 프로젝트를 SwiftUI로 완전히 대체하기는 어려움
- SwiftUI 뷰에서 UIKit 코드를 사용할 수 있으며 그 반대의 경우도 사용할 수 있도록 브리징 래퍼 지원
- 브리징 래퍼를 이용하면  UIKit / AppKit를 유지하면서 SwiftUI를 학습할 수 있음
- Swift와 SwiftUI는 상호 배타적이지 않음



### 단점

#### 1. 다소 가파른 학습 곡선

- 처음 SwiftUI로 개발할 때는 각 단계별로 학습이 필요하므로 개발 과정에서 추가 공수가 발생할 수 있음
- Objective-C -> Swift 전환과 마찬가지로 프로젝트 개발 기간이 다소 늘어날 수 있음
- 그러나 학습 후에는 SwiftUI를 통해 대부분의 작업을 더 빠르게 수행할 수 있음



#### 2. 아직 지원하지 않는 라이브러리 / 컴포넌트

- 광범위한 프레임워크를 한 번에 교체하는 것은 불가능
- Apple은 가장 일반적인 사용 사례를 먼저 시스템 컴포넌트로 지원
- UIKit / AppKit를 래핑해야할 경우 다소 공수가 들어갈 수 있음
- 이전에 작동했던 라이브러리 / 컴포넌트를 브리징 래퍼로 연결하는 작업 공수가 발생
- 경우에 따라서 UIKit에서 제공하는 특정 기능을 지원하지 않을 수 있음



#### 3. SwiftUI는 여전히 진화중

![스크린샷 2022-05-04 오후 2.22.52](https://jasudev.github.io/posts-images/2022-05-02-Fabula1/2022-05-04_2.22.52.png)

- Apple이 SwiftUI를 발표한지 불과 만 2년이 지남
- 과거 Swift의 변화처럼 프레임워크의 상대적 미성숙을 감안해야 함
- 개선 과정에서 기능적으로 변경되거나 제거될 수 있음
- 이러한 문제는 시간이 지날수록 줄겠지만 현 시점에서는 변경에 따른 리스크를 감수해야 함



#### 4. 최소 버전은 iOS 13 / macOS 10.15

- SwiftUI를 채택하기에 가장 고민이 되는 것 중에 하나는 iOS 13 / macOS 10.15 이상에서만 사용할 수 있다는 것
- 앱에 따라서 iOS 12 이하 버전을 지원하고 일부는 더 과거 버전을 최소 버전으로 유지하고 있음
- iOS는 Android에 비해 OS 업데이트 속도가 빠르지만 이 문제는 일부 앱에서 여전히 타협점이 될 수 있음



### 그럼 우리는 SwiftUI를 프로젝트에 도입해도 될까?

- iOS 12 이하 버전 사용자가 많을 경우에는 제약이 따름 (현재 iOS 14 이상 점유율이 90%를 넘기 때문에 신규 프로젝트는 SwiftUI로 진행해도 큰 문제는 없을 것)
- 커스텀 UI를 구현하기 어렵거나 불가능할 수 있음, 프레임워크가 더 성숙할 때까지 커스텀 디자인을 지양할 필요
- 새로운 앱을 개발 예정이라면 앞으로 Apple의 비전은 매우 명확하므로 SwiftUI를 도입하는 것이 바람직 함
- 새로운 프로젝트에 UIKit / AppKit 만을 사용한다면 누군가가 지불해야하는 기술 부채가 됨
- Apple 생태계의 모든 플랫폼에서 동일한 코드로 개발 가능
- SwiftUI 프레임워크를 마스터하면 높은 품질의 안정적인 UI를 설계할 수 있고 다양한 화면 사이즈를 빠르고 쉽게 대응할 수 있음



## 출처

https://developer.apple.com/kr/xcode/swiftui/

https://jasudev.github.io/Fabula-프로젝트-1편-SwiftUI-장단점/

https://www.hohyeonmoon.com/blog/swiftui-tutorial-uikit/