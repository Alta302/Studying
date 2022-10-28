# GCD

초기에는 마이크로 프로세서의 clock 속도를 높이는 방식으로 연산 속도를 높였습니다.

 그 후 점점 증가하는 전력 소비와 발생하는 열로 인해 단일 프로세서의 clock 속도 증가에 한계를 맞게 되었으며, 이는 특히 모바일에서 영향을 크게 받게 되었습니다. 따라서 CPU 벤더들은 단일 CPU의 clock 속도를 개선하는 대신 여러개의 CPU를 탑재하는 형태로 효율을 높이는 것에 초점을 맞추게 되었고, 프로세서의 클럭 속도가 빨라지면서 자연스럽게 소프트웨어도 빨라지던 예전과 달리 멀티 코어 프로세서에서는 멀티 프로세서에게 어떻게 잘 프로그램의 동작을 배분하는 지가 중요해졌습니다.



 GCD 이전에는 멀티 스레딩을 위해 Thread와 OperationQueue 등의 클래스를 사용했는데, Thread는 복잡하고 Critical Section 등을 이용한 Lock 을 관리하기 까다로웠고, OperationQueue는 GCD에 비해 무겁고 Boilerplate 코드들이 많이 필요한 문제가 있습니다.

 GCD (Grand Central Dispatch)는 멀티 코어 프로세서 시스템에 대한 응용 프로그램 지원을 최적화하기 위해 Apple에서 개발한 기술로 스레드 관리와 실행에 대한 책임을 어플리케이션 레벨에서 운영체제 레벨로 넘겨버렸습니다. 작업 단위는 Block(Swift에선 클로저)이라 불리며, DispatchQueue가 이 Block들을 관리합니다.

 GCD 는 각 어플리케이션에서 생성된 DispatchQueue 를 읽는 멀티코어 실행 엔진을 가지고 있으며, 이것이 Queue에 등록된 각 작업을 꺼내 스레드에 할당하고 개발자는 내부 동작을 자세히 알 필요 없이 Queue 에 작업을 넘기기만 하면 되서, Thread 를 직접 생성하고 관리하는 것에 비해 관리 용이성과 이식성, 성능 증가하게 되었습니다.



**애플 공식 문서에서도 Thread 클래스 대신 GCD 사용을 권장하고 있습니다.**



**GCD의 장점**

- reduces the memory penalty for storing thread stacks in the app’s memory space.
- eliminates the code needed to create and configure your threads.
- eliminates the code needed to manage and schedule work on threads.
- simplifies the code



## Dispatch Queue

- GCD는 앱이 블록 객체 형태로 작업을 전송할 수 있는 FIFO 대기열(Queue)을 제공하고 관리합니다.
- Queue에 전달된 작업은 시스템이 전적으로 관리하는 스레드 풀(a pool of threads)에서 실행됩니다.
- DispatchQueue는 2개의 타입(Serial / Concurrent)으로 구분되며 둘 모두 FIFO 순서로 처리합니다.
- 앱을 실행하면 시스템이 자동으로 메인 스레드 위에서 동작하는 Main 큐(Serial Queue)를 만들어서 작업을 수행하고, 그 외에 추가적으로 여러 개의 Global 큐(Concurrent Queue)를 만들어서 큐를 관리합니다.
- 각 작업은 동기(sync) 방식과 비동기(async) 방식으로 실행 가능하지만 Main 큐에서는 async만 사용이 가능합니다.



### Serial Queue

- Serial Queue는 큐에 쿠가된 순서대로 한번에 하나의 task를 실행합니다.

