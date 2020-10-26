//
//  ViewController.swift
//  ToDoList
//
//  Created by 정창용 on 2020/09/24.
//  Copyright © 2020 정창용. All rights reserved.
//

import UIKit

// 할일 저장 리스트 (전역변수)
var list = [TodoList]()

// todoList Scene과 연결되어 있는 VC
class TodoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var todoListTableView: UITableView! // 테이블뷰 선언
    @IBOutlet weak var editButton: UIBarButtonItem! // edit 버튼 선언
    
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonTap)) // edit 버튼을 눌렀을 때 나오는 버튼
    
    // 뷰를 처음 로드
    override func viewDidLoad() {
        super.viewDidLoad() // 뷰 불러오기
        
        todoListTableView.delegate = self // delegate 불러오기
        todoListTableView.dataSource = self // datasource 불러오기
        
        doneButton.style = .plain // done 버튼의 스타일을 plane으로 지정
        doneButton.target = self // done 버튼의 타겟을 셀프로 지정
        
    }
    
    // 뷰가 다시 나올 때 실행되는 함수
    override func viewDidAppear(_ animated: Bool) {
        todoListTableView.reloadData() // 테이블 목록을 재구성하는 코드
        
    }
    
    // done 버튼을 눌렀을 때 실행되는 함수
    @objc func doneButtonTap() {
        self.navigationItem.leftBarButtonItem = editButton // 네비게이션 아이템의 왼쪽 바 버튼을 edit 버튼으로 수정
        todoListTableView.setEditing(false, animated: true) // 테이블뷰 에디팅 모드 종료
        
    }
    
    // edit 버튼을 눌렀을 때 실행되는 함수
    @IBAction func editButtonAction(_ sender: Any) {
        // 리스트 비어있을 때 리턴
        guard !list.isEmpty else {
            return
        }
        
        self.navigationItem.leftBarButtonItem = doneButton // 네비게이션 아이템의 왼쪽 바 버튼을 done 버튼으로 수정
        todoListTableView.setEditing(true, animated: true)  // 테이블뷰 에디팅 모드 실행
        
    }
    
    // userdefault 저장
    func saveAllData() {
        let data = list.map {
            [
                "title": $0.title,
                "content": $0.content!,
                "isComplete": $0.isComplete
            ]
            
        }
     
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "items") // 키, value 설정
        userDefaults.synchronize()  // 동기화
        
    }
    
    // n번째 섹션의 m번째 row를 그리는데 필요한 cell을 반환하는 메소드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row].title
        cell.detailTextLabel?.text = list[indexPath.row].content
        
        if list[indexPath.row].isComplete {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        } // 체크마크의 유무를 정하는 if 문
         
        return cell // 셀을 반환
        
    }
     
    // n번째 섹션에 몇개의 row가 있는지 반환하는 함수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count; // 리스트의 수만큼 반환
        
    }
    
    // 수정 모드
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        list.remove(at: indexPath.row) // 리스트를 삭제
        todoListTableView.reloadData() // todoList 테이블뷰의 데이터를 갱신
        
    }
    
    // 리스트 선택시 완료된 일로 표시하는 함수
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 이미 체크되있는 경우 return
        guard !list[indexPath.row].isComplete else {
            return
        }
         
        // 리스트 선택 시 완료된 할일 표시
        list[indexPath.row].isComplete = true
        
        let dialog = UIAlertController(title: "알림", message: "할일을 완료했습니다.", preferredStyle: .alert) // 알림 내용
        let action = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) // 알림 동작
        
        dialog.addAction(action) // 액션 추가
        
        self.present(dialog, animated: true, completion: nil) // 알림 실행
        
        todoListTableView.reloadData() // todoList 테이블뷰의 데이터를 갱신
        
    }

}

// 결론: 코딩 하다가 머리 빠질 것 같다.

