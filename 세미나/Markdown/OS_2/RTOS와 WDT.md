# RTOS와 WDT

## RTOS

 실시간 시스템(Real-Time System)은 임의의 정보가 시스템 내/외부에서 이벤트 혹은 인터럽트(interrupt)의 형태로 시스템에 입력되었을 때 주어진 시간 안에 작업이 완료되어 결과가 주어져야 하는 시스템입니다. 즉, 이벤트 발생과 처리가 실시간으로 이루어지는 시스템입니다. 물론 CPU의 처리 속도를 증가시킬 수도 있지만 속도는 느리더라도 이벤트 처리 시간을 보장할 수 있도록 하여야 한다는 의미입니다.

 RTOS(Real-Time Operating System) 없이 펌웨어를 제작하여도 모든 작업을 할 수는 있습니다. 예전의 시스템에서 펌웨어(firmware)는 비교적 간단해서 OS의 개념을 적용하지 않고 순차적인 프로그램만으로 작성했어도 그리 문제가 되지 않았습니다. 하지만 최근에 점점 더 소형 기기에 들어가는 기능이 다양해지고 Windows OS처럼 이벤트가 수 ms 정도에 처리되어도 가능한 상황과 달리, 임베디드 시스템(embedded system)에서는 훨씬 빠른 응답을 요구하여 순차적인 프로그래밍 방식으로는 기능을 구현하기에 어려워졌고 시간도 많이 걸려 다음의 장점으로 여러 개의 태스크(task)로 분할하여 개발할 필요가 있다는 것입니다. 왜냐하면 여러가지 일을 할 수 있는 순차적인 프로그램 방법으로 구현하면 프로그램의 복잡도가 일의 갯수의 승수에 비례하기 때문입니다.



### 장점

1. 코드의 개발, 수정, 유지, 보수가 보다 용이합니다.

2. 이벤트에 대해 보다 신속하게 응답할 수 있습니다. - 인터럽트가 발생하면, 진행 중인 태스크 대신 인터럽트를 처리할 태스크를 우선적으로 실행할 수 있습니다.

3. 시스템의 신뢰도와 성능을 높일 수 있습니다.



 한편 우선 순위 방식에는 2가지가 있는데, 우선 순위가 높은 태스크가 우선 순위가 낮은 태스크를 잠시 멈추게 하고 프로세서를 차지할 수 있는 권한이 부여되면 최근 대부분 OS가 그렇듯 선점형 우선순위(Preemptive)가 됩니다. 반면에 우선 순위가 높다 하더라도 우선 순위가 낮은 태스크가 완료할 때까지 기다려 주는 방식을 Windows 95이전의 OS와 같은 비선점형 우선순위(Non-preemptive)라 부릅니다.

 임베디드 시스템에서는 주로 선점형을 사용하는데, 우선 순위에 따라 프로세서의 사용 권한을 조정하는 것을 스케줄링(Scheduling)라고 부릅니다. 이와 같이 진행 중인 태스크가 바뀌게 되면 컨텍스트(Context)라고 불리는 기존의 태스크에 대한 정보를 저장하고 새로운 태스크를 불러오는 동작을 해야 하는데 이를 컨텍스트 스위칭(context switching)이라고 합니다. 또한 진행 중인 태스크들의 각종 정보를 태스크 컨트롤 블럭(TCB: Task control block)이라고 부릅니다. 다음은 선점형 OS에서 사용하는 스케줄링 방식입니다.



1. Priority Scheduling Algorithm

2. Round-Robin Scheduling Algorithm



 이처럼 예전에는 하드웨어 성능과 크기의 제약으로 OS 없이 단순한 기능만 수행 가능했던 것이 하드웨어 성능의 향상으로 다양한 일이 요구되었습니다. 이에 RTOS라는 OS 개념을 도입하여 각각의 태스크에 대한 스케줄링으로 자원을 효율적으로 사용할 수 있게 하고 복잡한 일들을 태스크로 나눔으로써 일을 단순화 시킬 수 있다는 것입니다. 뿐만 아니라 다음과 같은 까다로운 문제가 발생하는데, 이들 문제를 직접 해결하기 보다는 멀티태스킹(multi-tasking; 엄밀하게 multi-threading) OS를 도입하는 것이 훨씬 효과적이라는 것입니다. 근래에는 멀티태스킹 뿐 아니라 Network, File System, GUI도 구현하고 있습니다.



1. 태스크간 경쟁의 관리

2. 데드락(deadlock)

3. 우선 순위 역전(priority inversion)

4. 재진입 문제(reentrancy)

5. 태스크간 통신



### 일반적인 OS vs RTOS

