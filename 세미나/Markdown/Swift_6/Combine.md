# Combine

## Combine이란?

Combine은 2019년에 Apple에서 만든 새로운 프레임워크입니다. (RxSwift의 애플 버전)

> Combine 프레임워크는 시간 경과에 따라 변경되는 값을 내보내는 Publisher와 이를 수신하는 Subscriber로 시간 경과에 따른 값 처리를 위한 선언적 Swift API

간단하게 말해서 Publisher, Subscriber 등을 사용해서 비동기 이벤트를 처리하기 위한 프레임워크입니다.



## Combine 장단점

### 장점

- 당신의 코드에 통합하기 쉽습니다. 애플은 Combine API를 Foundation Framework에 긴밀하게 통합하고 있습니다. (이게 RxSwift 보다 좋은 점. RxSwift는 외부 라이브러리. 코코아 프레임워크와 통합하기 위해서 많은 노력이 필요.)
- SwiftUI와 함께 사용하기도 좋습니다.
- API에 대한 테스트도 잘 되어 있습니다.
- 데이터 모델 부터 네트워크 레이어 그리고 UI까지 모두 Combine을 사용 가능합니다.



### 단점

- iOS 13부터 사용할 수 있습니다.



## Combine 구성요소

### 흐름

![img](https://blog.kakaocdn.net/dn/s8x5k/btrpcPAo20y/nU8ktDLjiTzkPP9p70kNc0/img.jpg)

``` swift
class IntSubscriber: Subscriber {
	typealias Input = Int
  typealias Failure = Never
  
  // Publisher가 Subscription주면 호출됨
  func receive(subscription: Subscription) {
    subscription.request(.max(1))
  }
  
  // Publisher가 주는 값을 처리
  func receive(_ input: Int) -> Subscribers.Demand {
    print("Received value: \(input)")
    
    // Publisher에게 한 번 더 달라고 요청
    return .max(1)
  }
  
  func receive(completion: Subscribers.Completion<Never>) {
    print("Received completion: \(completion)")
  }
}

// IntArray를 하나 만듭니다.
let intArray: [Int] = [1,2,3,4,5]

// IntSubscriber를 만듭니다.
let intSubscriber = IntSubscriber()

// IntArray Publisher를 subscribe 합니다.
// intSubscriber가 intArray.publisher에게 값을 요청하면 달라고 말합니다.
intArray.publisher
  .subscribe(intSubscriber)
```



흐름도 그림으로 이해해보면

1. intArray를 하나 만들어서 그냥 존재하게 만들었습니다.
2. intSubscriber도 하나 만듭니다.
3. intSubscriber가 intArray.publisher에게 값을 요청하면 달라고 말합니다. subscribe(_:) 메서드 부분입니다.
4. 그럼 Publisher가 subscription을 만들어서 receive(subscription:)을 통해 Subscriber에게 줍니다.
5. Subscriber는 Subscription을 받으면 Publisher에게 request(_:)를 통해 값을 달라고 합니다.
6. Publisher는 값을 Subscriber에게 주다가 더 이상 줄 게 없으면 completion event를 전달합니다.



실행해보면 결과는 아래와 같이 나옵니다.

```swift
Received value: 1
Received value: 2
Received value: 3
Received value: 4
Received value: 5
Received completion: finished
```



### Publisher

- Publisher는 하나 혹은 여러개의 Subscriber 객체에 시간이 흐름에 따라 값을 내보낼 수 있는 타입을 선언하기 위한 프로토콜입니다.
- Output, Failure 타입이 제네릭으로 구현되어 있습니다.
- 간단하게 이를 사용하라고 애플에서는 자주 사용할 것 같은 기능으로 Future, Just, Deferred, Empty, Fail, Record와 같은 Publisher 프로토콜을 준수하는 Struct, Class들을 구현해 두었습니다.



![img](https://blog.kakaocdn.net/dn/cn2hLN/btro6aZWonl/HPhHKGExjoXpm1SWomA7O0/img.png)

만약 직접 Publisher를 구현하고자 한다면 Output, Failure, receive(subscriber:)는 반드시 구현해야 합니다.

- Output
  - Publisher가 생성할 수 있는 값의 타입을 나타냅니다.
- Failure
  - Publisher가 생성할 수 있는 Error 타입을 나타냅니다.
  - 만약 Error를 생성하지 않는 Publisher를 만들고 싶다면 Never 타입으로 설정해주면 됩니다.
- receive(subscriber:)
  - Publisher 자신을 subscribe 하는 subscriber를 받습니다.



![img](https://blog.kakaocdn.net/dn/pPOsp/btrpaIuKI2p/imTeZagapJKx9LQhKVLjd0/img.png)

설명을 보면 여기서 receive(subscriber:) 대신에 subscribe를 호출하라고 합니다.

Subscriber가 Publisher의 subscribe 메서드를 호출하면 자신을 receive(subscriber:) 메서드를 통해 Publisher에게 알리게 되는 겁니다.



Publisher를 한 마디로 정리해보면 "자신을 Subscribe한 Subscriber에게 값을 내보내는 프로토콜" 정도가 됩니다.



### Subscriber

- Subscriber는 Publisher에게 값을 받을 수 있는 타입을 선언하기 위한 프로토콜입니다.

- Input, Failure 타입이 제네릭으로 구현되어 있습니다.



![img](https://blog.kakaocdn.net/dn/bAaoYP/btrpcOvEsN9/M5yrqGS6A4hMCfnqiHZsR1/img.png)

직접 구현하려고 한다면 아래의 것들은 필수적으로 구현해야 합니다.

- Input
  - Publisher에게 받는 값의 타입입니다.

- Failure
  - Publisher에게 받는 Error 타입입니다.
  - 만약 Error를 수신하지 않고 싶다면 Never 타입으로 설정해주어야 합니다.
- receive(subscription:)
  - Publisher가 만들어서 주는 subscription을 받습니다.
- receive(input:)
  - Publisher가 주는 값을 받습니다.
  - Demand를 반환하는데 이는 값을 더 원하는지의 여부입니다.
- receive(completion:)
  - Publisher가 주는 completion event를 받습니다.



Combine을 사용할 때 주의할 점은 Publisher의 <Output, Failure> 타입과 Subscriber의 <Input, Failure> 타입이 동일해야 한다는 것입니다.

이게 다르면 Publisher와 Subscriber는 서로 값을 주고받지 못합니다.



#### Subscribers

Subscriber 역할을 하는 타입들을 정의해둔 곳입니다.

![img](https://blog.kakaocdn.net/dn/d7C2Cf/btrpffsimv4/YLNKqQVy8Y7IXYYkEPwHMk/img.png)

실제로 무엇이 있는지 보면 아래와 같습니다.

- Demand
- Completion
- Sink
- Assign



##### Demand

![img](https://blog.kakaocdn.net/dn/dBBN25/btrpeJgiUHl/tDQljsmKkgbUikJcviCqtK/img.png)

Subscription을 통해 Subscriber가 Publisher에게 보낸 request 횟수입니다.

즉, Subscriber가 Publisher에게 값을 달라고 요청을 한 횟수입니다.

즉, receive(input:)의 반환 타입이 Demand인데, 이는 Publisher에게 몇 번 더 값을 달라고 요청할지에 대한 값입니다.



``` swift
// Publisher가 주는 값을 처리
func receive(_ input: Int) -> Subscribers.Demand {
  print("Received value: \(input)")
  
  // Publisher에게 한 번 더 달라고 요청
  return .max(1)
  
  // Publisher에게 값 더 이상 안 줘도 된다고 알림
  // return .none
  // Publisher에게 끝없이 값을 달라고 요청
  // return .unlimited
}
```



### Operator

- Operator는 Publisher를 반환하는 Publisher 프로토콜에 정의된 메서드들입니다.
- 여러 종류의 Operator를 Combine하고 사용해서 Publisher가 내보내는 값을 처리합니다.
- UpStream, DownStream이라고 하는 Input, Output을 가지고 있습니다.



### Subscription

- Subscription은 Publisher와 Subscriber의 연결을 나타내는 프로토콜입니다.
- 간단하게 말해서 Publisher + Operator + Subscriber로 이뤄진 하나의 작업이 Subscription입니다.



![img](https://blog.kakaocdn.net/dn/P5c6P/btrpeJ2paHs/fUIJ8wRvcY32NkkJgPHIJ1/img.png)

"Publisher와 Subscriber를 연결하는 프로토콜"이라고 합니다.



![img](https://blog.kakaocdn.net/dn/cjz793/btrpmhpgTRb/rNa3J3PtKuZB2pAfyo2c4k/img.png)

request(demand:)만 필요로 합니다.



``` swift
// Publisher의 Subscription 주면 호출됨
func receive(subscription: Subscription) {
  // Subscription에게 값을 1번 요청
  subscription.request(.max(1))
}
```

Publisher에게 받은 Subscription의 request(demand:)를 호출해서 Publisher에게 값을 요청합니다.

Demand는 아까 말한 대로 Publisher에게 값을 몇 번 달라고 요청하는 것입니다.

즉, Subscriber가 Publisher에게 값을 요청할 때 Subscription을 사용한다고 볼 수 있습니다.



또한 공식문서를 보면, Subscription은 특정 Subscriber가 Publisher에 연결된 순간 설정되는 Identity가 있어서 한 번만 cancel 할 수 있고 cancel하면 이전에 연결된 Subscriber들이 모두 해제합니다. 이런 과정은 스레드로부터 안전해야 합니다.

cancel을 할 수 있는 이유는 Subscription 프로토콜이 Cancellable 프로토콜을 채택했기 때문입니다.

실제로 Cancellable 프로토콜을 보면 아래와 같이 생겼습니다.

```swift
public protocol Cancellable {
  func cancel()
}
```

이렇게 Subscription에 명시적으로 cancel()을 호출하지 않으면 Publisher가 complete 될 때까지나 메모리에서 Subscription이 해제될 때까 Subscription이 계속됩니다.



애플에서는 Cancellable을 채택한 AnyCancellable 클래스도 구현해뒀습니다.

```swift
final public class AnyCancellable: Cancellable, Hashable {
  public init(_ cancel: @escaping () -> Void)
  
  public init<C>(_ canceller: C) Where C: Cancellable
  
  final public func cancel()
}
```

이렇게 AnyCancellable은 cancel()이 호출되면 실행될 closure를 설정할 수도 있습니다.

Subscriber를 구현할 때 Anycancellable을 사용해서 publisher를 cancel 할 수 있지만 Subscription 객체를 사용해서 item을 요청할 수 없는 cancellation token을 제공할 수도 있다고 합니다.

그리고 AnyCancellable은 메모리에서 해제될 때 자동으로 cancel()을 호출합니다.



```swift
// AnyCancellable
let subject = PassthroughSubject<Int, Never>()
let anyCancellable = subject
  .sink(receiveCompletion: { completion in
    print("received completion: \(completion)")
  }, receiveValue: { value in
    print("received value: \(value)")
  })

subject.send(1)
anyCancellable.cancel()
subject.send(2)
```

1은 전달되지만 2는 이미 cancel()이 호출된 후 라서 전달되지 않습니다.



```swift
let subject = PassthroughSubject<Int, Never>()
let anyCancellable = subject
  .handleEvents(
    receiveCancel: {
    	// cancel()이 불렸을 때 호출될 클로저
      print("Cancel 불렸음!")
    })
  .sink(receiveValue: { value  in
    print("Receive Value: \(value)")
  })

subject.send(1)
anyCancellable.cancel()
```

handleEvents는 여러 가지 이벤트가 발생했을 때 처리할 수 있는 Operator입니다. 여러가지 이벤트를 처리할 수 있지만 위 예제에서는 cancel이 호출됐을 경우에만 뭔갈 하도록 구현했습니다.



실제로 실행해보면 아래와 같은 결과를 볼 수 있습니다.

```swift
Receive Value: 1
Cancel 불렸음!
```

sink는 Subscriber를 만들고 바로 request 하는 operator입니다.



### 정리

- Publisher는 값이나 completion event를 Subscriber에게 전달합니다.
- Subsriber는 Subscription을 통해 Publisher에게 값을 요청합니다.
- Subscription은 Publisher와 Subscriber 사이를 연결합니다.
- Subscription은 cancel()을 통해 취소할 수 있으며 이때 호출될 클로저를 설정할 수 있습니다.

 

## RxSwift vs Combine

### 스펙 비교

![img](https://blog.kakaocdn.net/dn/EXqwN/btqwpnRLJJJ/LdQrlbCxE2Gj2N7eBGMd11/img.png)

Rx와 Combine은 모두 Reactive 프로그래밍을 위한 framework입니다.

하지만 Rx는 iOS 8이상부터, Combine은 iOS 13 이상부터 사용할 수 있습니다.

 

Rx는 Third party framework인 반면 Combine은 애플에서 만든 buit-in framework입니다.

그리고 Rx는 Rxcocoa와 Combine은 SwiftUI와 UIBinding을 하도록 설계되어 있습니다.



### 성능 비교

0부터 10,000,000까지 있는 sequence를 연산할 때 Rx와 Combine의 성능이 어떤지 비교해보는 실험입니다.

```swift
import XCTest
import Combine
import RxSwift

final class PlaygroundTests: XCTestCase {
  private let input = stride(from: 0, to: 10_000_000, by: 1)
  
  override class var defaultPerformanceMetrics: [XCTPerformanceMetric] {
    return [
      XCTPerformanceMetric("com.apple.XCTPerformanceMetric_TransientHeapAllocationsKilobytes"),
      .wallClockTime
    ]
  }

  func testCombine() {
    self.measure {
      _ = Publishers.Sequence(sequence: input)
        .map { $0 * 2 }
        .filter { $0.isMultiple(of: 2) }
        .flatMap { Publishers.Just($0) }
        .count()
        .sink(receiveValue: {
        	print($0)
        })
    }
  }

  func testRxSwift() {
    self.measure {
      _ = Observable.from(input)
      	.map { $0 * 2 }
        .filter { $0.isMultiple(of: 2) }
        .flatMap { Observable.just($0) }
        .toArray()
        .map { $0.count }
        .subscribe(onSuccess: { print($0) })
    }
  }
}
```



결과는 Combine이 시간이나 메모리 할당 면에서 모두 성능이 더 좋았습니다.

![img](https://blog.kakaocdn.net/dn/xobY6/btqwpTW0gzu/VaatchtuEW7REC0HMnL6p0/img.png)

## 출처

https://icksw.tistory.com/271

https://icksw.tistory.com/272

https://eunjin3786.tistory.com/67