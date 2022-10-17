# ARC, Protocol, Delegate

## ARC

### MRC 메모리 관리

Obj-C는 `retain`, `release`, `autorelease` 등을 통해 수동으로 메모리 관리를 하였습니다(MRC, Manual Reference Counting).

``` objective-c
- (void)setName: (NSString *)newName {
  [newName retain];
  [name release];
  name = newName;
}
```

- `retain`: retain count(= reference count) 증가를 통해 현재 Scope에서 객체가 유지되는 것을 보장
- `release`: retain count(= reference count)를 감소시킴. `retain` 후에 필요 없을 때 `release` 함



### ARC 메모리 관리

ARC: compile time에 자동으로 `retain`, `release`를 적절한 위치에 삽입하는 방식

![img](https://miro.medium.com/max/1400/0*uPhaQKYGc7AAdTvw.jpg)

ARC는 자동으로 `retain`, `release`를 삽입해서 `retainCount`를 관리하고, 0이 될 때 `deinit`을 호출해서 메모리 해제를 시킵니다.

Heap은 class, closure 등의 참조형(reference) 자료들이 머무는 공간이자, 개발자가 동적으로 할당하는 메모리 공간이기 때문에 메모리 관리는 Data, Heap, Stack, Code 이렇게 4가지 가상 메모리 영역 중 Heap 영역과 관련되어 있습니다.

ARC는 메모리 관리를 위해 Heap 영역에 참조형 자료들이 얼마나 참조되고 있는지 카운팅하고 이에 따라 메모리를 할당 및 제거합니다.

ARC의 메커니즘은 Swift Runtime이라는 library에 구현되어 있습니다. Swift Runtime은 동적 할당되는 모든 object를 Swift에서 객체를 구성하는 모든 데이터, 즉 reference count와 type meta data를 포함하는 HeapObject라는 struct로 표현합니다.

``` swift
//HeapObject.h

#include "RefCount.h"
```



1. 동적 할당으로 object가 생성되면 해당 정보는 HeapObject라는 struct로 관리
2. HeapObject 안에는 reference count도 포함
3. 따라서 class에 대한 HeapObject를 통해 reference count를 관리 가능



#### compile time에 실행되는 ARC가 동적으로 실행되는 것들의 referenceCount를 세고 메모리 관리를 할 수 있는 이유

1. compile time에 코드 분석을 통해 적절한 위치에 `retain`, `release` 등의 코드를 삽입
2. 삽입된 코드는 run time에 실행
3. `retain`, `release`를 통해 `referenceCount`를 증감시키다가 count가 0이 되면 `deinit`을 통해 해제
4. `referenceCount`는 동적 할당된 object를 표현하는 `HeapObject` struct에서 접근



#### 메모리를 참조하는 방법

##### strong (강한 참조)

- 해당 인스턴스의 소유권을 가진다.
- 자신이 참조하는 인스턴스의 retain count를 증가시킨다.
- 값 지정 시점에 retain이 되고 참조가 종료되는 시점에 release가 된다.
- 선언할 때 아무것도 적어주지 않으면 default로 strong이 된다.

``` swift
var test = Test() // retain count가 1 증가
test = nil // retain count가 0이 되면서 메모리 해재
```



##### weak (약한 참조)

- 해당 인스턴스의 소유권을 가지지 않고, 주소값만을 가지고 있는 포인터 개념이다.
- 자신이 참조하는 인스턴스의 retain count를 증가시키지 않는다. release도 발생하지 않는다.
- 자신이 참조는 하지만 weak 메모리를 해제시킬 수 있는 권한은 다른 클래스에 있다.
- 메모리가 해제될 경우 자동으로 레퍼런스가  nil로 초기화를 해준다.
- weak 속성을 사용하는 객체는 항상  optional 타입이어야 한다.  (해당 객체가 nil일 수 있기 때문)

``` swift
weak var test = Test() // 객체가 생성되지만 weak이기 때문에 바로 객체가 해제되어 nil이 됨
```



##### unowned (미소유 참조 / 약한 참조)

- 해당 인스턴스의 소유권을 가지지 않는다.
- 자신이 참조하는 인스턴스의  retain count를 증가시키지 않는다.
- nil이 될 수 없다. optional로 선언되어서는 안된다.

``` swift
unowned var test = Test() // 객체 생성과 동시에 해제되고 댕글링 포인트만 가지고 있음. 에러남.
```



###### weak와 unowned 차이

weak는 객체를 계속 추적하면서 객체가 사라지게 되면 nil로 바꿉니다.

하지만, unowned는 객체가 사라지게 되면 댕글링 포인터가 남습니다.

이 댕글링 포인터를 참조하게 되면 crash가 나는데, 이 때문에 unowned는 사라지지 않을 것이라고 보장되는 객체에만 설정하여야 합니다.



> 댕글링 포인터(Dangling pointer)? 원래 바라보던 객체가 해제되면서 할당하지 않은 공간을 바라보는 포인터



##### 어느 상황에 쓰이는가

- strong: 레퍼런스 카운트를 증가시켜 ARC로 인한 메모리 해제를 피하고, 객체를 안전하게 사용하고자 할 때 쓰인다.
- weak: 대표적으로 retain cycle에 의해 메모리가 누수되는 문제를 막기 위해 사용되며, delegate 패턴이 있다.
- unowned: 객체의 라이프 사이클이 명화가하고 개발자에 의해 제어 가능이 명확한 경우, weak Optional 타입 대신 사용하여 좀 더 간결한 코딩이 가능하다.

약한 참조가 필요한 경우 weak 키워드만을 사용하고, guard let(또는 if let) 구문을 통해 안전학 옵셔널을 추출하는 것을 권장합니다.



### 순환참조

서로가 서로를 소유하고 있어 절대 메모리 해제가 되지 않는다는 것을 말합니다.

ARC가 편하게 메모리 관리를 해주지만 자칫 잘못하면 순환참조가 발생할 수 있습니다.



## Protocol

프로토콜(Protocol)은 특정 역할을 수행하기 위한 메서드, 프로퍼티, 기타 요구사항 등의 청사진을 정의합니다. 구조체, 클래스, 열거형은 프로토콜을 채택(Adopted)해서 특정 기능을 수행하기 위한 프로토콜의 요구사항을 실제로 구현할 수 있습니다. 어떤 프로토콜의 요구사항을 모두 따르는 타입은 그 프로토콜을 준수한다(Comform)고 표현합니다. 타입에서 프로토콜의 요구사항을 충족시키려면 프로토콜이 제시하는 청사진의 기능을 모두 구현해야 합니다. 즉, 프로토콜은 기능을 정의하고 제시할 뿐이지 스스로 기능을 구현하지는 않습니다.



### 정의 문법

`protocol` 키워드를 사용하여 정의합니다.

``` swift
protocol 프로토콜 이름 {
  /* 정의부 */
}
```



### 프로토콜 구현

``` swift
protocol Talkable {
  // 프로퍼티 요구
  // 프로퍼티 요구는 항상 var 키워드를 사용합니다.
  // get은 읽기만 가능해도 상관 없다는 뜻이며
  // get과 set을 모두 명시하면
  // 읽기 쓰기 모두 가능한 프로퍼티여야 합니다.
  var topic: String { get set }
  var language: String { get }
  
  // 메서드 요구
  func talk()
  
  // 이니셜라이저 요구
  init(topic: String, language: String)
}
```



### 프로토콜 채택 및 준수

``` swift
// Person 구조체는 Talkable 프로토콜을 채택했습니다.
struct Person: Talkable {
  // 프로퍼티 요구 준수
  var topic: String
  var language: String
  
  // 읽기 전용 프로퍼티 요구는 연산 프로퍼티로 대체가 가능합니다.
  // var language: String { return "한국어" }
  
  // 물론 읽기, 쓰기 프로퍼티도 연산 프로퍼티로 대체할 수 있습니다.
  // var subject: String = ""
  // var topic: String {
  //   set {
  //     self.subject = newValue
  //   } get {
  //     return self.subject
  //   }
  // }
  
  // 메서드 요구 준수
  func talk() {
    print("\(topic)에 대해 \(language)로 말합니다.")
  }
  
  // 이니셜라이저 요구 준수
  init(topic: String, language: String) {
    self.topic = topic
    self.language = language
  }
}
```



### 프로토콜 상속

프로토콜은 하나 이상의 프로토콜을 상속 받아 기존 프로토콜의 요구사항보다 더 많은 요구사항을 추가할 수 있습니다. 프로토콜 상속 문법은 클래스의 상속 문법과 유사하지만, 프로토콜은 클래스와 다르게 다중 상속이 가능합니다.

``` swift
protocol 프로토콜 이름: 부모 프로토콜 이름 목록 {
  /* 정의부 */
}
```

``` swift
protocol Readable {
  func read()
}

protocol Writeable {
  func write()
}

protocol ReadSpeakable: Readable {
  func speak()
}

protocol ReadWriteSpeakable: Readable, Writeable {
  func speak()
}

struct SomeType: ReadWriteSpeakable {
  func read() {
    print("Read")
  }
  
  func write() {
    print("Write")
  }
  
  func speak() {
    print("Speak")
  }
}
```



### 프로토콜 준수 확인

is, as 연산자를 사용해서 인스턴스가 특정 프로토콜을 준수하는지 확인할 수 있습니다.

``` swift
let sup: SuperClass = SuperClass()
let sub: SubClass = SubClass()

var someAny: Any = sup
someAny is Readable // true
someAny is ReadSpeakable // false

someAny = sub
someAny is Readable // true
someAny is ReadSpeakable // true

someAny = sup

if let someReadable: Readable = someAny as? Readable {
  someReadable.read()
} // read

if let someReadSpeakable: ReadSpeakable = someAny as? ReadSpeakable {
  someReadSpeakable.speak()
} // 동작하지 않음

someAny = sub

if let someReadable: Readable = someAny as? Readable {
  someReadable.read()
} // read
```



## Delegate

Delegate Pattern은 iOS에서 많이 사용되는 디자인 패턴으로 객체 프로그래밍에 있어 하나의 객체가 모든 일을 처리하는게 아니라 처리하는 부분만 똑 떼어내어 따로 객체로 만들어주고 그걸 넘기는(위임:  Delegate) 방법입니다.



``` swift
import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForeRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    return cell
  }
}
```

UITableViewDelegate와 UITableViewDataSource 안의 함수들을 위임하여 사용하는 것이 delegate pattern의 목적입니다.



``` swift
tableView.delegate = self
tableView.dataSource = self
```

이렇게 동작을 대신해줄 위임자를 설정하면 UITableViewDelegate, UITableViewDataSource에 정의된 여러 메소드들을 self(==VC)에서 사용할 수 있습니다.



### 사용 방법

1. 특정 기능을 할 함수를 protocol 안에 깡통 함수로 선언해줍니다.
2. 그리고 그 protocol을 변수로 선언. (ex. 프로토콜 tableViewDataSource와 프로토콜 변수 dataSource)
3. 그러고 이제  vc에서 프로토콜을 채택해주고 (extension)
4. 그 프로토콜 변수에 self(해당 vc)로 대리자를 위임.
5. self인 뷰컨트롤러에서 dataSource 관련 업무들을 수행하도록 구현



### Delegate 데이터 전달

``` swift
protocol SendDataDelegate {
  func sendData(data: MemoData)
}

class CreateMemoViewController: UIViewController {
  var delegate: SendDataDelegate?
  var memo: MemoData?
  var getDate: Date?
  var flag = 0
  @IBOutlet weak var memoContent: UITextView!
```

메모를 create하는 vc에서 데이터를 전달하는 함수를 포함하는 protocol을 생성하고 class 안에 그 protocol 변수를 만들어줍니다.



``` swift
@IBAction func Save(_ sender: UIBarButtonItem) {
  let content = memoContent.text
  let newMemo = Memo.init(content: content ?? " ")
  
  if flag == 0 {
    saveNewMemo(newMemo.content, date: newMemo.insertDate)
  } else {
    if let date = memo?.date {
      deleteMemo(date)
    }
    
    saveNewMemo(newMemo.content, date: newMemo.insertDate)
    getDate = newMemo.insertDate
    delegate?.sendData(data: CoreDataManager.shared.getItem(date: newMemo.insertDate))
  }
  
  dismiss(animated: true, completion: nil)
}
```

메모를 save하고자 할 때, 전달하고자 하는 data를 delegate.sendDate의 인자로 넣어주고 dismiss 합니다.



``` swift
class DetailViewController: UIViewController, UITableViewDataSource, SendDataDelegate {
  func sendData(data: MemoData) {
    memo = data
  }
```

그리고 이제 dismiss 된 vc에서 protocol을 채택합니다. 채택한 뒤 채택한 프로토콜의 함수를 구현해줍니다. (memo라는 변수에 전달되어온 data를 저장합니다.)



``` swift
override func prepare(for seque: UIStoryboardSeque, sender: Any?) {
  if let vc = segue.destination.children.first as? CreateMemoViewController {
    vc.memo = memo
    vc.delegate = self
  }
}
```

마지막으로 prepare 할 때 vc.delegate = self(self는 현재 vc == 첫번째 vc)로 위임하며 SendDateDelegate의 sendData 함수를 처리합니다. (memo =  data라고 구현해줍니다.)



## Class-Only-Protocol

클래스에서 프로토콜을 채택할 때는 Class-Only-Protocol 이라는 클래스 전용 프로토콜을 사용해야 합니다. Delegate는 Class에서 채택하려면 Class-Only-Protocol 이라는 프로토콜로 만들어주어야 하고 이것은 class 타입으로 만들어지므로 Retain이 됩니다.

``` swift
protocol ChangClassDelegate: class {
  func doSomething()
}

class ChangViewController: UIViewController {
  weak var delegate: ChangClassDelegate?
  
  func action() {
    delegate?.doSomething()
  }
}

class YongViewController: UIViewController, ChangClassDelegate {
  var changVC: ChangViewController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    changVC = ChangViewController()
    changVC?.delegate = self
  }
  
  func doSomething() {}
}
```

``` swift
class SomeViewController: UIViewController {
  override func viewDidLoad(){
    var yongVC: YongViewController?
    super.viewDidLoad()
    yongVC = YongViewController()
  }
}
```

SomeViewController에 yongVC를 객체로 만들어주면 ChangViewController의  delegate는 YongViewController를 참조하고 YongViewController의 changVC는 ChangViewContoller를 참조하게 됩니다. SomeViewController에서 changVC를 객체로 만들어주면 아래 같은 그림처럼 됩니다.

![img](https://blog.kakaocdn.net/dn/mEBE5/btqQ8NoD5PD/bn9RccD5Uxolndv2mdfmaK/img.png)



delegate를 weak으로 선언하지 않았다고 가정하고 아래와 같이 granVC가 nil이 되었을 때의 경우

``` swift
class SomeViewController: UIViewController {
  override func viewDidLoad() {
    var yongVC: YongViewController?
    super.viewDidLoad()
    yongVC = YongViewController()
    
    yongVC = nil
  }
}
```



아래와 같이 Strong으로 선언되어 객체의 연결은 영원히 남아버리게 되고, 결국 메모리 누수가 발생하게 됩니다.

![img](https://blog.kakaocdn.net/dn/YFmsC/btqRcHg64WS/0mJ0nJPEnStOWgmvvCRytk/img.png)



그러므로 반드시 delegate를 weak로 선언해주어서 메모리 누수가 발생하지 않게 해주어야 합니다.

![](https://blog.kakaocdn.net/dn/cvYiAR/btqQ3grynbT/DwDrekgq3g0r7SaCA1zbf1/img.png)



## 출처

https://sujinnaljin.medium.com/

https://ggasoon2.tistory.com/

https://fomaios.tistory.com/

https://devsrkim.tistory.com/entry/Swift-메모리를-참조하는-방법-Strong-Weak-Unowned