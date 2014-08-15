//
//  ViewController.swift
//  HeyWeather
//
//  Created by Apple on 2014/8/15.
//  Copyright (c) 2014年 Mokoversity. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSURLConnectionDelegate {
    
    @IBOutlet var temperature: UILabel!
    @IBOutlet var icon: UIImageView!

    // 使用 NSMutableData 儲存下載資料
    var data: NSMutableData = NSMutableData()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        startConnection()
        
        let background = UIImage(named: "background_sunday.png")
        self.view.backgroundColor = UIColor(patternImage: background)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func startConnection() {
        var restAPI: String = "http://api.openweathermap.org/data/2.5/weather?q=Taipei"
        var url: NSURL = NSURL(string: restAPI)
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)
        
        println("start download")
    }

    // -- 
    // -- Section: NSURLConnectionDelegate protocol
    // --
    
    // 開始新的 request
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        // Recieved a new request, clear out the data object
        println("new request")
    }
    
    // 下載中
    func connection(connection: NSURLConnection!, didReceiveData dataReceived: NSData!) {
        println("downloading")

        self.data.appendData(dataReceived)
    }
    
    // 下載完成
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        println("finished")

        // 解析 JSON
        // 使用 NSDictionary: NSDictionary 是一種 Associative Array 的資料結構
        var error: NSError?
        let jsonDictionary = NSJSONSerialization.JSONObjectWithData(self.data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary

        // 讀取各項天氣資訊
        let temp: AnyObject? = jsonDictionary["main"]?["temp"]
        
        // use '?' to downcast to NSArray
        if let weather = jsonDictionary["weather"]? as? NSArray {
            // Safe code 寫作觀念:
            // 使用 as? 轉型時，要把以下這行放進 if statement 裡處理
            let weatherDictionary = (weather[0] as NSDictionary)
            // 天氣狀態 (多雲、晴朗等等)
            updateWeatherConditionIcon(weatherDictionary["id"] as Int)
        }
        
        // 資料處理
        let weatherTempCelsius = Int(round((temp!.floatValue - 273.15)))
        let weatherTempFahrenheit = Int(round(((temp!.floatValue - 273.15) * 1.8) + 32))

        // 測試輸出
        println("temp: \(weatherTempCelsius)℃")
        
        // 輸出到 UI
        self.temperature.font = UIFont.boldSystemFontOfSize(48)
        self.temperature.text = "\(weatherTempCelsius)℃"
    }
    
    // 解讀 Weather Condition Code
    // See: http://bugs.openweathermap.org/projects/api/wiki/Weather_Condition_Codes
    func updateWeatherConditionIcon(weatherId: Int) {
        println("weather ID: \(weatherId)")
        
        switch weatherId {
        case 801, 802, 803, 804:
            self.icon.image = UIImage(named: "cloudy")
        default:
            println("no weather icon")
        }
    }
}

