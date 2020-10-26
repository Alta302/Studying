//
//  ViewController.swift
//  WeatherMan
//
//  Created by 정창용 on 2020/08/12.
//  Copyright © 2020 정창용. All rights reserved.
//

import UIKit

struct City {
    let id: String
    let name: String
}

class ViewController: UIViewController {
    let appid = "1f166a2cc7139328184e74d0215b3bb5"
    let session = URLSession(configuration: .default)
    let cities = [City(id: "1832501", name: "영광"),
                  City(id: "1832566", name: "영동"),
                  City(id: "1832663", name: "영암군청"),
                  City(id: "1832743", name: "여주"),
                  City(id: "1832771", name: "예산"),
                  City(id: "1835224", name: "대전"),
                  City(id: "1843841", name: "내집")]
    var task: URLSessionDataTask?
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var feelsTempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        picker.delegate = self
        picker.dataSource = self
        
        cityNameLabel.text = cities[0].name
        request(cities[0].id)
    }
    
    func request(_ cityid: String) {
        var components = URLComponents(string: "http://api.openweathermap.org/data/2.5/weather")
        components?.queryItems = [URLQueryItem(name: "id", value: cityid), URLQueryItem(name: "appid", value: appid)]
        
        guard let url = components?.url else { return }
        
        let request = URLRequest(url: url)
        
        task = session.dataTask(with: request) { [weak self] data, response, error in
            defer { self?.task = nil }
            
            guard let data = data, let dic = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            
            if let temp = (dic["main"] as? [String: Any])?["temp"] as? Float64,
                let feelsTemp = (dic["main"] as? [String: Any])?["feels_like"] as? Float64,
                let description = (dic["weather"] as? [AnyObject])?.first?["description"] as? String {
                
                DispatchQueue.main.async {
                    self?.tempLabel.text = "온도: \(round((temp - 273.15) * 10) / 10)"
                    self?.feelsTempLabel.text = "체감온도: \(round((feelsTemp - 273.15) * 10) / 10)"
                    switch (description) {
                    case "clear sky":
                        self?.descriptionLabel.text = "맑음"
                    case "few clouds":
                        self?.descriptionLabel.text = "흐림"
                    default:
                        self?.descriptionLabel.text = description
                    }
                    
                    self?.descriptionLabel.text = description
                    
                }
            }
        }
        
        task?.resume()
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cityNameLabel.text = cities[row].name
        request(cities[row].id)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
}
