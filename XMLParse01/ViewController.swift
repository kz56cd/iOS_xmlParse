//
//  ViewController.swift
//  XMLParse01
//
//  Created by 業務委託スタッフ on 2015/07/22.
//  Copyright (c) 2015年 msano. All rights reserved.
//

import UIKit
import Alamofire
import AEXML

class ViewController: UIViewController {

    let DUMMUY_URL = "https://dl.dropboxusercontent.com/s/cc185bc4ku12gab/dummy01.xml?dl=0"
    @IBOutlet weak var textArea: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func getBtnTapped(sender: AnyObject) {
        self.getDummyXML()
    }

//    func getDummyJson(completion: (Array<Shop>) -> ()) -> () {
    func getDummyXML() {
        Alamofire
            .request(.GET, DUMMUY_URL ,parameters: nil)
            .response {request, response, data, error in
                println("API : " + request.URLString)
                
                if error != nil {
                    println("error : \(error)")
                } else { // 正常レスポンス
                    if let data: AnyObject = data {
//                        println("data : \(data)")
                        self.parseXML(data: data)
                    } else {
                        println("error : XML parse failure.")
                    }
                }
        }
    }
    
    func parseXML(#data: AnyObject) {
        
        var error: NSError?
        if let xmlDoc = AEXMLDocument(xmlData: data as! NSData, error: &error) {
            // ログ表示
            self.textArea.text = xmlDoc.xmlString
        }
    }
}

