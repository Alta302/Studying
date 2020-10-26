//
//  ViewController.swift
//  Calendar
//
//  Created by 정창용 on 2020/08/12.
//  Copyright © 2020 정창용. All rights reserved.
//

import UIKit
import FSCalendar

class ViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource { //Delegate랑 Datasource프로토콜은 거의 필수로 구현한다고 보시면 됩니다.
 
    @IBOutlet weak var calendar: FSCalendar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         
        calendar.cellShape = .Rectangle //선택된 날짜의 형태가 네모로 표시되도록
        calendar.allowsMultipleSelection = true //여러날짜를 동시에 선택할 수 있도록
        calendar.clipsToBounds = true //달력 구분 선 제거
         
        calendar.delegate = self
        calendar.dataSource = self
    }
 
    // 각 날짜에 특정 문자열을 표시할 수 있습니다. 이미지를 표시하는 메소드도 있으니 API를 참조하세요.
    func calendar(calendar: FSCalendar, subtitleForDate date: NSDate) -> String? {
        return "W"
    }
 
    // 특정 날짜를 선택했을 때, 발생하는 이벤트는 이 곳에서 처리할 수 있겠네요.
    func calendar(calendar: FSCalendar, didSelectDate date: NSDate) {
        print(date)
    }
     
    // 스와이프를 통해서 다른 달(month)의 달력으로 넘어갈 때 발생하는 이벤트를 이 곳에서 처리할 수 있겠네요.
    func calendarCurrentMonthDidChange(calendar: FSCalendar) {
        print(calendar)
    }
}
