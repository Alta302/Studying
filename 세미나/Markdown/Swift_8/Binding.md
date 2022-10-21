# Binding

바인딩에 가장 일반적인 방법 또는 방향 중 두 가지는

> 1. View to ViewModel 바인딩
> 2. ViewModel to View 바인딩

입니다.



## View to ViewModel

아래 사진과 같이 이름과 나이를 쓰는 텍스트필드 박스가 있고, 특정 화면을 제어하거나 표시하는 **ViewModel**이 있습니다.

만약 이름과 나이를 입력하면 **UserViewModel**의 **name** / **age** 속성에 바인딩됩니다. 자동으로 **name** / **age** 속성을 업데이트 해야함을 의미합니다. 이것이 **SwiftUI**에서 바인딩을 사용해야 하는 이유입니다.

![img](https://blog.kakaocdn.net/dn/Xsrrw/btqW4hjwUpo/eH5v0nBM9rwFYPj5OaEIx1/img.png)



## ViewModel to View

바인딩을 보기 위한 뷰입니다. **ViewModel**의 **name** / **age**가 변경될 때마다 **TextField**의 **name** / **age**가 변경되는 것입니다.

만약 **ViewModel**에 '서근'과 '26'을 작성하면 자동으로 **TextField**에 텍스트를 업데이트 합니다.

![img](https://blog.kakaocdn.net/dn/xVXQx/btqWUpqm69z/E0BlSm3wvfPjpEc0ho97e0/img.png)

