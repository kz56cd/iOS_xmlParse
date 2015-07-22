//
//  ViewController.swift
//  XMLParse01
//
//  Created by msano on 2015/07/22.
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

    func getDummyXML() {
        Alamofire
            .request(.GET, DUMMUY_URL ,parameters: nil)
            .response {request, response, data, error in
                println("API : " + request.URLString)
                if error != nil {
                    println("error : \(error)")
                } else { // 正常レスポンス
                    if let data: AnyObject = data {
                        self.parseXML(data: data)
                    } else {
                        println("error : missing data.")
                    }
                }
        }
    }
    
    func parseXML(#data: AnyObject) {
        
        var error: NSError?
        if let xmlDoc = AEXMLDocument(xmlData: data as! NSData, error: &error) {
            self.textArea.text = xmlDoc.xmlString // ログ表示

            // 最初の個人情報のみパースしてみる
            var firstRecord = xmlDoc.root["record"]
            var msg = firstRecord["name"].stringValue + "\n" +
                      firstRecord["ruby"].stringValue + "\n" +
                      firstRecord["mail"].stringValue + "\n" +
                      firstRecord["sex"].stringValue + "\n" +
                      firstRecord["age"].stringValue + "\n" +
                      firstRecord["birthday"].stringValue + "\n" +
                      firstRecord["keitai"].stringValue
            self.showAlert(msg: msg) // アラート表示
        }
    }
    
    func showAlert(#msg: String) {
        var ac       = UIAlertController(title: "record(1)", message: msg, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
        }
        ac.addAction(okAction)
        presentViewController(ac, animated: true, completion: nil)
    }
}

