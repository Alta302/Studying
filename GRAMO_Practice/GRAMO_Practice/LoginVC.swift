//
//  LoginVC.swift
//  GRAMO
//
//  Created by 정창용 on 2021/02/10.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    // 프로퍼티
    var userModel = UserModel() // Model의 인스턴스 생성
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // ViewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        self.usernameTextField.becomeFirstResponder()
        
    }

//    // SignIn 버튼을 눌렀을 때의 Action
//    @IBAction func didTapLoginButton(_ sender: UIButton) {
//        // 옵셔널 바인딩 & 예외 처리 : Textfield가 빈문자열이 아니고, nil이 아닐 때
//        guard let username = usernameTextField.text, !username.isEmpty else { return }
//        guard let password = passwordTextField.text, !password.isEmpty else { return }
//        
//        // Model이 해당 유저를 가지고 있는지 검사
//        let loginSuccess: Bool = userModel.hasUser(name: username, pwd: password)
//        if loginSuccess {
//            print("로그인 성공")
//            let main = MainVC() // MainViewController() : main으로 넘어가기
//            self.present(main, animated: true, completion: nil) // present
//            
//        } else {
//            UIView.animate(withDuration: 0.2, animations: {
//                self.usernameTextField.frame.origin.x -= 10
//                self.passwordTextField.frame.origin.x -= 10
//                
//            }, completion: { _ in
//                UIView.animate(withDuration: 0.2, animations: {
//                    self.usernameTextField.frame.origin.x += 20
//                    self.passwordTextField.frame.origin.x += 20
//                    
//                }, completion: { _ in
//                    UIView.animate(withDuration: 0.2, animations: {
//                        self.usernameTextField.frame.origin.x -= 10
//                        self.passwordTextField.frame.origin.x -= 10
//                        
//                    })
//                    
//                })
//                
//            })
//            
//        }
//        
//    }
    
    @objc func didEndOnExit(_ sender: UITextField) {
        if usernameTextField.isFirstResponder {
            
            passwordTextField.becomeFirstResponder()
        }
        
    }

//    // Segue, 할일을 하기 직전에 클로저를 담아서 보내줘 : prepare
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // segue.destination은 UIViewController의 상속을 받은 Down캐스팅(형변환)이기 때문에 안전하게 옵셔널 체이닝
//        // segue.source 는 previous ViewController인 SignInViewController
//        if let nextViewController = segue.destination as? SignUpViewController {
//            // SignUpViewController의 didTaskClosure에 클로저를 만들어서 담아 보낸다.
//            nextViewController.didTaskClosure = {
//                (name: String, password: String) -> Void in return
//                self.userModel.addUser(name: name, pwd: password)
//
//            }
//
//        }
//
//    }

}

