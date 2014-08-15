//
//  ViewController.swift
//  HeyWeather
//
//  Created by Apple on 2014/8/15.
//  Copyright (c) 2014年 Mokoversity. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSURLConnectionDelegate {

    var data: NSMutableData = NSMutableData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        startConnection()
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
    }
}

