//
//  ViewController.swift
//  TodoList
//
//  Created by 정창용 on 2021/05/11.
//

import UIKit

var todolist = [TodoList]()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var TableView : UITableView!
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.delegate = self
        TableView.dataSource = self
        
        let data = userDefaults.array(forKey: "item")
        
        print(data)
        
//        for i in data {
//            let item: TodoList = TodoList(todoTitle: data[i]., todoText: <#T##String#>)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        TableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todolist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = todolist[indexPath.row].todoTitle
        cell.detailTextLabel?.text = todolist[indexPath.row].todoText

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            todolist.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    func saveData() {
        let data = todolist.map {
            [
                "title" : $0.todoTitle,
                "content" : $0.todoText
            ]
        }
        
        userDefaults.set(data, forKey: "item")
        userDefaults.synchronize()
        
        let types = type(of: data)
        print("\(data) and \(types)")
    }
    
    @IBAction func tableView(_ sender : UIBarButtonItem){
        if TableView.isEditing{
            TableView.setEditing(false, animated: true)
        } else {
            TableView.setEditing(true, animated: true)
        }
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        saveData()
    }
}
