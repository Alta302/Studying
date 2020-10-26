//
//  ViewController.swift
//  UpAndDown
//
//  Created by 정창용 on 2020/09/05.
//  Copyright © 2020 정창용. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel! // 업인지 다운인지 정답인지 알려주는 레이블
    @IBOutlet var turnCountLabel: UILabel! // 숫자를 넣을 때마다 카운트해주는 레이블
    @IBOutlet var inputField: UITextField! // 사용자가 숫자를 넣는 텍스트필드
    
    var randomNumber: UInt32 = 0 // 정답
    var turnCount: Int = 0 // 숫자를 넣을 때마다 1씩 증가
    
    @IBAction func touchUpSubmitButton(_ sender: UIButton) {
        guard let inputText = self.inputField.text,
            inputText.isEmpty == false else {
                print("입력 값이 없어요!")
                return
        } // guard 뒤에 따라붙는 코드의 실행 결과가 true일 때 코드가 계속 실행
        
        guard let inputNumber: UInt32 = UInt32(inputText) else {
            print("입력 값이 잘못되었어요!")
            return
        } // guard 뒤에 따라붙는 코드의 실행 결과가 true일 때 코드가 계속 실행
        
        turnCount += 1 // 확인 버튼을 넣을 때마다 카운트에 1씩 증가
        self.turnCountLabel.text = "\(turnCount)" // 레이블에 표시
        
        if inputNumber > randomNumber {
            self.resultLabel.text = "업!" // 넣은 값이 정답보다 클 경우 "업!" 출력
        } else if inputNumber < randomNumber {
            self.resultLabel.text = "다운!" // 넣은 값이 정답보다 작을 경우 "다운!" 출력
        } else {
            self.resultLabel.text = "정답입니다!!" // 넣은 값이 정답보다 클 경우 "정답입니다!!" 출력
        }
        
    } // 확인 버튼
    
    @IBAction func touchUpResetButton(_ sender: UIButton) {
        self.initializeGame()
    } // 리셋 버튼을 누를 시에 리셋 함수를 불러옴
    
    func initializeGame() {
        
        self.randomNumber = arc4random() % 25 // 정답을 랜덤으로 생성
        self.turnCount = 0 // 카운트를 리셋
        
        self.resultLabel.text = "시작!" // 함수를 불러올 시 레이블에 "시작!" 출력
        self.turnCountLabel.text = "\(turnCount)" // 함수를 불러올 시 레이블에 카운트를 표시(카운트를 리셋했으니 표시되는 숫자는 0
        self.inputField.text = nil // 텍스트필드를 비움
        
        print("임의의 숫자 \(self.randomNumber)") // 정답을 출력(앱에서는 안나옴)(왜?)
        
    } // 리셋 함수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeGame() // 시작 화면에 initializeGame 함수를 불러옴
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

