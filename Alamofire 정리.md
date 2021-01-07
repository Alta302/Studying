# Alamofire 정리

## Alamofire란?

- Swift에서 HTTP 통신을 하기 위해 이용되는 대표적인 오픈소스 라이브러리
- Request & Response의 체이닝 함수 제공
- URL / JSON 형태의 파라미터 인코딩
- File / Data / Stream / MultipartFormData 등 업로드 기능
- HTTP Response의 Validation



## Request

- **Request란, 이름 그대로 요청을 보내기 위해 사용하는 함수이다.**

Alamofire.request에는 다양한 인자가 존재한다.



**기본 사용법**

> Alamofire.request("URL")



HTTP Methods - **method**

Alamofire에는 HTTPMethod라는 열거형이 정의되어 있다.

```swift
public enum HTTPMethod: String {
  case options = "OPTIONS"
  case get = "GET"
  case head = "HEAD"
  case post = "POST"
  case put = "PUT"
  case patch = "PATCH"
  case delete = "DELETE"
  case trace = "TRACE"
  case connect = "CONNECT"
}
```



대표적인 method는 REST API에서 이용되는 get, post, put, delete를 인자로 전달할 수 있으며 사용은 아래와 같이 한다.

```swift
AF.request("https://google.com/get")
AF.request("https://google.com/post", method: .post)
AF.request("https://google.com/put", method: .put)
AF.request("https://google.com/delete", method: .delete)
```

get 메소드가 default기 때문에 get 메소드 사용시에는 따로 method 인자를 전달하지 않는다.



#### Prameter Encoding - parameters, encoding

- Alamofire는 URL, JSON, PropertyList 3가지 매개 변수 인코딩 유형을 지원한다.
- ParameterEncoding은 parameters 객체를 JSON 타입으로 인코딩 하는 것.
  - JSONEncoding
  - JSONEncoding은 parameters 객체를 JSON 타입으로 인코딩하는 것.

```swift
let param = [
  "name" : "Jeong Chang Yong",
  "age" : 18
]

Alamofire.request("https://google.com/post", method: .post, parameters: param, encoding: JSONEncoding.default)

// HTTP Body : { "name" : "Jeong Chang Yong", "age" : 18 }
```



#### Response Handling

Alamofire.request를 통해 입맛에 맞게 요청 값을 Handling이 가능하다.

아래는 간단한 Response Handling 예시이다.

```swift
AF.request("https://google.com/get").responseJSON {
  response in
  print("Request: \(String(describing: response.request))") // Original request
  print("Response: \(String(describing: response.response))") // Url response
  print("Result: \(response.result)") // response serialization
}
```

