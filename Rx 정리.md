# ReactiveX

## 1. ReactiveX 의미

- '**Reactive** e**X**tensions'
- **reactive**: 반응을 보이는, **extension**: (세력, 영향력, 혜택 등의) 확대 = 반응을 확장한다
- **"옵저버블 스트림으로 비동기 프로그래밍을 하기위한 API"**



## 2. 동기와 비동기

### 1. 동기

- 시간에 관계 없이 한 개의 데이터 요청에 대한 서버의 응답이 이루어질 때까지 계속 대기해야만 한다.
- **블록 상태**

**장점** : 설계가 매우 간단하고 직관적입니다.

**단점** : 요청에 따른 결과가 반환되기 전까지 아무것도 못하고 대기해야합니다.



### 2. 비동기

- 서버에게 데이터를 요청한 후 요청에 따른 응답을 계속 기다리지 않아도 되며 다른 외부 활동을 수행하여도 되고 서버에서 다른 요청사항을 보내도 상관 없습니다.
- **논블록 상태**

**장점** : 요청에 따른 결과가 반환되는 시간 동안 다른 작업을 수행할 수 있습니다.

**단점** : 동기식보다 설계가 복잡하고 논증적입니다.



## 3. Rx의 주요 기능

- **Observable**
- **Operators**
- **Single**
- **Subject**
- **Scheduler**



## 5. 예제

```swift
import RxSwift

let disposeBag = DisposeBag()

let value = ["물고기", "쓰레기"] // 강에 흐르는 value
let rx = Observable.from(value) // Observable: value가 흐르는 'rx'강

rx
	.filter { $0 == "물고기" } // Operators: 물고기만 건짐
	.map { "\($0) 회" } // Operators: 물고기를 회로 만듦
	.subscribe { print($0.element ?? "") } // Subscribe: 'rx'강을 구독
	.disposed(by: disposeBag)

// 결과: 물고기 회
```



## 6. 출처

https://juyeop.tistory.com/22

https://axe-num1.tistory.com/22
