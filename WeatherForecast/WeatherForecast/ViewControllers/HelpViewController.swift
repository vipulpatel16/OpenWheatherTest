//
//  HelpViewController.swift
//  WeatherForecast
//
//  Created by Vipul on 25/08/21.
//

import UIKit
import WebKit

class HelpViewController: UIViewController {
    
    @IBOutlet weak var webView : WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Help"
        prepareView()
        // Do any additional setup after loading the view.
    }
    
    private func prepareView() {
        // Adding webView content
            do {
                guard let filePath = Bundle.main.path(forResource: "ReadMe", ofType: "html")
                    else {
                        // File Error
                        print ("File reading error")
                        return
                }

                let contents =  try String(contentsOfFile: filePath, encoding: .utf8)
                let baseUrl = URL(fileURLWithPath: filePath)
                webView.loadHTMLString(contents as String, baseURL: baseUrl)
            }
            catch {
                print ("File HTML error")
            }
    }

}
