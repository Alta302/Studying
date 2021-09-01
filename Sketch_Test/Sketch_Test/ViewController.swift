//
//  ViewController.swift
//  Sketch_Test
//
//  Created by 정창용 on 2021/03/04.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imgView: UIImageView! // 이미지 뷰, 스케치 할 곳
    @IBOutlet var redBtn: UIButton! // 색 변경(레드)
    @IBOutlet var greenBtn: UIButton! // 색 변경(그린)
    @IBOutlet var blackBtn: UIButton! // 색 변경(블랙)
    
    var lastPoint: CGPoint! // 포인트
    var lineSize: CGFloat = 2.0 // 선의 사이즈
    var lineColor = UIColor.black.cgColor // 선의 기본 컬러

    override func viewDidLoad() { // View Controller의 생명주기, 뷰의 컨트롤러가 메모리에 로드되고 난 후에 호출
        super.viewDidLoad()
        
        self.redBtn.layer.cornerRadius = 15 // 버튼 모서리 둥글게
        self.greenBtn.layer.cornerRadius = 15 // 버튼 모서리 둥글게
        self.blackBtn.layer.cornerRadius = 15 // 버튼 모서리 둥글게
        
    }
    
    @IBAction func clearImageView(_ sender: UIButton){ // 초기화 버튼
        imgView.image = nil // 이미지뷰의 이미지를 초기화하는 명령어
        
    }
    
    @IBAction func redBtn(_ sender: UIButton) { // 색 변경 버튼(레드)
        lineColor = UIColor.red.cgColor // 색이 레드가 아닐 경우 색을 레드로 변경
        
    }
    
    @IBAction func greenBtn(_ sender: UIButton) { // 색 변경 버튼(그린)
        lineColor = UIColor.green.cgColor // 색이 그린이 아닐 경우 색을 그린으로 변경
        
    }
    
    @IBAction func blackBtn(_ sender: UIButton) { // 색 변경 버튼(블랙)
        lineColor = UIColor.black.cgColor // 색이 블랙이 아닐 경우 블랙으로 변경
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { // 사용자가 처음으로 화면을 터치할 때 호출되는 메서드
        let touch = touches.first! as UITouch //
        
        lastPoint = touch.location(in: imgView) //
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        
        let touch = touches.first! as UITouch
        let currPoint = touch.location(in: imgView)
        
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height))
        
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currPoint.x, y: currPoint.y))
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        lastPoint = currPoint
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height))
        
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            imgView.image = nil
            
        }
        
    }

}