- 효율성 / 시간 제약성 : 일반 OS 경우에 태스크들 사이에 효율성을 유지하려고 하지만 RTOS에서는 태스크에 시간 제약성이 존재하고 이런 시간 제약성 때문에 효율성을 무시하는 경우가 발생하며 효율성은 고려하지 않습니다.
- 공평성 / 우선순위 : 일반 OS 경우 여러명의 사용자가 쓰는 경우에는 각 사용자들이 실행하는 프로그램이 태스크로서 수행이 되고 대개의 경우에는 각 태스크가 공평성을 유지하려고 한다. 그러나 RTOS에서 태스크는 대개 우선순위가 차이가 있도록 하며 이 때 태스크 사이의 공평성은 고려하지 않습니다.



![img](https://t1.daumcdn.net/cfile/tistory/992A5E4B5A71980E06)



 결론적으로 RTOS는 시간의 정확성을 보장하는 멀티태스킹 호출과 인터럽트에 대한 반응시간의 최대값을 보장할 수 있고 실행시간의 편차가 작아야 하는데 즉, 작업의 소요시간을 예측할 수 있어야 합니다. 우선순위가 높은 일이 우선적으로 자원을 분배하여 시간 제한 내에 끝날 수 있도록 해야 합니다.



1. 다수의 작업에 우선 순위를 두어 멀티태스킹을 지원합니다.

2. 짧은 interrupt lattency - interrupt latency는 인터럽트가 걸려서 인터럽트 핸들러에 도착하기까지의 시간이며 이벤트에 의한 반응 속도가 빠릅니다.

3. 적은 용량의 kernel 사용 - 작고 유연한 구조(10 ~ 50 KB 수준)



## RTOS 환경에서 WDT 사용하기

 우주 환경에 장시간 노출된 상태에서 센서와 우주선 구성 요소를 테스트하는 NASA 위성인 클레멘타인은 1994년 1월 25일에 발사되었습니다. 몇 줄의 감시코드가 부족하여 1994년 5월 7일에 임무를 잃었습니다.

 클레멘타인은 달 궤도를 떠나 그녀의 다음 목표인 지구 근처의 소행성 Ceographos로 향했을 때 약 2개월 연속 달 지도를 수행했습니다. 그러나 곧 클레멘타인은 온보드 컴퓨터 중 하나에서 오작동이 발생하여 NASA가 우주선 작동을 효과적으로 차단하고 추진기 중 하나가 제어되지 않은 상태로 발사되도록 했습니다.

 NASA는 시스템을 다시 작동시키려고 20분을 보냈지만 소용이 없었습니다. 하드웨어 재설정 명령이 마침내 클레멘타인을 다시 온라인 상태로 만들었지만 너무 늦었습니다. 그녀는 이미 연료를 모두 사용했고 임무를 취소해야 했습니다.

 그 후 클레멘타인의 소프트웨어를 담당하는 개발팀은 그들이 구현한 소프트웨어 타임 아웃이 불충분하다는 것이 분명해졌을 때 하드웨어를 감시할 수 있는 WDT를 사용하기를 원했습니다.



### WDT 사용 방법

 그러나 WDT를 올바르게 사용하는 것은 카운터를 다시 시작하는 것만큼 간단하지 않습니다. (이 프로세스는 와치독을 "`feeding`" 또는 "`kick`"한다고 함) 시스템에서 WDT를 실행하는 경우 개발자는 오작동하는 시스템이 되돌릴 수 없는 악의적인 작업을 수행하기 전에 와치독이 개입할 수 있도록 와치독의 시간 초과 기간을 신중하게 선택해야 합니다.

 특히 RTOS를 사용하지 않는 간단한 애플리케이션에서 개발자는 일반적으로 메인 루프에서 와치독을 공급합니다. 이 접근 방식은 적절한 초기 카운터 값을 구성하기만 하면 되며, 이는 전체 메인 루프의 최악의 경우 실행 시간을 적어도 하나의 타이머 주기로 초과하는 값을 선택하는 것만큼 간단할 수 있습니다. 이것은 종종 상당히 강력한 접근 방식입니다. 일부 시스템은 즉각적인 복구가 필요하지만 다른 시스템은 무기한 중단되지 않도록 하기만 하면 됩니다. 그러면 작업이 확실히 완료됩니다.



### 멀티태스킹(RTOS) 환경

 그러나 보다 복잡한 시스템, 특히 멀티태스킹 시스템에서는 다양한 스레드가 다양한 경우와 다양한 이유로 잠재적으로 중단될 수 있습니다. 잠재적인 네트워크 통신을 기다리는 스레드와 같이 일부 스레드는 오랫동안 실행되지 않는 것이 좋습니다. 와치독에 주기적으로 공급하는 깨끗한 방법은 각각의 개별 프로세스가 양호한 상태인지 확인하는 동시에 다음과 같은 것을 적절히 체크하는 것이 시스템 개발자에게 중요한 과제가 되었습니다.

- OS가 제대로 실행되고 있는지 여부
- 우선 순위가 높은 작업이 CPU를 모두 소모하여 우선 순위가 낮은 작업이 실행되는 것을 방지하는지 여부
- 하나 또는 여러 작업의 실행을 방해하는 교착 상태가 발생했는지 여부
- 작업 루틴이 적절하고 전체적으로 실행되고 있는지 여부

 또한 개발자는 전용 WatchDog 작업이든 모니터링 되는 작업에 대한 특정 수정이든 소스코드에 수행된 모든 수정이 작게 이루어져야 하며 침입을 최소화하고 효율성을 높이기 위해 소스코드를 최적화해야 합니다.



### RTOS에서 WatchDog 사용하기

따라서 임베디드 전문가에게는 아래 두가지를 모두 허용하는 포괄적인 API 기능 세트가 필요하다는 것이 분명해집니다.

- 기본 embOS 감시 모듈을 사용하여 작업, 타이머 및 ISR을 개별적으로 등록하고
- 원하는 상황에서 의도한 감시 조건을 유연하게 테스트할 수 있는 가능성.



### 결론

 실제 시스템에서는 **MICOM**에 의해서 reset 되거나 **WDT**에 의해서 reset되는 경우에 어디까지 진행되었고, 어떤 이유로 reset 될 수 밖에 없었는지 파악하기 어렵습니다.

따라서, 디버깅용 WDT를 설정하여 MICOM 등이 reset되기 전에 `ISR` 루틴을 호출하게해 몇몇 정보를 출력하고 재부팅하게 해야합니다.

 많은 `System Reset`의 이유 중 대부분은 `WDT KICK Handler`와 동일한 `Handler`에서 많은 실시간 처리를 하는 경우, `WDT KICK Handler`의 처리가 밀리면서 `WDT KICK`을 처리하지 못해 카운트가 0이 되어 종료되는 것이었습니다. 혹은 반복적으로 돌아가는 while 문에서 메모리 누수가 발생하여 시스템이 비정상 종료가 될 수도 있을 것입니다. 따라서 이러한 것들과 관련된 로직을 면밀히 분석하고 고쳐나가다 보면 **WDT에 의한 비정상 시스템 종료 문제**를 해결할 수 있을 것입니다.



## 와치독 타이머 (WDT, Watchdog Timer)

### 1. 고신뢰성 시스템을 위한, 와치독 타이머

#### 가. WDT의 개념

- 비정상, 무한루프 등에 빠진 경우 시스템 통제가 불가능한 상황에서 자동으로 시스템을 리셋하는 하드웨어 기능입니다.
- 타임아웃이 되기 전 S/W 명령으로 그 값을 clear 시켜주지 않으면 MCU를 reset시켜 시스템을 정상적으로 동작하고 있는지 감시하고 지속적인 오동작을 방지 신뢰성 향상 기술입니다.



#### 나. WDT의 필요성

|              제어 실패 방지 매커니즘 필요               |               예상치 못한 실패 안전 모드 필요                |
| :-----------------------------------------------------: | :----------------------------------------------------------: |
| - 불필요한 반복 또는 제어 실패를 방지하는 매커니즘 필요 | - 시스템 일부가 예상 못한 제어 실패 시 안전 모드로 전환 필요 |



### 2. WDT 개념도 및 구성요소

#### 가. WDT 구성도

![img](http://blog.skby.net/blog/wp-content/uploads/2019/05/1.png)

- WDT는 H/W를 주기적으로 감시하며, 디바이스로부터 일정 시간 동안 입력값(Kick)을 받지 못하는 경우 시스템의 오동작 상황으로 간주하고 초기화 수행



#### 나. WDT 구성 요소

| 시그널                  | 내용                                                    |
| ----------------------- | ------------------------------------------------------- |
| Clock                   | H/W 디바이스를 동작시키는 외부 Clock Source             |
| Clear (Re-start / Kick) | H/W 디바이스가 정상 동작함을 알려주는 주기적 Alive 신호 |
| Timeout                 | 타이머가 종료되었음을 알려주는 Output 신호              |
| Reset                   | H/W 디바이스를 초기화할 수 있는 입력 시그널             |



### 3. WDT 유형 및 사례

#### 가. WDT 유형

| 유형     | 개념도                                                       | 설명                                                         |
| -------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 내부 WDT | ![img](http://blog.skby.net/blog/wp-content/uploads/2019/05/2.png) | - 대부분의 마이크로 컨트롤러에 내부 WDT 내장<br>- 별도 비용 없음<br>- 상대적 신뢰도 낮음<br>(S/W 문제 동작 오류 가능) |
| 외부 WDT | ![img](http://blog.skby.net/blog/wp-content/uploads/2019/05/3.png) | - 외부에 별도의 H/W 필요<br>- 별도 비용 필요<br/>- 프로세서에 물리적 리셋 핀 포함<br/>- 상대적 신뢰도 높음 |

- 외부 WDT는 고가이므로 높은 신뢰성 요구하는 시스템에 주로 사용



#### 나. WDT 구현 방법

| 구분           | 하드웨어 설계 방법                                           | 특징                                                         |
| -------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 단단계 WDT     | ![img](http://blog.skby.net/blog/wp-content/uploads/2019/05/4.png) | - 마이크로 컨트롤러 통합된 옵칩 형태<br>- CPU에 인접한 부분에 추가 H/W 단일칩 구성 |
| 다단계 WDT     | ![img](http://blog.skby.net/blog/wp-content/uploads/2019/05/5.png) | - 둘 이상의 타이머가 단계식으로 구성<br>- 차례로 시정 조치 작동, 마지막 단계에서 리셋 |
| 시정 조치 로직 | ![img](http://blog.skby.net/blog/wp-content/uploads/2019/05/6.png) | - 다단계 와치독 설계시 1단게 시정 조치로 NMI 통한 시스템 재설정<br>- 실패 시 Hard-reset |

- WDT 타이머는 고정 또는 프로그래밍 가능한 시간 간격 가능, 다단계 와치독의 각 타이머는 각 다른 시간 간격 가능



### 4. WDT 하드웨어 내부구조

![img](http://blog.skby.net/blog/wp-content/uploads/2019/05/7.png)

| 구성 요소                                 | 설명                                                         |
| ----------------------------------------- | ------------------------------------------------------------ |
| WDCR (Watchdog Control Register)          | - 와치독을 컨트롤하는 레지스터<br>- 리셋 상태 설정, 사용 여부, 로직 체크 |
| WDCNTR (Watchdog Counter Register)        | - 와치독 카운터의 상태 레지스터<br>- 현재까지 카운팅 된 값 확인 가능 |
| WDKEY (Watchdog Reset Key Register)       | - 와치독 카운터를 Clear하는 역할                             |
| SCSR (System Control and Status Register) | - 와치독 카운터 출력 신호 결과를 리셋 / 인터럽트에 이용 여부 결정 |

- 와치독 동작 컨트롤과 설정 및 상태 저장 레지스터로 구성



### 5. WDT 소프트웨어

#### 가. WDT 소프트웨어 동작 방식

| 상태      | 설명                                                         |
| --------- | ------------------------------------------------------------ |
| 정상 동작 | ![img](http://blog.skby.net/blog/wp-content/uploads/2019/05/8.png)<br>- 하드웨어 타이머를 시작하여 특정 숫자부터 카운트 다운하여 '0' 도달 시 수행 작업 정의<br>- 응용 프로그램이 WDT 시작 후 타이머가 주기적으로 '0'이 되지 않도록 재설정 |
| 오류 발생 | ![img](http://blog.skby.net/blog/wp-content/uploads/2019/05/9.png)<br>- 오류로 인해 응용 프로그램이 타이머를 재설정하지 못하면 하드웨어 카운터가 '0'에 도달<br>- WDT가 만료되면 하드웨어가 복구 절차 수행 |

- 와치독 소프트웨어는 타이머 만료 시 작업 정의 및 하드웨어 타이머 시작 후 주기적 타이머 초기화 수행



#### 나. WDT 소프트웨어 사례

| 소프트웨어 (소스코드)                                        | 설명                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| uInt16 volatile * pWatchdog = (uInt16 volatile *) 0xFF00;<br>main(void) {<br>    hwinit();<br><br>    for (;;) { **// continuous loop**<br>        * pWatchdog = 10000; **// set the watchdog timer**<br>        read_sensors();<br>        control_motor();<br>        display_status();<br>    }<br>} | [WDT]<br>- 타이머가 만료되면 시스템을 리셋하기 위한 신호 전송<br><br>[소프트웨어]<br>- 프로그램 루프 실행 동안 WDT 카운트 초기화<br>- 프로그램 동작이 정상이면 주기적 카운트 초기화<br>- 루프 명령 실행 실패 시 카운트 초기화 불가하므로, 타이머가 말료로 시스템 리셋 |



## 출처

https://coder-in-war.tistory.com/entry/RTOS-08-RTOS-%ED%99%98%EA%B2%BD%EC%97%90%EC%84%9C-%EC%9B%8C%EC%B9%98%EB%8F%85-%ED%99%9C%EC%9A%A9%ED%95%98%EA%B8%B0

http://blog.skby.net/%EC%9B%8C%EC%B9%98%EB%8F%85-%ED%83%80%EC%9D%B4%EB%A8%B8-wdt-watchdog-timer/