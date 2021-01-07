# Alamofire 정리

### Alamofire란?

- Swift에서 HTTP 통신을 하기 위해 이용되는 대표적인 오픈소스 라이브러리
- Request & Response의 체이닝 함수 제공
- URL / JSON 형태의 파라미터 인코딩
- File / Data / Stream / MultipartFormData 등 업로드 기능
- HTTP Response의 Validation



### Request

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