![Imgur](https://i.imgur.com/CCNk1fj.png)



### Concurrent Queue

- Concurrent Queue는 동시에 하나 이상의 task를 실행하지만 큐에 추가됐을 시에 추가된 순서대로 작업을 계속 진행합니다. 위의 사진을 보면 동시에 진행하고 있지만 사실 동시에 진행되는 것이 아닙니다.

![Imgur](https://i.imgur.com/DzZWIFn.png)



### Parallelism(병렬성) vs Concurrency(동시성)

![Imgur](https://i.imgur.com/UoR30Ms.png)



#### 병렬성(Parallelism)

- 물리적인 용어입니다.
- 실제로 작업이 동시에 처리되는 것입니다.
- 멀티 코어에서 멀티 스레드를 동작시키는 방식입니다.
- 한 개 이상의 스레드를 포함하는 각 코어들이 동시에 실행되는 성질입니다.
- 병렬성은 데이터 병렬성(Data Parallelism)과 작업 병렬성(Task Parallelism)으로 구분합니다.



#### 동시성(Concurrency)

- 논리적인 용어입니다.
- 동시에 실행되는 것처럼 보이는 것입니다.
- 싱글 코어에서 멀티 스레드를 동작시키기 위한 방식입니다.
- 하지만 멀티 코어에서도 동시성은 사용 가능합니다.
- 멀티태스킹을 위해 여러 개의 스레드가 번갈아가면서 실행되는 성질
- 동시성을 이용한 싱글 코어의 멀티태스킹은 각 스레드들이 병렬적으로 실행되는 것처럼 보이지만 사실은 번갈아가면서 조금씩 실행되고 있는 것입니다.



## 사용법

> System이 제공하는 Queue에는 `Main`과 `Global`이 있습니다.

- Main
  - UI와 관련된 작업은 모두 main 큐를 통해서 수행하며 Serial Queue에 해당됩니다.
  - MainQueue를 sync 메서드로 동작시키면 Dead Lock 상태에 빠집니다.

``` swift
DispatchQueue.main.async {}
```



- Global
  - UI를 제외한 작업에서 사용하며 Concurrent Queue에 해당합니다.
  - sync와 async 메서드 모두 사용 가능합니다.
  - QoS 클래스를 지정하여 우선순위 설정이 가능합니다.

``` swift
DispatchQueue.global().async {}
DispatchQueue.global(qos: .utility).sync {}
```



## Qos (Quality of Service)

> 시스템은 Qos 정보를 통해 스케줄링, CPU 및 I/O 처리량, 타이머 대기 시간 등의 우선 순위를 조정합니다.
>
> 총 6개의 QoS 클래스가 있으며 4개의 주요 유형과 다른 2개의 특수 유형으로 구분 가능합니다.
>
> [낮은 순] Unspecified -> Background -> Utility -> Default -> User Initiated -> User Interactive [높은 순]



### Primary QoS Service

> 우선 순위가 높을수록 더 빨리 수행되고 더 많은 전력을 소모합니다.
>
> 수행 작업에 적절한 QoS 클래스를 지정해주어야 더 반응성이 좋아지며, 효율적인 에너지 사용이 가능합니다.

- **User Interactive**
  - 즉각 반응해야 하는 작업으로 반응성 및 성능에 중점합니다.
  - main thread에서 동작하는 인터페이스 새로고침, 애니메이션 작업 등 즉각 수행되는 유저와의 상호작용 작업에 할당합니다.
- **User Initiated**
  - 몇 초 이내의 짧은 시간 내 수행해야 하는 작업으로 반응성 및 성능에 중점합니다.
  - 문서를 열거나, 버튼을 클릭해 액션을 수행하는 것처럼 빠른 결과를 요구하는 유저와의 상호작용 작업에 할당합니다.
- **Utility**
  - 수 초에서 수 분에 걸쳐 수행되는 작업으로 반응성, 성능, 그리고 에너지 효율성 간에 균형을 유지하는데 중점합니다.
  - 데이터를 읽어들이거나 다운로드 하는 등 작업을 완료하는데 어느 정도 시간이 걸릴 수 있으며 보통 진행 표시줄로 표현합니다.
- **Background**
  - 수 분에서 수 시간에 걸쳐 수행되는 작업으로 에너지 효율성에 중점합니다. NSOperation 클래스 사용 시 기본값입니다.
  - Background에서 동작하며 색인 생성, 동기화, 백업 같이 사용자가 볼 수 없는 작업에 할당합니다.
  - 저전력 모드에서는 네트워킹을 포함하여 백그라운드 작업은 일시 중지합니다.



### Special QoS Classes

> 일반적으로, 별도로 사용할 일이 없는 특수 유형의 QoS입니다.

- **Default**
  - QoS를 별도로 지정하지 않으면 기본값으로 사용되는 형태이며 User Initiated와 Utility의 중간 레벨입니다.
  - GCD Global Queue의 기본 동작 형태입니다.
- **Unspecified**
  - QoS 정보가 없으므로 시스템이 QoS를 추론해야 한다는 것을 의미합니다.

```swift
/***************************************
* Main		: UI와 관련된 작업
* Global	: UI를 제외한 작업에서 사용
***************************************/

/***************************************
* 1번이 끝나고 2번이 동작하게 된다.
***************************************/
DispatchQueue.global(qos: .userInitiated).async {
  // 1번
  // 위의 작업이 끝나야만
  for _ in 0...900_000_000 {
    _ = 1 + 1
  }
  
  // 2번
  // 밑에 스레드가 실행된다.
  // Main 스레드는 UI 작업을 할 때 사용된다.
  DispatchQueue.main.async {
    print("Start")
    self.testView.frame.origin.y += 250
    self.view.backgroundColor = .yellow
  }
  
/***************************************
* 1번과 2번이 따로 동작하게 된다.
***************************************/
  
  DispatchQueue.global().async {
    // 1번
    for _ in 0...900_000_000 {
      _ = 1 + 1
    }
  }
  
  // 2번
  self.view.backgroundColor = .magenta
}
```



## 동시성 문제 (Concurrency Problem)

![img](https://miro.medium.com/max/700/1*V04pci-cbI_pWgrCP5gziQ.png)

 **두 개 이상의 스레드를 사용하면서, 동일한 메모리 접근 등으로 인해 발생할 수 있는 문제**인 **동시성 문제**는 여러 개의 스레드에서 공유 자원을 동시에 접근하고 있는 상황에서 발생할 수 있습니다.



동시성 문제는 크게 아래의 세가지 케이스가 있습니다.

1. Race Condition (경쟁 상태)
2. Deadlock (교착 상태)
3. Priority Inversion (우선 순위의 뒤바뀜)



### Race Condition (경쟁 상태)

> **경쟁 상태**란 **<u>공유 자원</u>**에 대해 **여러 개의 <u>프로세스</u>가 동시에 접근**을 시도할 때 접근의 타이밍이나 순서 등이 결과값에 영향을 줄 수 있는 상태를 말한다. 동시에 접근할 때 **자료의 <u>일관성</u>을 해치는 결과**가 나타날 수 있다.

-> **공유 자원에 여러 개의 프로세스가 동시에 접근하면 값이 예상과 다르게 변할 수 있어서 문제**입니다.



값 변경이 예상대로 동작하지 않는지 확인하기 위해 여러 개의 스레드에서 공유 자원(`sharedValue`)에 접근하는 코드를 작성해 보았습니다.

```swift
var sharedValue = 0
let valueGroup = DispatchGroup()

DispatchQueue.global(qos: .background).async(group: valueGroup) {
  sharedValue = 100 // 쓰기
  print("background after", sharedValue) // 읽기
}

DispatchQueue.global(qos: .userInteractive).async(group: valueGroup) {
  sharedValue = 200 // 쓰기
  print("userInteractive after", sharedValue) // 읽기
}

valueGroup.notify(queue: DispatchQueue.main) {
  print("final: ", sharedValue)
}
```

```
userInteractive after 200
background after 100
final:  100

background after 100
userInteractive after 200
final:  200

userInteractive after 100
background after 100
final:  100

background after 200
userInteractive after 200
final:  200
```



어떻게 된 상황인지 자세히 살펴보기 위해 우선 각각의 상황을 taskA와 taskB로 재정의 해보겠습니다.

- teskA write : `userInteractive Queue`에서 `sharedValue`에 `200`을 씀
- teskA read : `userInteractive Queue`에서 `sharedValue`를 읽음
- teskB write : `background Queue`에서 `sharedValue`에 `100`을 씀
- teskB read : `background Queue`에서 `sharedValue`를 읽음



![img](https://miro.medium.com/max/700/1*ScDZ9ob49EPUCXUEPSHOLQ.png)

teskA read - teskB write



![img](https://miro.medium.com/max/700/1*PxDjV8jO_e2LBBDF4FmqFw.png)

teskA write - teskB write



**여러 스레드가 경쟁적으로 공유 데이터에 접근해서 읽기 및 쓰기**를 하고 있기 때문에 예상치 못한 결과가 나오게 되는 것입니다.

이 동시성 문제가 바로 **경쟁상태**입니다.



#### 해결 방법

- 객체에 접근(ex: `falcon`)할 때,
- 메인 큐(스레드)가 아닌 **다른 큐에서 접근할 가능성**(ex: `workerQueue`에서 접근)**이 있는가?**를 항상 생각하고,
- 객체 내부에 **thread safe한 코드 작성**(serial queue + sync 혹은 Dispatch barrier)할 수 있어야 합니다.



### Deadlock (교착 상태)

> 프로세스가 자원을 얻지 못해 다음 처리를 하지 못하는 상황

-> **한정된 자원을 여러 곳에서 사용하려고 할 때, 자원을 얻지 못해 다음 처리가 어려운 상태**



예를 들어 `스레드 2`가 `메모리 A`를 점유해 사용하면서 경쟁 상황을 방지하기 위해 내부적으로 잠금처리를 하고

![img](https://miro.medium.com/max/700/1*ouEqnGUnt3lDGwBTsAR3kQ.png)

`메모리 B`를 동시에 사용하려고 합니다.

![img](https://miro.medium.com/max/700/1*hBdxdpeKghdAe5ml7MtajQ.png)

 그런데 이미 `메모리 B`는 다른 스레드(`스레드 3`)에서 사용 중이라 잠겨 있는 상태입니다. 그럼 `스레드 3`의 동작이 끝날 때까지 기다리면 `메모리 B`를 사용할 수 있습니다.

![img](https://miro.medium.com/max/700/1*mpxfJa05Zv1f8WyL31GQJQ.png)

하지만 `스레드 3`이 `메모리 A`를 요청하고 있는 상태입니다. `메모리 A`는 `스레드 2`에서 이미 사용하고 있었기 때문에, 하염없이 `메모리 A`를 점유하고 있는 동작이 끝나기만을 기다리고 있었습니다.

![img](https://miro.medium.com/max/700/1*h6f0e6M1MHCCzSdEspjIPA.png)

결국 서로 필요한 자원을 얻지 못하기 때문에 이러지도 저러지도 못한채로 **일의 진행이 멈춰버립니다.** 이 동시성 문제가 바로 **데드락**입니다.



#### 해결 방법

 데드락은 **주로 2개 이상의 스레드를 쓰는 상황**에서 발생합니다. 따라서 일반적인 경우, 교착 상태의 단순한 처리 방법으로는 **Serial Queue**를 이용해서 해결할 수 있습니다.

 왜냐하면 시리얼 큐로 보내진 작업들은 **순차적으로 실행**되기 때문입니다. **한 번에 하나의 스레드**에서만 (필요시) **여러 자원에 접근**하고, 공유 자원에 여러 스레드에서 동시에 접근하는 상황은 발생하지 않습니다.

하지만 **설계 상의 오류로 데드락이 발생**하는 경우에는 Serial Queue 사용으로 해결할 수 있는 케이스에 해당하지 않습니다.

 따라서 **데드락의 개념을 알고 유의해서 설계**하는 것도 중요합니다. 또한 세마포어 같은 **한정된 자원**을 사용할 때도 **순서에 유의**해서 사용해야 합니다.



### Priority Inversion (우선순위의 뒤바뀜)

> QoS(서비스 품질)가 뒤바뀌어서 작업이 진행되는 경우



 이렇게 각각의 QoS가 설정된 세 개의 queue가 있습니다. 그리고 각 큐는 할당된 task를 처리하기 위해 각각 `Thread 2`, `Thread 3`, `Thread 4`를 이용한다고 가정합니다.

![img](https://miro.medium.com/max/700/1*vAYiz2vlpfi7hZ50s0tOwA.png)

 우선 순위가 가장 낮은 `default Queue`에 가장 먼저 일(`task 1`)이 들어왔습니다. `Thread 4`는 `task 1`을 할당 받아 처리를 하는데, 이 때 해당 작업은 공유 자원 `a`를 필요로 합니다. 중간에 다른 곳에서 동시에 사용하지 못하게 잠금 처리도 해놓습니다. (자원을 배타적으로 사용)

![img](https://miro.medium.com/max/700/1*GNyQfkEl5NJArmZB91-_1g.png)

 도중에 두 번째 우선 순위를 가진 `userInitiated Queue`에 일(`task 2`)이 들어왔습니다. 이전에 실행되고 있던 작업은 우선 순위에 밀려 잠시 멈추게 되고, `Thread 3`에서 방금 들어온 `task 2`를 실행합니다.

![img](https://miro.medium.com/max/700/1*P82MNMFg250kEZy8qvPdQw.png)

> 동일한 Core에 여러 개의 논리 스레드가 할당되어 돌아가고 있는 상태를 가정하였습니다. (Time Slicing 기법에 의해 Concurrency를 획득하고, 다른 스레드의 작업을 위해서는 현재 스레드 작업을 멈추게 될 것입니다.)

 다시 도중에 첫번째 우선 순위를 가진 `userInteractive Queue`에 일(`task 3`)이 들어왔습니다. 이전에 실행되고 있던 작업(`task 2`)은 우선 순위에 밀려 잠시 멈추게 되고, `Thread 2`에서 방금 들어온 `task 3`을 실행합니다.

![img](https://miro.medium.com/max/700/1*4jNh3XwdQADnr5HZbZo6_Q.png)

 그런데 `task 3`은 공유 자원 `a`를 필요로 합니다. 자원 `a`는 이미 `task 1`에 사용되면서 잠겨있는 상태기 때문에 당장 `task 3`에서 사용할 수가 없습니다. 따라서 `task 3`도 잠시 멈추게 되고, `task 3`의 우선순위에 밀려 멈춰있던 `task 2`가 재개됩니다.

![img](https://miro.medium.com/max/700/1*e9RJb9jHPvYc5jHmyl8whg.png)

`task 2`가 끝나면 막혀있던 `task 1`도 재개됩니다.

![img](https://miro.medium.com/max/700/1*6wYZtfRd9Ftmr3_5mFgKlQ.png)

작업이 끝나면 자원 `a`의 사용도 끝나므로 비로소 `task 3`이 해당 자원을 점유 후 작업을 진행할 수 있게 됩니다.

![img](https://miro.medium.com/max/700/1*XVH7R56svsWWqvihMvPOGQ.png)

결국 작업은 `task 2` -> `task 1` -> `task 3` 순으로 완료됩니다. 즉 우선순위가 가장 높았던 `task 3`이 가장 늦게 실행되는 상황입니다.

이런 상황을 바로 동시성 문제 중 하나인 우선순위의 뒤바뀜이라고 할 수 있습니다.

 위의 예시를 통해 **high priority task가 필요한 자원을 low priority task가 잠그고 있는 경우** (자원을 배타적으로 사용) 작업의 **우선 순위가 바뀔** 수 있다는 것을 알아보았습니다.

이외에도 우선순위 뒤바뀜 문제가 발생할 수 있는 상황은 다음과 같습니다.

- **시리얼 큐**에서 **high** priority task가 **low** priority task의 **뒤에** 보내지는 경우
- **Operation**에서 **high** priority task가 **low** priority task에 **의존**하는 경우



#### 해결 방법

 **high** priority task가 **필요한 자원**을 **low** priority task가 **배타적으로 사용**하고 있는 경우에 발생하는 Priority Inversion 문제는 **GCD 자체적**으로 **우선 순위 조정**을 통해 문제를 해결합니다. (자원을 **점유**하고 있는 **task**의 **우선 순위를 높여**서 처리)

GCD에서 자체적으로 처리하는 것 외에도, **공유 자원을 접근할 때는 동일한 QoS를 사용**해야 Priority Inversion의 가능성을 줄일 수 있습니다. 



## 출처

https://jinshine.github.io/2018/07/09/iOS/GCD(Grand%20Central%20Dispatch)/

https://sujinnaljin.medium.com/