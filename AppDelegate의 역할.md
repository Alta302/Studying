# AppDelegate의 역할

UITableViewDelegate를 구현하다 => UITableView에서 필요한 기능을 대신 구현하다라는 느낌으로 AppDelegate는 App(Application)이 해야할 일을 대신 구현한다는 의미



App이 해야할 일 => Background 진입, Foreground 진입, 외부에서의 요청(apns) 등



## @UIApplicationMain

```swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
```

실제로 앱은 UIApplication이라는 객체로 추상화되어 Run Loop를 통해 프로그램 코드를 실행. 개발자는 AppDelegate를 통해 UIApplication의 역할의 일부를 위임 받아 UI를 그리면서 앱다운 앱이 탄생.